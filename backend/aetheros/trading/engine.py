"""Trading engine orchestration for market data and strategy signals."""

from aetheros.models import MarketTicker, SignalAction, StrategySignal


class TradingEngine:
    """In-memory trading engine suitable for local development and mobile demos."""

    def __init__(self) -> None:
        self._watchlist = {
            "BTC/USD": MarketTicker(symbol="BTC/USD", price=67250.0, change_percent=1.8, volume=12500),
            "ETH/USD": MarketTicker(symbol="ETH/USD", price=3450.0, change_percent=-0.4, volume=8200),
            "AAPL": MarketTicker(symbol="AAPL", price=214.3, change_percent=0.7, volume=48100000),
        }

    def market_dashboard(self) -> list[MarketTicker]:
        """Return the latest tracked market tickers."""
        return list(self._watchlist.values())

    def signal_for(self, symbol: str) -> StrategySignal:
        """Generate a simple momentum signal for a symbol."""
        ticker = self._watchlist.get(symbol.upper()) or self._watchlist.get(symbol)
        if ticker is None:
            return StrategySignal(
                symbol=symbol.upper(),
                action=SignalAction.HOLD,
                confidence=0.35,
                rationale="Symbol is not on the configured watchlist yet.",
            )
        if ticker.change_percent > 1:
            return StrategySignal(symbol=ticker.symbol, action=SignalAction.BUY, confidence=0.68, rationale="Positive momentum with elevated interest.")
        if ticker.change_percent < -1:
            return StrategySignal(symbol=ticker.symbol, action=SignalAction.SELL, confidence=0.62, rationale="Negative momentum requires defensive risk management.")
        return StrategySignal(symbol=ticker.symbol, action=SignalAction.HOLD, confidence=0.55, rationale="Momentum is mixed; wait for confirmation.")
