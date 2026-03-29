# LiparentV1

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://hexdocs.pm/phoenix/overview.html
* Docs: https://hexdocs.pm/phoenix
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix






# Kenya Property Management System — Feature Priority List

> Features ranked from most critical (must-have at launch) to least urgent (future roadmap).
> Additional features marked with ✨ have been added for Kenya market viability.

---

## 🔴 TIER 1 — Launch Blockers (Must ship on day 1)

These features make or break the product. Without them, the system is unusable.

1. **M-Pesa STK Push (Lipa Na M-Pesa)** — the primary payment rail in Kenya. No M-Pesa, no adoption.
2. **Paybill / Till Number per Landlord** — tenants need a familiar way to pay without app installation.
3. **Rent Collection & Recording** — log payments, amounts, dates, and which unit paid.
4. **Payment Receipts (KRA-compliant)** — landlords are legally required to issue receipts.
5. **SMS Notifications via Africa's Talking** — payment confirmations, reminders, and alerts for feature phone users.
6. **Payment Reminders** — automated SMS/WhatsApp 3 days and 1 day before rent is due.
7. **Late Payment Penalty Calculation** — automatic fee applied after grace period.
8. **Tenant Management** — add, edit, and remove tenants linked to specific units.
9. **Unit & Property Tracking** — multi-unit properties under one landlord account.
10. **Digital Lease Agreements with E-Signatures** — legally binding under Kenya's Electronic Transactions Act.
11. **Security Deposit Ledger** — track deposit held, deductions made, and refund status.
12. **Basic Landlord Dashboard** — occupancy status, rent collected this month, outstanding balances.
13. **Tenant Portal (mobile-first)** — tenants can view balance, pay rent, and download receipts.
14. **Data Protection Compliance (Kenya DPA 2019)** — mandatory. Fines for non-compliance are severe.
15. ✨ **Offline Mode (basic)** — patchy internet in estates means core features must work offline and sync later.

---

## 🟠 TIER 2 — Early Growth (Ship within first 3 months)

Features that drive retention and differentiate from a spreadsheet.

16. **WhatsApp Business API** — send receipts, reminders, and announcements (high open rates in Kenya).
17. **Partial Payment Support** — tenants paying in installments is a reality, not an exception.
18. **Maintenance Request System** — tenants report issues with photos; landlord assigns and tracks.
19. **Vendor Management** — plumbers, electricians, cleaners linked to properties.
20. **M-Pesa Statement Auto-Import** — parse M-Pesa statements to auto-match payments to tenants.
21. **Bank Reconciliation** — match bank deposits with rent records for landlords using accounts.
22. **Income & Expense Tracking** — maintenance costs, insurance, water, KPLC bills per property.
23. **Profit & Loss per Property** — simple monthly statement for each property or portfolio.
24. **KRA iTax Integration** — report rental income automatically; Kenya Revenue Authority is actively pursuing landlords.
25. ✨ **Annual Tax Statement Generator** — produce a single document a landlord can hand to their accountant for filing.
26. **Tenant Payment History** — full ledger of every payment, partial, and outstanding balance.
27. **Multiple Payment Methods** — bank transfer, cash (manually recorded), card.
28. **In-App Landlord-Tenant Chat** — reduce reliance on personal WhatsApp numbers.
29. **Document Storage** — upload title deeds, insurance, inspection certificates, and leases.
30. ✨ **Agent / Caretaker Role** — many landlords use agents or on-site caretakers; they need a limited-access role to collect rent and log issues without seeing financials.

---

## 🟡 TIER 3 — Competitive Edge (3–6 months post-launch)

Features that push the product ahead of competitors.

31. **Tenant Screening — CRB Check** — integrate with Metropol or CRB Africa for credit history.
32. **ID Verification via eCitizen** — confirm tenant identity against national ID database.
33. **Previous Landlord References** — structured reference request sent via SMS or email.
34. **Employment Verification** — payslip upload or employer contact confirmation.
35. **Occupancy Rate Analytics** — monthly trends per property, vacancy duration tracking.
36. **Rental Yield Calculator** — show landlords their ROI including purchase price, mortgage, and running costs.
37. **Market Rent Comparison** — compare a unit's rent against average rents in that area (Kilimani vs Kasarani vs Mombasa Road etc).
38. ✨ **Nairobi Neighborhood Benchmarking** — granular data for Nairobi sub-markets (Westlands, South B, Embakasi, etc).
39. **Predictive Late Payment Alerts** — flag tenants likely to miss payment based on history.
40. **Maintenance Cost Analysis** — which properties cost the most to maintain and why.
41. **USSD Interface** — feature phone support for tenants who cannot use a smartphone app.
42. **Bulk SMS / Announcements** — send one message to all tenants in a property (e.g. water outage notice).
43. **Google Maps Integration** — property location, directions for viewings, and area context.
44. **Google Calendar Sync** — schedule viewings, inspection dates, and lease renewal reminders.
45. ✨ **Lease Renewal Workflow** — automated reminder 60 days before expiry with one-click renewal or renegotiation.

