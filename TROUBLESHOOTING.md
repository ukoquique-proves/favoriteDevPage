# Troubleshooting

## Form gift delivery is not working

### Symptom

Submitting the toolkit gift form appears to succeed from the UI, but the user does not receive the expected confirmation message and does not receive the gift.

### What is currently known

- The site uses a static HTML form that posts to Formspree.
- The page includes a redirect target for the success/fallback flow.
- The direct gift download is currently linked from the success page, not from Formspree itself.
- The previous client-side Formspree SDK approach was not reliable in this setup, so the form was switched to the standard browser submission path.
- The repository still needs a real end-to-end verification of the live published form flow.

### Likely causes to investigate

1. Formspree endpoint configuration
   - The form may be posting to the right endpoint, but the Formspree form must be configured correctly in the Formspree dashboard.
   - If the form is not active, not receiving submissions, or missing the expected endpoint settings, the submission may appear to fail silently.

2. Redirect/success page flow
   - The current flow depends on the browser reaching the success page after Formspree accepts the submission.
   - If the redirect is blocked, not followed, or the success page is not being served as expected, the user will not see the gift link.

3. Delivery mechanism mismatch
   - The gift is not being delivered by Formspree itself.
   - The current design expects the success page to present a direct download link after the form submission flow completes.
   - If the submission is not completing that path, the user will not receive the gift through this mechanism.

4. Live deployment vs local behavior
   - Local testing does not guarantee the published GitHub Pages deployment is behaving the same way.
   - The form must be tested against the live URL, not only the local preview.

### Recommended next steps

- Test the live form from the published site and confirm whether the browser reaches the success page.
- Check the Formspree dashboard for incoming submissions and any error notifications.
- Verify whether the success page is reachable and whether the download link is present.
- If needed, replace the current redirect-based flow with a more deterministic delivery mechanism such as a direct email delivery action or a backend endpoint.

### Notes

This document is intentionally explicit about the current uncertainty. The goal is to preserve the investigation trail while the form delivery issue is being debugged.
