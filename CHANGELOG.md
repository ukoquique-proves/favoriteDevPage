# Changelog

All notable changes to this project will be documented in this file.

This project adheres to the [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format.

## [Unreleased]

### Added
- `toolkit.html`: dedicated page for Code Compacter with full detail copy, feature list, code sample output, and the email capture form (`id="puppyteach-capture-form"`).
- `serve.sh`: launches a local HTTP server and opens the browser automatically from any directory, polling until the server is ready before opening.
- `check.sh`: pre-push consistency checker. Validates file existence, nav links, shared asset references, form placement, README coverage, placeholder hygiene, and internal link integrity across all HTML pages.
- `push.sh`: runs `check.sh` before every push; aborts if any check fails. Accepts an optional commit message argument or prompts interactively.
- Waitlist form (`id="puppyteach-waitlist-form"`) in `index.html` wired to Formspree SDK with inline success/error feedback (`data-fs-success="waitlist"`, `data-fs-error="waitlist"`).
- Three standalone course detail pages (`curso-1-loops-compilador.html`, `curso-2-arquitectura-hexagonal.html`, `curso-3-soberania-local.html`) with full program information, learning objectives, and target audience.
- Lightweight SVG favicon linked from all pages.
- Formspree AJAX integration using a pinned version of `@formspree/ajax` with SRI and `crossorigin`.
- Docker vs. Puppy tradeoff section with comparison table and follow-up CTAs.
- `gracias.html`: no-JS fallback confirmation page with direct download link.
- `lista-espera-gracias.html`: no-JS fallback confirmation page for the waitlist form.
- Style guide document `consejos_formato.md`.
 - `forms.js`: small progressive enhancement helper that wires form `action` attributes to the configured Formspree endpoint.
 - `TROUBLESHOOTING.md`: documented investigation notes and recommended next steps for the gift-delivery issue.

### Changed
- `index.html` `#lead-magnet` section stripped to title + CTA only; all detail content and the capture form moved to `toolkit.html`.
- All internal links previously pointing to `#lead-magnet` now point to `toolkit.html`.
- Course cards are now fully clickable links navigating directly to their respective detail pages.
- Extracted reusable stylesheet (`styles.css`) shared across all pages.
- Course card titles and "Catálogo de Cursos" heading now use neon green (`#39ff14`).
- Lead magnet title updated from "agentes de IA" to "agentes de inteligencia artificial".
- Toolkit copy updated from "minimalismo de Puppy Linux" to "minimalismo en Linux".
- Improved dynamic form feedback accessibility with `aria-live`, `role`, and clearer field descriptions.
- `push.sh` now uses the configured git remote `origin` and existing local git authentication instead of embedding a token in the push URL.
- `push.sh` now stages the full repository with `git add -A` and aborts early when there are no staged changes.
- `serve.sh` now falls back to printing the local URL instead of blindly calling `xdg-open` in headless environments.
- All scripts now use `$DIR` resolution instead of hardcoded absolute paths — portable across any clone location.
- Added `_subject` field to toolkit capture form for clean inbox separation from the waitlist form (both share the same Formspree ID).
- Added footer to all three course detail pages for consistency.
- `check.sh` now includes footer presence check across all HTML pages.
- README rewritten to reflect current multi-file architecture and document all three scripts.
- Clarified in `ROADMAP.md` and `VISITORS_GIFT.md` that Formspree is used for lead capture only, while toolkit delivery already happens inline on the page and via `gracias.html`.
- Simplified `.env.example` to clarify that current scripts do not require environment variables.
 - Switched form submission to the standard browser POST flow (fallback to `gracias.html`) to avoid unreliable AJAX-only behavior.
 - Consolidated form initialization into `forms.js` and removed the fragile dependency on the Formspree AJAX SDK for core delivery flows.
 - Refactored several form-related CSS classes to a BEM-like naming convention (e.g. `lead-form__*`) and updated `styles.css` and templates accordingly.
 - Updated `sitemap.xml` to exclude confirmation-only pages (`gracias.html`, `lista-espera-gracias.html`).

### Fixed
- Removed dead CSS classes (`.col-side`, `.docker-col`, `.puppy-col`) with no corresponding HTML usage.
- `gracias.html` updated to use shared `styles.css` and `favicon.svg` instead of inline styles.
- Enhanced course micro-copy for a more senior technical audience.
- Improved mobile layout for the comparison table and refined code block presentation.
- Corrected the courses section title from `Catálogo de Cursos (Fase 2)` to `Catálogo de Cursos`.
- Fixed the secondary CTA hover state so it no longer inherited primary button styling.
- Improved keyboard accessibility with visible `:focus-visible` states across all interactive elements.
- Improved form accessibility with proper label association for email fields.
 - Fixed unreliable gift delivery caused by client-side SDK submission flow; forms now follow the browser POST → success page flow so the direct-download link is reachable.
 - Removed confirmation-only pages from `sitemap.xml` to avoid exposing download pages in search results.

### Published
- Published the project to GitHub Pages at `https://ukoquique-proves.github.io/favoriteDevPage/`.

## [0.1.0] - 2026-06-19
- Initial release of the PuppyTeach landing page.
- Static HTML/CSS landing page deployed on GitHub Pages.
