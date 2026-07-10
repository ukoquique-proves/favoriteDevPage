# Troubleshooting

## Form gift delivery is not working

### Symptom

Submitting the toolkit form from the live site sends an email to the form owner but the user is not redirected to `gracias.html` and receives no download link.

### Root cause (resolved)

The release asset `Code_Compacter.tar.gz` did not exist on the `favoriteDevPage` repo. The download URL in `gracias.html` was returning 404. This has been fixed — the release `v0.1.0` is now published at:

```
https://github.com/ukoquique-proves/favoriteDevPage/releases/download/v0.1.0/Code_Compacter.tar.gz
```

### How the redirect works (free Formspree plan)

The free Formspree plan does not allow configuring a redirect URL from the dashboard — that's a paid feature. However, Formspree does honor a `_next` hidden field in the form HTML:

```html
<input type="hidden" name="_next" value="https://ukoquique-proves.github.io/favoriteDevPage/gracias.html">
```

Formspree auto-whitelists the submitting domain on first use. This means:

- The first submission from `ukoquique-proves.github.io` triggers the auto-whitelist.
- After that, every submission from that domain will redirect to `gracias.html` automatically.
- No dashboard configuration is required.

### Current form code (toolkit.html)

The form tag and hidden fields are correctly set:

```html
<form action="https://formspree.io/f/mnjyeeod" method="POST">
    <input type="hidden" name="_next" value="https://ukoquique-proves.github.io/favoriteDevPage/gracias.html">
    <input type="hidden" name="_subject" value="Descarga Code Compacter - Toolkit PuppyTeach">
```

### Current delivery flow

1. User submits email on `toolkit.html`
2. Formspree receives the submission and notifies the form owner
3. Browser is redirected to `gracias.html`
4. User sees a download button linking directly to the GitHub release asset
5. User downloads `Code_Compacter.tar.gz`

No autoresponder or email delivery to the user is involved — the download happens inline on `gracias.html`.

### If the redirect stops working

- Check that the form is being submitted from `ukoquique-proves.github.io` (not localhost)
- Confirm the `_next` value in `toolkit.html` matches the live URL exactly
- Check the Formspree dashboard for the form `mnjyeeod` for any error notifications
- If the domain whitelist gets reset, the first submission from the live domain will re-trigger it automatically
