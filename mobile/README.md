# AetherOS Mobile

Flutter Android client for AetherOS. The app is dark-mode first and can run with either demo data or a live FastAPI backend.

## Implemented app areas

- Live market dashboard with price, percentage change, and volume rows.
- AI trading assistant chat connected through the configurable `AetherOSApi` service abstraction.
- Portfolio tracking with value and unrealized PnL summary cards.
- Strategy management screen with strategy status and risk levels.
- Price and trade alerts screen with enabled/disabled alert state.
- Bottom navigation optimized for Android.

## Project structure

```text
lib/
├── config.dart               # Dart define based runtime configuration
├── main.dart                 # App shell, routes, screens, and shared UI
├── models/market_models.dart # Market, portfolio, alert, and strategy models
├── services/aetheros_api.dart# API abstraction for demo data or FastAPI HTTP calls
└── widgets/metric_card.dart  # Reusable dashboard metric card
```

## Run with demo data

```bash
cd mobile
flutter pub get
flutter run -d android
```

## Run against a local backend

Start the backend from the repository root:

```bash
scripts/aetheros.sh backend
```

Run the Android app against the host backend. Android emulator networking uses `10.0.2.2` to reach your computer:

```bash
scripts/aetheros.sh mobile --api-url http://10.0.2.2:8000
```

For a physical Android device, replace the URL with your computer LAN IP, for example `http://192.168.1.20:8000`.

## Build a local APK

```bash
scripts/aetheros.sh apk --api-url http://10.0.2.2:8000
```

The release APK is written to `mobile/build/app/outputs/flutter-apk/app-release.apk`.

## GitHub APK downloads

The repository includes a GitHub Actions workflow that builds a release APK and uploads it as the `aetheros-android-apk` artifact. After pushing to GitHub, open the workflow run and download the artifact to test on Android.

## Next development steps

1. Add authentication and secure storage for API credentials.
2. Persist alerts and strategy settings in the FastAPI backend.
3. Add push notifications for price and trade alerts.
4. Add widget tests once Flutter tooling is available in CI.
