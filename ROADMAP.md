# ROADMAP

## Done

- [x] Resolve conflicts and merge the remote design and accessibility improvements.
- [x] Integrate the Formspree AJAX script and validate the subscription flow locally.
- [x] Replace `TU_ID_AQUI` with the real Formspree form ID (`mnjyeeod`).
- [x] Host `Code_Compacter.tar.gz` in GitHub Releases for direct delivery.
- [x] Replace form inline styles with reusable CSS classes.
- [x] Improve form accessibility with live regions and clearer field description wiring.

## Form flow

- [ ] Configure the Formspree autoresponder email with the download link.
- [ ] Add a visible download button inside the success state so visitors can get the gift immediately.
- [ ] Create a thank-you page in `gracias.html` and configure the hidden `_next` field for a no-JavaScript fallback flow.
- [ ] Test the published form end to end and confirm that subscription emails are actually received.

## CTA consistency

- [ ] Review CTA copy so every button and link accurately describes its destination.
- [ ] Rename or rewrite `Clonar entorno base (Gratis)` if it only scrolls to the lead capture section.
- [ ] Recheck the hero CTA and section CTAs so the primary conversion path is explicit and consistent.

## Accessibility

- [ ] Add a skip link at the top of the page for keyboard users.
- [ ] Associate inline validation feedback with the email field in the most robust way during real error states.
- [ ] Review emoji-heavy labels and CTA text to ensure meaning does not depend on symbols alone.
- [ ] Test keyboard navigation and screen reader announcements on the published page.

## SEO and metadata

- [ ] Add Open Graph metadata for title, description, URL, and preview image.
- [ ] Add Twitter card metadata.
- [ ] Add a canonical URL.
- [ ] Add a favicon and social preview image assets.

## Technical cleanup

- [ ] Move the remaining repeated color values into CSS custom properties.
- [ ] Group stylesheet rules more explicitly by component for easier maintenance.
- [ ] Add short internal comments around the Formspree integration contract and required `data-fs-*` hooks.
- [ ] Consider splitting the page into `index.html`, `styles.css`, and `script.js` if the landing page grows further.

## Credibility and content

- [ ] Add a short benchmark methodology note to explain how RAM and latency figures were measured.
- [ ] Reword absolute performance claims where needed so they read as measured results, not universal guarantees.
- [ ] Link to supporting benchmark details if a separate note or page is created later.

## Launch and distribution

- [ ] Publish the outreach post on Dev.to or Reddit.
- [ ] Prepare a simple release checklist for future landing page updates on GitHub Pages.
