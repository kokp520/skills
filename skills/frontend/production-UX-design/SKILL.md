---
name: production-UX-design
description: Reusable UX/interaction design logic distilled from modern SaaS product portals (Vercel-Geist style, e.g. portal.nousresearch.com). Use when building a landing/product page, pricing page, or a large filterable catalog (models / tools / plans / SKUs) and you want the SAME interaction patterns + information architecture — WITHOUT copying the visual art. All visuals are decoupled into CSS variables so you can re-skin freely.
---

# Portal-Style Landing — UX Pattern Skill

## What this captures
Analysis of a reference product portal (Nous Portal: Astro + Vercel, built on the
Vercel **Geist** design system). We keep ONLY the interaction logic + information
architecture. The art (colors, fonts, illustrations) is deliberately generic and
isolated in CSS variables so you can swap it without touching structure.

### Reference design system (context only — do NOT copy the look)
- Stack: Astro, Vercel hosting, Vercel Geist tokens (`--ds-gray-*`, `--link-color:#0070f3` / `#3291ff` dark)
- Dark-default, light via `prefers-color-scheme`
- System font stack, monochrome grays, centered max-width 80rem container
- Minimal, high-whitespace, single-page scroll

### Information architecture (the reusable skeleton)
1. **Hero** — one tagline + one value sentence + dual CTA (primary filled / secondary outline)
2. **Pillars** — 4 feature cards in a responsive grid (the "what you get" proof)
3. **Surfaces** — 3 options showing where the product runs (desktop / cloud / terminal)
4. **Catalog** (centerpiece) — large dataset rendered client-side with:
   - a search box (matches name + provider)
   - filter chips (category/provider toggles, composable)
   - per-item metadata (e.g. pricing shown as `in $X / out $Y per 1M tokens`)
   - zero page reloads — pure client-side filter + render
5. **Pricing / credits** — tier or credit-balance explanation
6. **Footer CTA** — repeat primary CTA + nav links

### Interaction patterns worth porting
- **Data-driven catalog**: keep items in a JS/JSON array, render via a function,
  filter on input. NEVER hardcode hundreds of rows in HTML.
- **Search + chip filters compose**: `items.filter(searchMatch).filter(chipMatch)`
- **Dual CTA convention**: one high-contrast primary, one ghost/outline secondary.
- **Grid rhythm**: uniform card padding/gap; cards flex to 1/2/3/4 cols by width.
- **Theme-aware**: respect `prefers-color-scheme`; isolate ALL colors in `:root`.
- **Single-page anchor nav**: one long scroll, sticky CTA, anchor links.

## Decoupling art from UX (the core rule)
In `templates/index.html` two layers are separated:
- **ART layer** = CSS variables in `:root` (colors, fonts, radius, shadow, spacing scale, illustration/image slots). Edit ONLY these to re-skin.
- **UX layer** = structural CSS (layout/grid/flex) + JS (filter/render). Do NOT change these when swapping art — that is what keeps the interaction logic reusable.

---

## Ordered Execution Workflow

### Step 1: Copy Template Baseline
Copy `templates/index.html` into your target project workspace directory.
- *Completion Criterion*: `index.html` exists in the target directory with intact structural markup and CSS variables.

### Step 2: Inject Data Catalog Array
Replace the sample dataset with your project's domain items while preserving required fields (`name`, `provider`, `category`, `priceIn`, `priceOut`, `note`).
- *Completion Criterion*: Data catalog array is populated with valid JSON/JS objects without syntax errors.

### Step 3: Re-skin via ART Tokens
Update `:root` CSS variables (color palette, typography stack, border radius) to apply the custom theme without touching structural layout rules.
- *Completion Criterion*: `:root` CSS variables reflect target branding and dark/light mode responsiveness.

### Step 4: Asset & Icon Slot Replacement
Replace hero SVG illustrations and feature card icon placeholders with project-specific assets.
- *Completion Criterion*: Placeholder images/icons are swapped with valid local or hosted asset paths.

### Step 5: Filter & Render Verification
Verify client-side search matching and filter chip composability in the active browser or runtime.
- *Completion Criterion*: Catalog renders, searches, and filters without page reloads or runtime JS errors.

---

## Files
- `templates/index.html` — complete, working, themeable single-page implementation.

