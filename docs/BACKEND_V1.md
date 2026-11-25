# ZEROXPAY Backend V1

## Status
Repository backend foundation only. This migration has not been applied to a hosted database.
No Supabase project is currently designated for ZEROXPAY.

## Stack
- Supabase Auth for identity and sessions.
- PostgreSQL for profiles, merchant applications, demo transactions, ledger entries and audit events.
- Row Level Security on every public table.
- Edge Functions (next implementation step) for server-authoritative simulator writes.

## Tables
| Table | Purpose | Client write policy |
|---|---|---|
| profiles | User profile and role | Own display name/phone only |
| merchant_accounts | Merchant application and review state | User may submit own pending application |
| demo_transactions | Synthetic simulator transaction record | Read own only |
| ledger_entries | Append-only demo ledger | Read own only |
| audit_events | Security/operations event trail | Read own actor events only |

## Role model
- New signups always receive `customer`.
- `merchant` is assigned only after a trusted server-side review workflow.
- `admin` is provisioned only by a trusted operator/server process.
- Never use user-editable Auth metadata for authorization.

## Apply safely
1. Create a new Supabase project named `ZEROXPAY`; do not reuse unrelated projects.
2. In Supabase SQL Editor, review and apply `supabase/migrations/20261125000100_backend_v1.sql`.
3. Confirm all five public tables have RLS enabled.
4. Run Supabase Security Advisors and resolve relevant findings.
5. Configure Auth email confirmation and redirect URLs for the actual deployed domain.
6. Add only the Supabase project URL and publishable key to the browser app. Never expose a service-role/secret key.

## Important boundaries
- This is a demo ledger, not a wallet, deposit account, or stored-value facility.
- No UPI, IMPS, NEFT, card, bank, or wallet rails are connected.
- No real balance is held or moved.
- The current static simulator UI is not yet wired to Supabase.
- A future Edge Function must create demo transaction and ledger rows atomically; browser clients must never write ledger entries directly.
- Do not label any demo transaction as a real payment or settlement.
