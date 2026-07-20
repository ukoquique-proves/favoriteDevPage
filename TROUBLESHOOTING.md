# Troubleshooting

## Form gift delivery

### Current flow (as implemented)

The toolkit uses a modal-driven flow in `toolkit.html` with two paths:

1. Buy path: user enters their email and the page submits a Formspree request for manual fulfillment.
2. Collaborator path: user enters the collaborator password, their email, and the page submits a separate Formspree request for manual verification.

Both flows use `fetch()` with Formspree (`https://formspree.io/f/mnjyeeod`) and no page redirect. The collaborator path now exposes a direct download button immediately after the password is validated, while the buy path remains manual and only shows the internal success state.

The delivery is manual, not automatic: once Formspree receives the submission, the operator may still fulfill the request outside the page, but the collaborator path no longer blocks the delivery on that network step.

### Symptom: success block not appearing after submit

Most likely cause: the fetch returned a non-ok HTTP status. Open DevTools (F12 → Console) and submit the form. Look for a `Formspree error` log with the status code.

- **403**: Formspree is blocking the domain. Check the Formspree dashboard for form `mnjyeeod`.
- **422**: Form validation error — likely a missing required field.
- **Network error / CORS**: The fetch was blocked before reaching Formspree. Check browser console for CORS errors.

### Symptom: manual fulfillment is not happening

If the request reaches Formspree but no operator action follows, check the Formspree inbox and the configured notification settings for form `mnjyeeod`. The page itself does not trigger a download or any local asset delivery.

### Symptom: form owner not receiving notification emails

Formspree sends a notification to the account email registered on formspree.io — not to the email submitted by the visitor. Check spam folder. Verify the notification address in the Formspree dashboard under form `mnjyeeod → Settings → Notifications`.

## Local preview mismatch and missing landing additions

### Symptom: `http://localhost:8080/` does not show the expected landing-page changes

This usually happens when a different local server is still bound to port 8080, or when the preview is being served from a different project folder. In this repository, the landing page must be served from the Uko Landing project itself, not from the UkoWeb or STRATEGY workspace.

Practical checks:

1. Stop any other local preview process that might be serving port 8080.
2. Serve the landing project directly from this folder with a static server.
3. Confirm that the response body is the HTML from this repository and not the UkoWeb/Vite page.

### What must still be added to the landing page

The landing page is currently functional as a static lead-capture site, but it still needs the following additions to fully reflect the intended Teledígitos / PuppyTeach positioning:

- A clearer hero section that emphasizes architectural control, determinism, and debt reduction caused by AI instead of hardware-only messaging.
- A stronger “why this matters” section for CTOs and technical leaders, focused on auditable context, predictable deployment, and lower long-term maintenance cost.
- A dedicated “Aspiración / Teledígitos” narrative block that links the landing experience to the broader strategy and philosophy behind the ecosystem.
- A clearer CTA hierarchy: one primary CTA for the toolkit, one secondary CTA for the courses, and one explicit CTA for the waitlist or cohort registration.
- A more explicit connection between the toolkit and the broader offer: extractor de contexto arquitectónico seguro, cursos, and the operational model behind Teledígitos.
- A final trust/authority section that explains who the audience is, what the offer is, and why the approach is different from general AI tooling.

### Expected outcome

Once those additions are present, the landing page should feel like the entry point of the ecosystem: it should capture interest, explain the value proposition clearly, and point visitors toward the toolkit, the courses, and the broader Teledígitos narrative.
