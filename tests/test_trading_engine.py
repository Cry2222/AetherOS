import pytest

pytest.importorskip("pydantic")

from aetheros.models import SignalAction
from aetheros.trading.engine import TradingEngine


def test_market_dashboard_contains_configured_watchlist():
    engine = TradingEngine()

    tickers = engine.market_dashboard()

    assert {ticker.symbol for ticker in tickers} >= {"BTC/USD", "ETH/USD", "AAPL"}


def test_signal_for_unknown_symbol_holds():
    engine = TradingEngine()

    signal = engine.signal_for("MSFT")

    assert signal.symbol == "MSFT"
    assert signal.action is SignalAction.HOLD
