# ZEROXPAY — India Compliance & Operating Architecture

**Version:** 1.0 | **Date:** 25 November 2026  
**Notice:** Engineering planning only, not a legal opinion. Qualified Indian fintech counsel and regulated partners must validate the exact operating model before launch.

## 1. Governing principle

Regulatory obligations depend on the actual activity and fund flow, not the product name. A software provider that only supplies technology differs from an entity that receives, pools, controls, or settles customer funds.

## 2. Initial model: software + simulator only

ZEROXPAY may initially provide customer, merchant, and admin software; synthetic payment simulations; demo transaction events; reports; and support workflows. It must not receive, pool, hold, transfer, settle, or control customer funds; issue wallets/PPIs; create UPI handles; or connect to live payment rails. It must not represent itself as an RBI-authorized PA, PSP bank, TPAP, PPI issuer, or bank.

Use synthetic identifiers and conspicuous DEMO labels. Never collect actual UPI PINs, OTPs, card details, bank credentials, or real payment instructions.

## 3. Future partner-led live payments

Proceed only after:
1. Counsel reviews the exact product flow, fund flow, and ZEROXPAY role.
2. Eligible bank/PSP/authorized PA partner agrees in writing.
3. Partner confirms applicable NPCI/scheme onboarding, certification, security, data, grievance, and operational requirements.
4. Any RBI authorization or other approval required for the entity's actual role is obtained.
5. Contracts allocate onboarding, KYC, authentication, processing, settlement, refunds, disputes, fraud, data, audit, and support duties.
6. Security assessment, operational readiness, and controlled-pilot gates pass.

### UPI participation

UPI is operated by NPCI. A TPAP participates through a PSP bank and must comply with NPCI and PSP requirements. A public API or QR image does not grant UPI access. The proposed TPAP/PSP model, onboarding, audits, data handling, grievance process, and certification must be confirmed with the partner.

### Payment aggregation

If the actual activity meets the Payment Aggregator definition—facilitating merchant payment acceptance and subsequently settling collected funds—do not commence it without applicable RBI authorization or a legally valid regulated-partner structure. RBI's 2025 Master Direction consolidates PA regulation, including authorization, governance, dispute management, security/risk, merchant due diligence, and escrow-related requirements. Obtain a formal legal classification of the exact fund flow.

### Wallets and cross-border

Wallet/PPI issuance and cross-border collection/payout are out of initial scope. Each requires separate RBI/FEMA/legal assessment, eligible regulated partner(s), and applicable authorization and controls.

## 4. Compliance workstreams

### KYC/AML and merchant due diligence
- Allocate customer identification and merchant due diligence to the legally responsible regulated entity/partner.
- Risk-based onboarding and periodic review as applicable.
- Screening and escalation where required.
- Documented record retention and audit access.
- Collect only data required for the approved role.

### Privacy and data protection
- Map personal data, purposes, notices, lawful basis/consent where applicable, retention, deletion, processors, and user rights.
- Design for the DPDP Act, 2023 and rules/notifications in force at launch.
- Apply data minimization, purpose limitation, access controls, encryption, breach response, and vendor due diligence.
- Do not sell personal or transaction data.
- Validate cross-border processing and partner-specific localization requirements.

### Payment data
- Follow applicable RBI/NPCI/PSP data storage and processing rules.
- UPI transaction data must be stored in India as required by ecosystem participant rules.
- Inventory primary stores, backups, logs, analytics, and support access locations.
- Never store UPI PINs or OTPs; do not store CVV or full card credentials.

### Security and resilience
- Threat modelling and secure SDLC.
- Encryption in transit/at rest; managed secrets and key rotation.
- MFA for privileged roles; least-privilege RBAC.
- Signed webhooks, replay protection, idempotency, rate limits, abuse detection.
- Immutable audit records and monitored admin access.
- Independent penetration testing and partner-required audits before launch.
- Backup/restore drills, incident response, business continuity, disaster recovery.

### Customer protection
- Accurate terms, privacy notice, fee disclosures, and partner identity/role disclosures.
- Accessible support and complaint tracking.
- Escalation and dispute timelines agreed with the regulated partner.
- Do not promise refund/settlement timelines beyond confirmed partner rules.

### Tax and corporate
Obtain professional advice on GST, income tax, withholding, invoicing, revenue share, merchant SaaS subscriptions, accounting, and statutory filings. Keep software subscription revenue distinct from payment settlement flows.

## 5. Technical controls

- **Client:** Android/web UI; no privileged credentials embedded in app.
- **ZEROXPAY backend:** identity, merchant SaaS, demo orchestration, support, analytics, audit, and partner boundary.
- **Simulator adapter:** synthetic events only; isolated from production credentials/endpoints.
- **Partner adapter:** disabled by default; server-side secrets; enabled only for approved partner environments.
- **Ledger:** append-only event journal, idempotency, traceable reversals, reconciliation.
- **Operations:** RBAC, dual control for sensitive changes, audit, monitoring, incident workflow.

Production and simulator must have separate databases, credentials, keys, endpoints, and deployment permissions. Enforce a technical guard preventing demo config from being mistaken for live settlement.

## 6. Official reference points

- RBI, [Master Direction on Regulation of Payment Aggregators](https://www.rbi.org.in/Scripts/NotificationUser.aspx/upload/notification/docs/Scripts/NotificationUser.aspx?Id=12896) (issued 15 Sep 2025; updated 11 Nov 2026).
- RBI, [UPI access for PPIs through third-party applications](https://www.rbi.org.in/scripts/notificationuser.aspx?id=12756) (27 Dec 2024).
- NPCI UPI roles and grievance framework, [participant-role summary](https://pay.google.com/intl/en_in/about/external/npci/) — verify against current NPCI/PSP documentation.
- RBI, [Regulation of Payment Aggregator – Cross Border](https://www.rbi.org.in/Scripts/NotificationUser.aspx?Id=12561) (31 Oct 2023).

## 7. Live launch approval checklist

- [ ] Legal classification memo for exact fund flow and company role.
- [ ] Executed agreements with eligible regulated partner(s).
- [ ] Written confirmation of NPCI/PSP onboarding and certification.
- [ ] RBI authorization obtained where ZEROXPAY itself requires it.
- [ ] Approved KYC/AML and merchant due diligence responsibilities.
- [ ] Privacy notices, retention schedule, processor contracts, localization validation.
- [ ] Security audit, penetration test, critical/high finding closure, incident drill.
- [ ] Reconciliation, disputes, refunds, support, and escalation tested end-to-end.
- [ ] Consumer disclosures and merchant contracts approved by counsel.
- [ ] Controlled-pilot limits, monitoring, rollback, and go/no-go sign-off.

A checkbox is not complete merely because a document or UI screen exists; evidence and accountable-party sign-off are required.
