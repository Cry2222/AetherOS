"""Shared API data models for the AetherOS backend."""

from datetime import datetime, timezone
from enum import StrEnum
from typing import Literal

from pydantic import BaseModel, Field


class SignalAction(StrEnum):
    """Supported strategy signal actions."""

    BUY = "buy"
    SELL = "sell"
    HOLD = "hold"


class MarketTicker(BaseModel):
    """Latest market data for a symbol."""

    symbol: str
    price: float = Field(gt=0)
    change_percent: float
    volume: float = Field(ge=0)
    timestamp: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))


class PortfolioPosition(BaseModel):
    """A single portfolio holding."""

    symbol: str
    quantity: float = Field(ge=0)
    average_entry: float = Field(gt=0)
    mark_price: float = Field(gt=0)

    @property
    def market_value(self) -> float:
        return round(self.quantity * self.mark_price, 2)

    @property
    def unrealized_pnl(self) -> float:
        return round((self.mark_price - self.average_entry) * self.quantity, 2)


class StrategySignal(BaseModel):
    """AI/trading-engine strategy recommendation."""

    symbol: str
    action: SignalAction
    confidence: float = Field(ge=0, le=1)
    rationale: str


class ChatRequest(BaseModel):
    """Mobile chat request payload."""

    message: str = Field(min_length=1)
    context: Literal["market", "portfolio", "strategy", "general"] = "general"


class ChatResponse(BaseModel):
    """AI trading assistant response payload."""

    answer: str
    suggested_actions: list[str] = Field(default_factory=list)
