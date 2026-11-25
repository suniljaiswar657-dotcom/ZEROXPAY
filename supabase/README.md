# Supabase setup for ZEROXPAY

The migration in this folder is designed for a dedicated ZEROXPAY Supabase project.

Before applying:
- Verify the project name and project ref in the Supabase Dashboard.
- Do not apply this SQL to unrelated projects.
- Review the SQL migration and keep its file in Git.

After applying:
- Verify RLS is enabled on profiles, merchant_accounts, demo_transactions, ledger_entries and audit_events.
- Verify authenticated users cannot insert/update/delete demo_transactions, ledger_entries or audit_events.
- Run Security Advisors.
- Configure Auth redirect URLs and email confirmation.

The app must use a publishable key only. Never commit .env files, database passwords, access tokens, service-role keys or secret keys.
