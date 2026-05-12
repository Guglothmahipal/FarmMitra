# KhetRojgar Backend Localization Readiness

This folder prepares the backend for future localized API responses.

Planned behavior:

- Read `Accept-Language` from incoming requests.
- Resolve it to a supported locale such as `en`, `hi`, or `te`.
- Attach the resolved locale to request context.
- Use that locale for notifications, farming updates, marketplace content, and AI responses.

Current phase:

- No backend APIs are implemented yet.
- Flutter uses local ARB files for static UI text.
- Dynamic/localized backend content will be introduced later.
