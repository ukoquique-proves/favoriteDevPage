# Changelog

All notable changes to this project will be documented in this file.

This project adheres to the [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format.

## [Unreleased]

### Added
- `toolkit.html`: dedicated page for Code Compacter with detail copy, feature list, code sample, email capture form, and inline success block with download button.
- `serve.sh`: launches a local HTTP server and opens the browser automatically from any directory, polling until the server is ready.
- `check.sh`: pre-push consistency checker. Validates file existence, nav links, shared asset references, form placement, README coverage, placeholder hygiene, footer presence, and internal link/anchor integrity.
- `push.sh`: runs `check.sh` before every push; aborts if any check fails. Accepts an optional commit message argument or prompts interactively.
- `lista-espera-gracias.html`: no-JS fallback confirmation page for the waitlist form.
- `TROUBLESHOOTING.md`: documents known issues and debugging steps for the gift delivery flow.
- Waitlist form (`id="puppyteach-waitlist-form"`) in `index.html` with inline success/error feedback.
- Three standalone course detail pages with full program information, learning objectives, and target audience.
- Lightweight SVG favicon linked from all pages.
- Docker vs. Puppy tradeoff section with comparison table and follow-up CTAs.
- Style guide document `consejos_formato.md`.

### Changed
- Toolkit capture form uses `fetch()` AJAX — shows download button inline on success, no page redirect.
- `gracias.html` removed — delivery now happens entirely inline on `toolkit.html`.
- `index.html` `#lead-magnet` section stripped to title + CTA; all detail moved to `toolkit.html`.
- All internal links previously pointing to `#lead-magnet` now point to `toolkit.html`.
- Course cards are fully clickable links navigating to their respective detail pages.
- Extracted reusable `styles.css` shared across all pages.
- `styles.css` split into `base.css`, `components.css`, and `pages.css`. All HTML pages updated to reference the three files. CSS convention (BEM) documented in `consejos_formato.md`.
- Course card titles and "Catálogo de Cursos" heading use neon green (`#39ff14`).
- All scripts use `$DIR` resolution instead of hardcoded absolute paths.
- `push.sh` sources `.env` for `GITHUB_TOKEN` and `GITHUB_REPO`.
- Added `_subject` field to toolkit capture form for clean inbox separation from the waitlist form.
- Added footer to all three course detail pages.
- README rewritten to reflect current architecture and document all scripts.

### Fixed
- Removed dead CSS classes (`.col-side`, `.docker-col`, `.puppy-col`).
- Corrected the courses section title from `Catálogo de Cursos (Fase 2)` to `Catálogo de Cursos`.
- Fixed the secondary CTA hover state so it no longer inherited primary button styling.
- Improved keyboard accessibility with visible `:focus-visible` states across all interactive elements.
- Improved form accessibility with proper label association for email fields.

### Published
- Published the project to GitHub Pages at `https://ukoquique-proves.github.io/favoriteDevPage/`.

## [0.1.0] - 2026-06-19
- Initial release of the PuppyTeach landing page.
- Static HTML/CSS landing page deployed on GitHub Pages.
