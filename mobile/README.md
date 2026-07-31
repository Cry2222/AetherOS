# AetherOS Mobile

Flutter Android client for AetherOS. The app is dark-mode first and is designed to consume the FastAPI backend once real API transport is wired in.

## Implemented app areas

- Live market dashboard with price, percentage change, and volume rows.
- AI trading assistant chat mock connected through a local `AetherOSApi` service abstraction.
- Portfolio tracking with value and unrealized PnL summary cards.
- Strategy management screen with strategy status and risk levels.
- Price and trade alerts screen with enabled/disabled alert state.
- Bottom navigation optimized for Android.

## Project structure

```text
lib/
├── main.dart                 # App shell, routes, screens, and shared UI
├── models/market_models.dart # Market, portfolio, alert, and strategy models
├── services/aetheros_api.dart# API abstraction currently backed by demo data
└── widgets/metric_card.dart  # Reusable dashboard metric card
```

## Run on Android

```bash
cd mobile
flutter pub get
flutter run -d android
```

## Next development steps

1. Replace the demo `AetherOSApi` methods with HTTP calls to the FastAPI backend.
2. Add authentication and secure storage for API credentials.
3. Add push notifications for price and trade alerts.
4. Add widget tests once Flutter tooling is available in CI.
