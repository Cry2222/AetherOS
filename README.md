# AetherOS

AetherOS is an AI-powered Trading Operating System designed with a modular multi-agent architecture and a dedicated Android mobile client.

## Recommended architecture

```text
Android App (Flutter)
        │
        ▼
FastAPI Backend
        │
AetherOS Core
        │
┌───────┼────────┐
│       │        │
Trading AI Agents Database
Engine
```

## Build stages

1. **Backend**: Python 3.12+, FastAPI, AI agents, and trading engine.
2. **Mobile app**: Flutter Android client.

## Features

- 🤖 Multi-agent AI
- 📊 Market analysis
- 💹 Automated trading
- 🛡 Risk management
- 📰 News intelligence
- 📈 Backtesting
- 🔌 Multi-exchange support
- 🧠 Memory and learning
- 📱 Android mobile app

## Mobile app features

- 📈 Live market dashboard
- 🤖 AI trading assistant
- 💬 Chat with AetherOS
- 📊 Portfolio tracking
- 🔔 Price and trade alerts
- 📰 AI news analysis
- ⚙️ Strategy management
- 📜 Trading history
- 🌙 Dark mode

## Tech stack

- Python 3.12+
- FastAPI
- SQLite/PostgreSQL
- Pandas
- CCXT
- Flutter for Android


## Developer launcher

Use the repository launcher to start backend, run mobile, or build a release APK from a custom folder:

```bash
scripts/aetheros.sh backend --port 8000
scripts/aetheros.sh mobile --api-url http://10.0.2.2:8000
scripts/aetheros.sh apk --api-url http://10.0.2.2:8000
```

Set `AETHEROS_BACKEND_DIR`, `AETHEROS_MOBILE_DIR`, or pass `--dir` when the backend or mobile folder lives somewhere else.

## Backend quick start

```bash
cd backend
python -m venv .venv
source .venv/bin/activate
pip install -e .
uvicorn aetheros.api.app:app --reload
```

## Mobile quick start

```bash
cd mobile
flutter pub get
flutter run -d android
```
