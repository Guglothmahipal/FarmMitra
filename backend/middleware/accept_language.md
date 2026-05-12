# Accept-Language Middleware Placeholder

Future backend middleware should:

1. Read the `Accept-Language` request header.
2. Match it against supported locales.
3. Fall back to English when unsupported or missing.
4. Store the resolved locale in request context.

Example:

```http
Accept-Language: te
```

Future resolved context:

```text
locale=te
```

This is documentation only for the current MVP phase.
