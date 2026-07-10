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
https://github.com/ukoquique-proves/favoriteDevPage/releases/download/v0.1.0/Code_Compacter.tar.gz
```

### Symptom: success block not appearing after submit

Most likely cause: the fetch returned a non-ok HTTP status. Open DevTools (F12 → Console) and submit the form. Look for a `Formspree error` log with the status code.

- **403**: Formspree is blocking the domain. Check the Formspree dashboard for form `mnjyeeod`.
- **422**: Form validation error — likely a missing required field.
- **Network error / CORS**: The fetch was blocked before reaching Formspree. Check browser console for CORS errors.

### Symptom: download button returns 404

The GitHub release asset does not exist. Go to:
`github.com/ukoquique-proves/favoriteDevPage → Releases`
and verify that release `v0.1.0` exists and contains `Code_Compacter.tar.gz`.

### Symptom: form owner not receiving notification emails

Formspree sends a notification to the account email registered on formspree.io — not to the email submitted by the visitor. Check spam folder. Verify the notification address in the Formspree dashboard under form `mnjyeeod → Settings → Notifications`.
