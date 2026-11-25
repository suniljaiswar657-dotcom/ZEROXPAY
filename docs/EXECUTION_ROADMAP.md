# ZEROXPAY — Execution Roadmap

**Version:** 1.0 | **Date:** 25 November 2026

## Delivery strategy

Build a credible, testable software product first. Keep real payment connectivity disabled until the legal operating model and regulated-partner approvals are complete. Every phase has a measurable exit gate.

## Phase 0 — Foundation

**Deliverables**
- Product requirements and user journeys.
- System context, trust boundaries, and data-flow diagrams.
- Threat model and security baseline.
- Brand tokens: Black Chrome, Titanium Silver, Electric Blue.
- Repository conventions, CI checks, environments, release process.
- Legal/compliance question register for counsel and partner discussions.

**Exit gate:** product scope documented; simulator/live boundary technically enforceable; no production payment credentials or endpoints.

## Phase 1 — Simulator MVP

**Build**
1. Responsive web shell and Android-ready UI foundation.
2. Customer demo registration and profile.
3. Merchant demo onboarding and dashboard.
4. Synthetic QR/payment-intent generation.
5. Payment simulator: pending/success/failed/expired/reversed.
6. Append-only transaction event journal and ledger postings.
7. Idempotency and duplicate-request protection.
8. Merchant reconciliation and demo report.
9. Admin RBAC, audit log, support/dispute queue, risk alerts.
10. Unit, integration, and end-to-end tests.

**Exit gate:** all states tested; no duplicate postings; ledger reconciles; all artifacts marked DEMO; no live payment rail reachable.

## Phase 2 — Partner readiness

- Identify eligible bank/PSP/authorized PA partner categories.
- Prepare product demo, architecture, fund-flow, and data-flow packs.
- Obtain Indian legal advice on PA/TPAP/technology-provider classification.
- Agree KYC, merchant due diligence, authentication, disputes, settlement, fraud, and support responsibilities.
- Complete partner security questionnaires and required independent assessments.
- Define UPI/NPCI onboarding and certification path with partner.

**Exit gate:** written partner approval and signed contracts; all required regulatory approvals/authorizations and certifications confirmed; production runbooks approved.

## Phase 3 — Controlled pilot

- Partner sandbox integration, then approved production integration.
- Strict cohort and transaction limits.
- Real-time monitoring and reconciliation.
- Customer support and dispute escalation.
- Fraud/risk case management and incident response.
- Tested kill switch and rollback.

**Exit gate:** partner and internal sign-off; no unresolved critical/high security findings; reconciliation and complaint SLAs meet agreed targets; pilot risk review approves expansion.

## Phase 4 — Commercial expansion

- Merchant SaaS subscriptions and advanced business tools.
- Enterprise APIs and white-label licensing.
- Additional authorized payment partners and rails.
- Enhanced financial insights and merchant analytics.
- New regulated product lines only after separate legal and partner review.

## Recommended implementation order

1. Repository/documentation foundation.
2. UI design system and responsive application shell.
3. Authentication and role model.
4. Simulator payment intent and transaction state machine.
5. Ledger, idempotency, and reconciliation.
6. Merchant console.
7. Admin and support console.
8. Security, observability, automated test coverage.
9. Partner-readiness package.

## Operating metrics

**Product:** onboarding completion, active consumers/merchants, simulator intent completion, crash-free sessions, API availability.

**Reliability/control:** duplicate postings (target zero), unexplained ledger variance (target zero), status mismatch rate, incident response time, open critical/high vulnerabilities.

**Business:** paying merchants, SaaS MRR, plan gross margin, merchant retention, support cost.

Never present simulated transaction volume as real payment volume, adoption, or settlement performance.
