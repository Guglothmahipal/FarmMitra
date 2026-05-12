# Localization Contract

The mobile app sends locale context to future APIs using:

```http
Accept-Language: en
Accept-Language: hi
Accept-Language: te
```

Backend responses that may become localized later:

- Local notifications
- Farming news
- Mandi and market updates
- Weather guidance
- Job recommendations
- AI assistant responses
- Marketplace vendor/product metadata

Static Flutter UI text remains in ARB files under:

```text
mobile/farmmitra_app/lib/l10n/
```

Adding a future language should require:

1. Add a Flutter ARB file.
2. Add the locale to the app locale enum.
3. Add backend locale support to Accept-Language resolution.
