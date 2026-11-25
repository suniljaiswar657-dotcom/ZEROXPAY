-- ZEROXPAY Backend V1
-- Simulator-only schema. No real payment rails or stored-value wallet.
-- Apply only to a dedicated ZEROXPAY Supabase project.

create extension if not exists pgcrypto;

create schema if not exists private;
revoke all on schema private from public, anon, authenticated;

create type public.app_role as enum ('customer', 'merchant', 'admin');
create type public.merchant_review_status as enum ('pending', 'approved', 'rejected', 'suspended');
create type public.demo_transaction_status as enum ('created', 'processing', 'succeeded', 'failed', 'cancelled');

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null default '',
  phone text,
  role public.app_role not null default 'customer',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint profiles_display_name_length check (char_length(display_name) <= 80),
  constraint profiles_phone_length check (phone is null or char_length(phone) <= 20)
);

create table public.merchant_accounts (
  id uuid primary key default gen_random_uuid(),
  owner_user_id uuid not null unique references public.profiles(id) on delete restrict,
  business_name text not null,
  business_type text,
  review_status public.merchant_review_status not null default 'pending',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint merchant_business_name_length check (char_length(business_name) between 2 and 120)
);

create table public.demo_transactions (
  id uuid primary key default gen_random_uuid(),
  reference_code text not null unique default ('ZXP-DEMO-' || upper(substr(encode(gen_random_bytes(8), 'hex'), 1, 12))),
  initiated_by uuid not null references public.profiles(id) on delete restrict,
  merchant_account_id uuid references public.merchant_accounts(id) on delete restrict,
  recipient_label text not null,
  amount_paise bigint not null,
  currency char(3) not null default 'INR',
  status public.demo_transaction_status not null default 'created',
  note text,
  idempotency_key text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint demo_amount_positive check (amount_paise between 100 and 100000000),
  constraint demo_currency_inr check (currency = 'INR'),
  constraint demo_recipient_length check (char_length(recipient_label) between 1 and 80),
  constraint demo_note_length check (note is null or char_length(note) <= 160),
  constraint demo_idempotency_key_length check (char_length(idempotency_key) between 8 and 128),
  constraint demo_initiator_idempotency_unique unique (initiated_by, idempotency_key)
);

create table public.ledger_entries (
  id uuid primary key default gen_random_uuid(),
  transaction_id uuid not null references public.demo_transactions(id) on delete restrict,
  account_user_id uuid not null references public.profiles(id) on delete restrict,
  entry_type text not null check (entry_type in ('demo_debit', 'demo_credit', 'demo_fee')),
  amount_paise bigint not null check (amount_paise > 0),
  currency char(3) not null default 'INR' check (currency = 'INR'),
  created_at timestamptz not null default now()
);

create table public.audit_events (
  id uuid primary key default gen_random_uuid(),
  actor_user_id uuid references public.profiles(id) on delete set null,
  event_type text not null,
  resource_type text not null,
  resource_id uuid,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  constraint audit_event_type_length check (char_length(event_type) between 2 and 80),
  constraint audit_resource_type_length check (char_length(resource_type) between 2 and 80)
);

create index demo_transactions_initiator_created_idx
  on public.demo_transactions (initiated_by, created_at desc);
create index ledger_entries_account_created_idx
  on public.ledger_entries (account_user_id, created_at desc);
create index audit_events_actor_created_idx
  on public.audit_events (actor_user_id, created_at desc);
create index merchant_accounts_status_created_idx
  on public.merchant_accounts (review_status, created_at desc);

-- Profile bootstrap: role is always customer; user-editable metadata never grants privileges.
create or replace function private.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.profiles (id, display_name)
  values (
    new.id,
    coalesce(nullif(left(new.raw_user_meta_data ->> 'display_name', 80), ''), '')
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

revoke all on function private.handle_new_user() from public, anon, authenticated;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function private.handle_new_user();

create or replace function private.set_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger profiles_set_updated_at
  before update on public.profiles
  for each row execute function private.set_updated_at();

create trigger merchant_accounts_set_updated_at
  before update on public.merchant_accounts
  for each row execute function private.set_updated_at();

create trigger demo_transactions_set_updated_at
  before update on public.demo_transactions
  for each row execute function private.set_updated_at();

-- RLS on every exposed public table.
alter table public.profiles enable row level security;
alter table public.merchant_accounts enable row level security;
alter table public.demo_transactions enable row level security;
alter table public.ledger_entries enable row level security;
alter table public.audit_events enable row level security;

-- Explicit API privileges. RLS further restricts rows.
grant select on public.profiles to authenticated;
grant update (display_name, phone) on public.profiles to authenticated;
grant select, insert on public.merchant_accounts to authenticated;
grant select on public.demo_transactions to authenticated;
grant select on public.ledger_entries to authenticated;
grant select on public.audit_events to authenticated;

create policy "profiles_select_own"
  on public.profiles for select to authenticated
  using ((select auth.uid()) = id);

create policy "profiles_update_own"
  on public.profiles for update to authenticated
  using ((select auth.uid()) = id)
  with check ((select auth.uid()) = id);

create policy "merchant_accounts_select_owner"
  on public.merchant_accounts for select to authenticated
  using ((select auth.uid()) = owner_user_id);

create policy "merchant_accounts_insert_pending_self"
  on public.merchant_accounts for insert to authenticated
  with check (
    (select auth.uid()) = owner_user_id
    and review_status = 'pending'
  );

create policy "demo_transactions_select_initiator"
  on public.demo_transactions for select to authenticated
  using ((select auth.uid()) = initiated_by);

create policy "ledger_entries_select_owner"
  on public.ledger_entries for select to authenticated
  using ((select auth.uid()) = account_user_id);

create policy "audit_events_select_actor"
  on public.audit_events for select to authenticated
  using ((select auth.uid()) = actor_user_id);

-- No authenticated insert/update/delete on transactions, ledger, or audit events.
-- Those writes must go through a future authenticated Edge Function with validation,
-- rate limiting, idempotency and server-side authorization. No service key in browser.
