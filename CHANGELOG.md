# Changelog

All notable changes to this project will be documented in this file.

This project adheres to the [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format.

## [Unreleased]

### Fixed
- `toolkit.html` / `toolkit.html.template`: modal buy and collaborator paths were UI-only mockups with no actual delivery. Both paths now capture email and submit to Formspree (`mnjyeeod`) with distinct subjects (`Code_Compacter — Solicitud de compra` / `Code_Compacter — Acceso colaborador (gratuito)`) so requests reach the operator for manual fulfillment. Includes loading state, error handling, and clean reset on close.
- `toolkit.html.template`: code sample switched from Rust (`src/main.rs`) to Python (`src/main.py`) to match the "escrito en Python nativo" claim in the features list.
- Added a Playwright browser smoke test at `tools/test_toolkit_modal.py` to guard the real modal behavior against regressions like `[hidden]` being overridden by `display: flex`.

### Changed
- Nav link `[ Toolkit_Gratis ]` → `[ Toolkit ]` across all pages (header partial and all templates).
- `index.html` lead-magnet section: eyebrow `TOOLKIT GRATUITO` → `TOOLKIT PARA EQUIPOS`, CTA button `Obtener toolkit gratis` → `Descubrir el toolkit`.
- `toolkit.html` hero eyebrow: `TOOLKIT GRATUITO` → `TOOLKIT PARA EQUIPOS`.



### Changed
- `index.html`: replaced `[ Trade-off ]` nav link and tradeoff section with `[ Colabora ]` section offering co-creator and project-partner paths, aligned with ASPIRACION.md tone.
- All pages: `<meta name="author">` corrected from "Quique Uko" to "Héctor Corbellini".
- `base.css`, `components.css`, `pages.css`: reduced section spacing (margin-bottom `4rem→2.5rem`, section-specific `6rem→3rem` top margins, pilares/servicios/ética padding `3rem→1.5rem`).

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
- Replaced fragile grep-based HTML checks in `check.sh` with a robust Python parser (`tools/html_checker.py`) that strictly validates structure and internal link integrity.
- Replaced hardcoded duplication of `<head>`, `<header>`, and `<footer>` tags across HTML files by creating a lightweight Python static site generator (`tools/build.py`).
- All `.html` files converted into `.html.template` templates with placeholders, utilizing shared files from the new `partials/` directory.
- `build.sh` script simplified to just run the Python builder.
### Fixed
- Fixed a broken internal link anchor on `index.html` by renaming `id="benchmark"` to `id="tradeoff"`, which the new Python parser correctly caught.
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
