# ZEROXPAY — Product Specification

**Version:** 1.0 | **Date:** 25 November 2026 | **Market:** India-first

## 1. Vision and objective

Make digital payments simple, transparent, secure, and useful for consumers and merchants. The consumer standard-payment fee target is ₹0, subject to partner economics, scheme rules, and applicable law. Build a sustainable business through optional merchant software and enterprise services.

## 2. Users

- **Consumers:** everyday payment users needing clear status, history, receipts, support, and financial summaries.
- **Merchants:** retailers, service providers, and online businesses needing collections visibility, reconciliation, reports, and staff controls.
- **Operations:** support, merchant review, risk, security, and platform administrators.

## 3. Product surfaces

### Customer app — Android first, web companion
- Secure registration, profile, consent, session/device management.
- Partner-enabled payment entry points (disabled in simulator).
- Synthetic QR scanning/display and demo payment intents.
- Transaction timeline: Pending, Success, Failed, Expired, Reversed.
- Receipts visibly marked DEMO in simulator.
- Notifications, help centre, complaint submission and tracking.
- Smart Ledger with categorized summaries from permitted data.
- AI finance assistant for informational insights only; no autonomous money movement or credit/investment decisions.

### Merchant console
- Demo onboarding and business profile workflow.
- Synthetic QR/payment-intent creation.
- Payment activity, search, reconciliation, downloadable reports.
- Staff roles and permissions.
- Refund/return simulation.
- SaaS plan controls and approved enterprise API/webhook settings.

### Admin/operations console
- RBAC and MFA for privileged roles.
- Merchant review queue with decision reasons and audit trail.
- Synthetic transaction explorer.
- Support/dispute queue and risk case management.
- Configuration approvals, system health, audit events, and incident dashboard.
- Time-limited break-glass access with mandatory logging.

## 4. Platform capabilities

1. Identity/access: secure auth, session revocation, device history, account recovery, RBAC.
2. Payment orchestration abstraction: provider-neutral interface; simulator adapter first; partner adapters only after authorization.
3. Transaction state machine: Created → Awaiting Action → Pending → Success / Failed / Expired; reversals/refunds are separate linked events.
4. Ledger/event journal: append-only financial-event model, idempotency, balanced postings, audit trail, reconciliation.
5. Merchant services: onboarding, roles, reports, subscription entitlements.
6. Risk controls: velocity checks, device/session signals, anomaly flags, manual review, explainable case notes.
7. Notifications: approved providers; never expose secrets or authentication data.
8. Support/disputes: case IDs, status, evidence metadata, escalation, resolution timestamps.
9. Analytics: aggregate metrics with privacy-aware access controls.
10. AI: read-only insights over authorized data; never directly executes payments.

## 5. Business model

Potential revenue: merchant SaaS subscriptions, enterprise API/integration/support contracts, white-label software licensing, and optional analytics/operational tooling with clear disclosures and consent. No hidden consumer fees, sale of personal/payment data, or revenue arrangement that conflicts with scheme rules or partner contracts.

## 6. Simulator MVP acceptance criteria

- Synthetic demo accounts and merchants only.
- Clearly labelled demo QR and payment intents.
- Pending, success, failure, expiry, and reversal scenarios.
- Same idempotency key cannot create duplicate postings.
- Every state transition produces an auditable event.
- Ledger totals reconcile to the synthetic event journal.
- Admin permissions block unauthorized actions.
- No real bank account, UPI ID, card, wallet, or payment network is contacted.
- All demo records and receipts say DEMO / SIMULATED.

## 7. Out of scope for initial release

- Holding customer funds or operating settlement/escrow accounts.
- Issuing a wallet/PPI.
- Direct UPI switch access or claiming PSP/TPAP status without required participation and approvals.
- Independent payment aggregation/settlement before applicable authorization.
- Lending, deposits, investments, insurance distribution, or cross-border remittance.
- Autonomous AI-initiated transfers.
- Storing UPI PINs, OTPs, CVV, or full payment credentials.

## 8. Product principles

Trust before growth; transparent pricing; privacy by design; accessible low-bandwidth mobile UX; fail-safe transaction handling; human review for high-impact risk decisions; partner-first regulated payment access.