---

## 🟢 TIER 4 — Market Expansion (6–12 months)

Features that open new user segments or revenue streams.

46. **Property Listing Creation** — auto-post vacancies to Jiji, Facebook Marketplace, Property24.
47. **Digital Tenant Application Forms** — apply for a unit online; landlord reviews and approves.
48. **Virtual Tours (360°)** — reduce unnecessary physical viewings.
49. **AI Rent Price Recommendations** — suggest optimal rent based on area, unit size, and amenities.
50. **Chatbot Support (24/7)** — handle common tenant queries without landlord involvement.
51. **Document OCR** — scan physical leases, ID cards, and receipts to digitize them.
52. **Multi-Currency Support** — USD, GBP, EUR for diaspora landlords managing property from abroad.
53. ✨ **Diaspora Landlord Mode** — remote management dashboard, FX-aware reporting, and international bank transfer support.
54. **Sweep Accounts** — auto-transfer collected rent to landlord's bank account on a set schedule.
55. **VAT Calculation (Commercial Properties)** — 16% VAT for commercial leases; withholding VAT automation.
56. **Withholding Tax Automation** — applicable when companies rent from individuals (10% WHT).
57. **Audit Trail** — immutable log of every action taken in the system for dispute resolution.
58. **Dispute Resolution Workflow** — document escalation steps integrated with Kenya's Small Claims Court process.
59. **Eviction Process Tracking** — legal steps, notices, and timelines documented per Kenyan tenancy law.
60. ✨ **Tenant Blacklist (Shared Database)** — opt-in database of non-paying or destructive tenants shared across landlords on the platform.

---

## 🔵 TIER 5 — Future Roadmap (12+ months)

Advanced features for a mature product.

61. **Smart Locks Integration** — digital key access, one-time codes for viewings.
62. **Kenya Power Prepaid Meter Integration** — track and top up electricity for managed units.
63. **Nairobi Water Integration** — log water bills and consumption per unit.
64. **Security Camera Remote Monitoring** — via integration with common IP camera systems.
65. **Automated Gate Access (QR Code)** — for gated communities and apartment blocks.
66. **Asset Tracking** — appliances, furniture, and equipment inventory per unit.
67. **Predictive Maintenance (AI)** — predict when appliances are likely to fail based on age and usage.
68. **Firebase Push Notifications** — in-app alerts for payments, maintenance updates, and announcements.
69. ✨ **SACCO / Chama Integration** — many landlords in Kenya own property through SACCOs or investment groups; support group ownership structures and profit sharing.
70. ✨ **Short-Let / Airbnb Mode** — manage short-term rentals alongside long-term tenants for the same property portfolio.
71. ✨ **Contractor Marketplace** — rated and reviewed plumbers, painters, and electricians available to hire directly from the app.
72. ✨ **Insurance Integration** — partner with local insurers (Jubilee, CIC, Britam) to offer landlord and tenant insurance in-app.
73. ✨ **Mortgage Tracking** — for landlords with mortgages, track loan balance, monthly repayment, and how rent covers it.
74. ✨ **County Government Compliance** — Nairobi City County, Mombasa, and Kisumu have different rates and levies; automate Land Rate and single business permit reminders.
75. **Bulk Payments** — pay multiple vendors, utility bills, or supplier invoices in one action.

---

## 📌 Notes on Kenya Market Viability

- **M-Pesa is non-negotiable.** Any friction here kills adoption immediately.
- **SMS over push notifications** for Tier 1 rollout — smartphone penetration in lower-income tenant brackets is still growing.
- **Swahili language support** should be considered for the tenant-facing side of the app.
- **Trust is the biggest sales challenge** — landlords will not hand over rent collection to an app without seeing others do it first. A referral program and testimonial strategy matter as much as the features.
- **Start with Nairobi** (Westlands, Kilimani, South B, Langata, Ruaka, Kasarani) before expanding to Mombasa, Nakuru, and Kisumu.
- **Price in tiers** — small landlords (1–5 units) pay differently from estate managers (50+ units). Both segments are large in Kenya.