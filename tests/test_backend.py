import pytest

fastapi = pytest.importorskip("fastapi")
from fastapi.testclient import TestClient

from aetheros.api.app import app

client = TestClient(app)


def test_health_endpoint():
    response = client.get("/health")

    assert response.status_code == 200
    assert response.json()["status"] == "ok"


def test_markets_endpoint_returns_dashboard():
    response = client.get("/markets")

    assert response.status_code == 200
    assert any(item["symbol"] == "BTC/USD" for item in response.json())


def test_chat_endpoint_returns_suggestions():
    response = client.post("/chat", json={"message": "How should I manage risk?", "context": "strategy"})

    assert response.status_code == 200
    assert "position sizing" in response.json()["answer"]
    assert response.json()["suggested_actions"]
