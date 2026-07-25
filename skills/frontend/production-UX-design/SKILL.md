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
- **ART layer** = CSS variables in `:root` (colors, fonts, radius, shadow, spacing
  scale, illustration/image slots). Edit ONLY these to re-skin.
- **UX layer** = structural CSS (layout/grid/flex) + JS (filter/render). Do NOT
  change these when swapping art — that is what keeps the interaction logic reusable.

## How to apply
1. Copy `templates/index.html` into your project.
2. Replace the sample catalog array with your real data (keep the field shape:
   `name, provider, category, priceIn, priceOut, note`).
3. Re-skin via the `:root` ART variables (or add a `[data-theme="x"]` block).
4. Swap the hero illustration / icon slots for your own art.
5. Keep the filter/render JS intact — that is the portable UX.

## Files
- `templates/index.html` — complete, working, themeable single-page implementation.
