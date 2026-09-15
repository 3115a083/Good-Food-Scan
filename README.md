# Good Food Scan

Privacy-friendly food barcode scanner built with Flutter and Material 3.

## Current scaffold

- Barcode scanning via `mobile_scanner`
- Open Food Facts API v3 product lookup
- Initial product page with Nutri-Score, Green-Score, NOVA and ingredients
- Navigation for Scan, History, Favorites and Settings
- Light, dark and system themes
- User-selectable Material 3 seed color palettes
- Placeholders for vegan/vegetarian analysis, ultimate parent ownership and BDS status

## Architecture

```text
lib/
  main.dart
  src/
    app.dart
    data/open_food_facts_api.dart
    features/home/
    features/scanner/
    features/product/
    features/settings/
```

The app should remain local-first and resource-efficient. Product facts come from Open Food Facts. Ownership and BDS data are separate domains with provenance and update timestamps.

## Run

```bash
flutter pub get
flutter run
```

## Next milestones

1. Persist theme and palette settings.
2. Add typed product models and robust OFF response mapping.
3. Implement scan history and favorites locally.
4. Add full nutrition, allergens, additives, labels and score explanations.
5. Implement vegan/vegetarian evidence model.
6. Add brand to ultimate-parent resolver.
7. Add signed/versioned BDS dataset updater with official-source provenance.
8. Add tests, Android/iOS permissions and release configuration.

Long-lived product goals, development status and decisions are maintained in `3115a083/promptguides`, folder `Good-Food-Scan`.
