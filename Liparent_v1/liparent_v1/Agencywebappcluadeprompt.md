Here are comprehensive UI prompts for each screen of **Apex** — a Kenya-focused property management system for agencies.

---

## 🏠 Landing Page Prompt

> **Project:** Apex — Kenya Property Management Platform
> **Screen:** Public Landing / Marketing Page
>
> Design a bold, confident landing page for **Apex**, a property management SaaS built for Kenyan real estate agencies. The aesthetic should feel *premium yet grounded* — think dark charcoal backgrounds with deep green (#1A6B47) as the primary accent and warm amber (#F59E0B) as a secondary punch. Use a geometric, editorial layout with asymmetric sections and strong typographic hierarchy.
>
> **Hero Section:** Full-width with a bold headline like *"Manage Every Property. Collect Every Shilling."* with a subline about M-Pesa-native rent collection. Include a CTA button ("Start Free Trial") and a secondary link ("See How It Works"). Show a subtle animated dashboard mockup or property card floating on the right side.
>
> **Trust Bar:** Logos or icons representing M-Pesa, Africa's Talking, KRA, and Kenya DPA 2019 compliance.
>
> **Features Section (Tier 1 only):** 6-card grid showcasing: M-Pesa STK Push, Automated SMS Reminders, Digital Leases + E-Signatures, Tenant Management, Unit Tracking, and KRA-Compliant Receipts. Each card has an icon, a one-line label, and a short description.
>
> **Social Proof Strip:** Testimonial quote from a fictional Nairobi landlord with an avatar, rating stars, and property count (e.g., "Managing 34 units across Kilimani and Ruaka").
>
> **CTA Section:** Full-width band with a contrasting background — "Join agencies already using Apex. Setup takes 10 minutes." with Signup button.
>
> **Footer:** Logo, nav links (Features, Pricing, Blog, Contact), legal links, and "Built for Kenya 🇰🇪" tag.
>
> Font pairing: A sharp geometric display font (e.g. Syne or DM Serif) for headlines + a clean readable sans (e.g. Outfit or Plus Jakarta Sans) for body. No Inter. No purple gradients.

---

## 🔐 Signup Page Prompt

> **Project:** Apex — Kenya Property Management Platform
> **Screen:** Agency Signup / Registration
>
> Design a two-panel signup page. Left panel: a dark, atmospheric sidebar (~40% width) with the Apex logo at top, a bold statement like *"Your portfolio. Your rules."* and a short 3-bullet list of what the agency gets (M-Pesa integration, SMS alerts, KRA receipts). Optionally show a floating property card or stat widget as decoration.
>
> Right panel: clean white/off-white registration form with the following fields:
> - Agency Name (text)
> - Your Full Name (text)
> - Email Address
> - Phone Number (Kenyan format, +254 prefix hint in placeholder)
> - Password + Confirm Password
> - Number of Properties Managed (dropdown: 1–5, 6–20, 21–50, 50+)
> - Checkbox: "I agree to the Terms of Service and Kenya DPA 2019 Privacy Policy"
> - Primary CTA button: "Create Agency Account" (full width, deep green)
> - Below: "Already have an account? Sign in"
>
> Form validation states (error in red, success in green) must be shown. Phone field should auto-format as Kenyan number. No unnecessary fields — keep it fast and frictionless. Use smooth field-focus animations.

---

## 🔑 Login Page Prompt

> **Project:** Apex — Kenya Property Management Platform
> **Screen:** Agency Login
>
> Design a minimal but atmospheric login screen. Use a full-bleed dark background with a subtle geometric texture or noise grain overlay. Center a compact login card (~420px wide) with a soft shadow and slightly rounded corners.
>
> Inside the card:
> - Apex logo/wordmark at top center
> - Headline: "Welcome back"
> - Subtext: "Sign in to your agency dashboard"
> - Email field
> - Password field (with show/hide toggle)
> - "Forgot password?" link aligned right, subtle
> - Login button: full-width, deep green (#1A6B47) with a hover state that brightens
> - Divider: "or"
> - "Sign in with Google" secondary button (outlined style)
> - Footer: "Don't have an account? Create one →"
>
> Add a gentle fade-in animation on card load. Error state should shake the card subtly and highlight the fields in red. Success state triggers a brief green pulse before redirecting. Keep the form tight and focused — nothing else on screen except perhaps a very faint city skyline silhouette (Nairobi) in the background.

---

## 📊 Agency Dashboard Prompt

> **Project:** Apex — Kenya Property Management Platform
> **Screen:** Main Agency Dashboard (Tier 1 Features Only)
> **User:** An agent or property manager overseeing multiple landlord portfolios
>
> Design a data-rich but spatially clean dashboard with a fixed left sidebar navigation and a main content area. Dark mode preferred (#0F1A14 deep green-black bg, with #1A6B47 sidebar accent, amber #F59E0B for alerts/highlights, white text).
>
> **Sidebar (left, ~240px):**
> - Apex logo at top
> - Navigation items with icons: Overview, Properties, Tenants, Payments, Receipts, Leases, Reminders, Settings
> - Bottom: Agent avatar, name, agency name, and logout
>
> **Top Bar:**
> - Page title "Dashboard"
> - Date: "Saturday, 28 March 2026"
> - Notification bell (with badge count)
> - Quick action button: "+ Record Payment"
>
> **Stats Row (4 cards):**
> 1. Total Rent Collected This Month — KES amount, % vs last month
> 2. Pending Payments — count of tenants, total KES outstanding
> 3. Properties Managed — total units, occupancy % badge
> 4. Active Leases — count, X expiring within 30 days (amber alert)
>
> **Main Grid (2 columns):**
>
> *Left (wider):*
> - **Recent Payments Table** — columns: Tenant Name, Unit, Property, Amount (KES), M-Pesa Ref No., Date, Status (Paid / Partial / Late). Rows are clickable. Status uses color-coded chips.
> - **Payment Reminders Queue** — list of upcoming due dates (next 7 days), each row shows tenant name, unit, amount due, due date, and a "Send Reminder" SMS button.
>
> *Right (narrower):*
> - **Occupancy Overview** — donut chart or segmented bar showing Occupied / Vacant / Pending per property
> - **Late Payments Alert Panel** — tenants past due with number of days overdue, calculated penalty amount, and action buttons: "Send SMS", "View Tenant"
> - **M-Pesa Activity Feed** — real-time-style list of the last 5 M-Pesa STK push results (Success ✓ / Failed ✗ / Pending ⏳) with timestamps
>
> **Design Details:**
> - Use KES currency formatting throughout (e.g. KES 45,000)
> - M-Pesa logo badge on all payment-related elements
> - SMS icon (Africa's Talking) on all reminder actions
> - Micro-animations on stat card number count-up on load
> - Table rows with hover highlight; clickable rows navigate to tenant detail
> - Mobile-responsive: sidebar collapses to bottom tab bar on mobile

---
 Create Tenant Page Prompt

Project: Apex — Kenya Property Management Platform
Screen: Create New Tenant
User: Agent or property manager onboarding a new tenant to a unit
Design a clean, structured multi-section form page that sits inside the Apex dashboard layout (same fixed sidebar and top bar as the main dashboard). The form should feel efficient and professional — not overwhelming. Use the same dark theme (#0F1A14 background, #1A6B47 accents, amber #F59E0B for required field indicators).
Page Header:

Breadcrumb: "Tenants → Add New Tenant"
Page title: "Create Tenant"
Subtext: "Fill in the tenant's details to link them to a unit and generate their lease."
Top-right: two buttons — "Cancel" (outlined/ghost) and "Save Tenant" (solid green, disabled until required fields are filled)

Form Layout: Single scrollable page divided into clearly labeled card sections, each with a subtle border and section heading.

Section 1 — Personal Information

Full Name (text, required)
National ID Number (text, required — label note: "Used for ID verification")
Date of Birth (date picker)
Gender (radio: Male / Female / Prefer not to say)
Profile Photo Upload (drag-and-drop or click to upload, shows circular preview)

Section 2 — Contact Details

Primary Phone Number (required, +254 prefix, M-Pesa hint: "This number will receive M-Pesa STK push requests")
Secondary Phone Number (optional)
Email Address (optional, subtext: "For receipt delivery if available")
Preferred Contact Method (toggle chips: SMS / WhatsApp / Email)

Section 3 — Unit Assignment

Select Property (searchable dropdown listing all agency-managed properties)
Select Unit (dynamically loads available units based on selected property, shows unit number + floor + type e.g. "Unit 4B · Floor 2 · 2BR")
Move-In Date (date picker, required)
Lease Duration (dropdown: 6 months / 12 months / 24 months / Month-to-month)
Auto-calculated Lease End Date (read-only field, updates dynamically based on move-in + duration)

Section 4 — Rent & Financials

Monthly Rent Amount (KES, number input, required)
Rent Due Day (dropdown: 1st–31st of month, default 1st)
Grace Period (dropdown: 0 days / 3 days / 5 days / 7 days)
Late Payment Penalty (toggle on/off; if on, show: Penalty Type — Fixed KES or % of rent, and Amount input)
Security Deposit Amount (KES, number input)
Deposit Status (radio: Paid / Pending)

Section 5 — Emergency Contact

Emergency Contact Name (text)
Relationship (dropdown: Spouse / Parent / Sibling / Friend / Other)
Emergency Contact Phone (text, +254 prefix)

Section 6 — Documents (optional at creation)

ID Document Upload (front + back, two upload zones side by side)
Signed Lease Agreement Upload (PDF, or note: "You can generate and e-sign this after saving")
Any other documents (generic multi-file upload, accepts PDF/JPG/PNG)


Bottom Action Bar (sticky on scroll):

Left: "Cancel" ghost button
Right: "Save & Generate Lease →" (primary, solid green) + "Save Draft" (secondary, outlined)

Design Details:

Required fields marked with amber asterisk (*)
Inline validation — errors appear below the field in real time, not only on submit
Phone fields auto-format to Kenyan style (e.g. 0712 345 678)
Unit dropdown shows a "No units available" empty state if the property is fully occupied
Section cards have a subtle left border accent in green when the section is actively being filled
Smooth scroll-to-error behavior on failed submit attempt
Mobile-responsive: sections stack vertically, sticky action bar remains visible

These prompts are structured so you can hand each one directly to a designer or feed them into a component-by-component build in your Phoenix/LiveView project. Want me to actually **build any of these as a working HTML/React artifact** to use as a visual reference?