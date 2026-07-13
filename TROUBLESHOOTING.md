# Troubleshooting

## Form gift delivery

### Current flow (as implemented)

The toolkit form uses a `fetch()`-based AJAX submission. There is no page redirect, no Formspree SDK, and no `gracias.html`.

1. User enters email on `toolkit.html` and clicks submit
2. JS intercepts the submit, calls `fetch('https://formspree.io/f/mnjyeeod', ...)` with `Accept: application/json`
3. On success (`res.ok`): form hides, `#form-success` div appears with the download button and a link to the waitlist
4. On failure: form re-enables, `#form-error` div appears
5. Formspree notifies the form owner at the registered account email

The download button links directly to:
```
https://github.com/ukoquique-proves/favoriteDevPage/releases/download/v0.1.0/ops-core
```

### Symptom: success block not appearing after submit

Most likely cause: the fetch returned a non-ok HTTP status. Open DevTools (F12 → Console) and submit the form. Look for a `Formspree error` log with the status code.

- **403**: Formspree is blocking the domain. Check the Formspree dashboard for form `mnjyeeod`.
- **422**: Form validation error — likely a missing required field.
- **Network error / CORS**: The fetch was blocked before reaching Formspree. Check browser console for CORS errors.

### Symptom: download button returns 404

The GitHub release asset does not exist. Go to:
`github.com/ukoquique-proves/favoriteDevPage → Releases`
and verify that release `v0.1.0` exists and contains the `ops-core` asset.

### Release artifact prepared for upload

The packaged release artifact has already been generated and is available at:

- `/tmp/ops-core-release/ops-core-linux-x86_64.tar.gz`

This archive is the file intended to be uploaded as the GitHub release asset for the `ops-core` download link.

### Note on earlier download failures

If the toolkit download appeared to fail before, the issue was not necessarily a broken GitHub release asset. In practice, the problem was usually a mismatch between the URL being used by the landing page and the actual release asset that had been published. When the correct release page was opened directly in GitHub and the asset was downloaded from there, the download worked normally. In other words, the failure mode was usually a stale or incorrect link target rather than a permanent GitHub storage problem.

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
