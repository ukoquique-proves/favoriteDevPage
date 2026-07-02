# Changelog

All notable changes to this project will be documented in this file.

This project adheres to the [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format.

## [Unreleased]

### Added
- Lightweight SVG favicon linked from `index.html`.
- Formspree AJAX integration using `@formspree/ajax` for asynchronous lead capture without page reload.
- Custom success (`data-fs-success`) and error (`data-fs-error`) status alerts inside the lead magnet form.
- Localized validation feedback with a dedicated error span (`data-fs-error="email"`).
- Empathetic status badges and a clearer hero CTA.
- Docker vs. Puppy tradeoff section with comparison table and follow-up CTAs.
- Developer-focused `Code Compacter CLI & Desktop` lead magnet section with toolkit-style presentation.
- Download-oriented content highlighting `.desktop` integration.
- Style guide document `consejos_formato.md`.

### Changed
- Replaced remaining lead form inline styles with reusable CSS classes.
- Improved dynamic form feedback accessibility with `aria-live`, `role`, and clearer field descriptions.
- Clarified CTA copy so hero and section links match their real destinations and primary conversion path.
- Restructured `ROADMAP.md` into grouped sections covering form flow, CTA consistency, accessibility, SEO, cleanup, and launch tasks.
- Enhanced course micro-copy for a more senior technical audience.
- Improved mobile layout for the comparison table and refined code block presentation.
- Consolidated repeated header, navigation, lead magnet, form, and table styles into reusable stylesheet classes.

### Fixed
- Corrected the courses section title from `Catálogo de Cursos (Fase 2)` to `Catálogo de Cursos`.
- Removed redundant CSS declarations, including duplicate `pre` styling, to keep `index.html` cleaner.
- Fixed the secondary CTA hover state so `Ver programa del Curso 2` no longer inherited the primary button hover styling.
- Improved keyboard accessibility with visible `:focus-visible` states for navigation links, CTA links, buttons, and the email input.
- Improved form accessibility by adding a proper label association for the email field instead of relying only on the placeholder.
- Improved table accessibility by adding `scope="col"` to header cells and a descriptive comparison table caption.

### Published
- Published the project to GitHub Pages at `https://ukoquique-proves.github.io/fastDevPage/`.

## [0.1.0] - 2026-06-19
- Initial release of the PuppyTeach landing page.
- Static HTML/CSS landing page deployed on GitHub Pages.
