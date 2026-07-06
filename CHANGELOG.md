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
- Three standalone course detail pages (`curso-1-hardware-secundario.html`, `curso-2-savefiles.html`, `curso-3-pipeline-trixieretro.html`) with full program information, learning objectives, and target audience.
- Lightweight SVG favicon linked from all pages.
- Formspree AJAX integration using a pinned version of `@formspree/ajax` with SRI and `crossorigin`.
- Docker vs. Puppy tradeoff section with comparison table and follow-up CTAs.
- `gracias.html`: no-JS fallback confirmation page with direct download link.
- Style guide document `consejos_formato.md`.

### Changed
- `index.html` `#lead-magnet` section stripped to title + CTA only; all detail content and the capture form moved to `toolkit.html`.
- All internal links previously pointing to `#lead-magnet` now point to `toolkit.html`.
- Course cards are now fully clickable links navigating directly to their respective detail pages.
- Extracted reusable stylesheet (`styles.css`) shared across all pages.
- Course card titles and "Catálogo de Cursos" heading now use neon green (`#39ff14`).
- Lead magnet title updated from "agentes de IA" to "agentes de inteligencia artificial".
- Toolkit copy updated from "minimalismo de Puppy Linux" to "minimalismo en Linux".
- Improved dynamic form feedback accessibility with `aria-live`, `role`, and clearer field descriptions.
- `push.sh` now sources `.env` for `GITHUB_TOKEN` and `GITHUB_REPO`, making the push self-contained without requiring pre-configured git credentials.
- All scripts now use `$DIR` resolution instead of hardcoded absolute paths — portable across any clone location.
- Added `_subject` field to toolkit capture form for clean inbox separation from the waitlist form (both share the same Formspree ID).
- Added footer to all three course detail pages for consistency.
- `check.sh` now includes footer presence check across all HTML pages.
- README rewritten to reflect current multi-file architecture and document all three scripts.

### Fixed
- Removed dead CSS classes (`.col-side`, `.docker-col`, `.puppy-col`) with no corresponding HTML usage.
- `gracias.html` updated to use shared `styles.css` and `favicon.svg` instead of inline styles.
- Enhanced course micro-copy for a more senior technical audience.
- Improved mobile layout for the comparison table and refined code block presentation.
- README rewritten to reflect current multi-file architecture.

### Fixed
- Corrected the courses section title from `Catálogo de Cursos (Fase 2)` to `Catálogo de Cursos`.
- Fixed the secondary CTA hover state so it no longer inherited primary button styling.
- Improved keyboard accessibility with visible `:focus-visible` states across all interactive elements.
- Improved form accessibility with proper label association for email fields.

### Published
- Published the project to GitHub Pages at `https://ukoquique-proves.github.io/fastDevPage/`.

## [0.1.0] - 2026-06-19
- Initial release of the PuppyTeach landing page.
- Static HTML/CSS landing page deployed on GitHub Pages.
