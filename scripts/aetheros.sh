#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKEND_DIR="${AETHEROS_BACKEND_DIR:-$ROOT_DIR/backend}"
MOBILE_DIR="${AETHEROS_MOBILE_DIR:-$ROOT_DIR/mobile}"
HOST="${AETHEROS_HOST:-0.0.0.0}"
PORT="${AETHEROS_PORT:-8000}"
API_URL="${AETHEROS_API_BASE_URL:-http://10.0.2.2:$PORT}"

usage() {
  cat <<USAGE
AetherOS developer launcher

Usage:
  scripts/aetheros.sh backend [--dir PATH] [--host HOST] [--port PORT]
  scripts/aetheros.sh mobile [--dir PATH] [--api-url URL] [--device DEVICE_ID]
  scripts/aetheros.sh apk [--dir PATH] [--api-url URL]

Environment overrides:
  AETHEROS_BACKEND_DIR    Backend folder, default: $ROOT_DIR/backend
  AETHEROS_MOBILE_DIR     Mobile folder, default: $ROOT_DIR/mobile
  AETHEROS_HOST           Backend bind host, default: 0.0.0.0
  AETHEROS_PORT           Backend port, default: 8000
  AETHEROS_API_BASE_URL   Mobile API URL, default: http://10.0.2.2:$PORT

Examples:
  scripts/aetheros.sh backend
  scripts/aetheros.sh backend --dir /path/to/backend --port 8080
  scripts/aetheros.sh mobile --api-url http://10.0.2.2:8000
  scripts/aetheros.sh apk --api-url https://api.example.com
USAGE
}

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 127
  fi
}

run_backend() {
  require_command python
  cd "$BACKEND_DIR"
  if ! python -c 'import fastapi, uvicorn' >/dev/null 2>&1; then
    echo "Installing backend dependencies into the active Python environment..."
    python -m pip install -e .
  fi
  exec python -m uvicorn aetheros.api.app:app --host "$HOST" --port "$PORT" --reload
}

run_mobile() {
  require_command flutter
  cd "$MOBILE_DIR"
  flutter pub get
  exec flutter run -d "${DEVICE_ID:-android}" --dart-define=AETHEROS_API_BASE_URL="$API_URL" --dart-define=AETHEROS_USE_DEMO_DATA=false
}

build_apk() {
  require_command flutter
  cd "$MOBILE_DIR"
  flutter pub get
  flutter build apk --release --dart-define=AETHEROS_API_BASE_URL="$API_URL" --dart-define=AETHEROS_USE_DEMO_DATA=false
  echo "APK created at: $MOBILE_DIR/build/app/outputs/flutter-apk/app-release.apk"
}

COMMAND="${1:-help}"
if [[ $# -gt 0 ]]; then shift; fi
DEVICE_ID=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dir)
      case "$COMMAND" in
        backend) BACKEND_DIR="$2" ;;
        mobile|apk) MOBILE_DIR="$2" ;;
      esac
      shift 2
      ;;
    --host) HOST="$2"; shift 2 ;;
    --port) PORT="$2"; API_URL="http://10.0.2.2:$PORT"; shift 2 ;;
    --api-url) API_URL="$2"; shift 2 ;;
    --device) DEVICE_ID="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage; exit 2 ;;
  esac
done

case "$COMMAND" in
  backend) run_backend ;;
  mobile) run_mobile ;;
  apk) build_apk ;;
  help|-h|--help) usage ;;
  *) echo "Unknown command: $COMMAND" >&2; usage; exit 2 ;;
esac
