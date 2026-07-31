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
