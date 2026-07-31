"""FastAPI application exposing AetherOS services to mobile clients."""

from fastapi import FastAPI

from aetheros.agents.assistant import TradingAssistantAgent
from aetheros.models import ChatRequest, ChatResponse, PortfolioPosition
from aetheros.trading.engine import TradingEngine

app = FastAPI(title="AetherOS API", version="0.1.0")
engine = TradingEngine()
assistant = TradingAssistantAgent()


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok", "service": "aetheros-api"}


@app.get("/markets")
def markets():
    return engine.market_dashboard()


@app.get("/signals/{symbol}")
def signal(symbol: str):
    return engine.signal_for(symbol)


@app.get("/portfolio")
def portfolio() -> list[PortfolioPosition]:
    return [
        PortfolioPosition(symbol="BTC/USD", quantity=0.15, average_entry=64000, mark_price=67250),
        PortfolioPosition(symbol="ETH/USD", quantity=1.2, average_entry=3200, mark_price=3450),
    ]


@app.post("/chat", response_model=ChatResponse)
async def chat(request: ChatRequest) -> ChatResponse:
    answer = await assistant.run(f"{request.context}: {request.message}")
    return ChatResponse(answer=answer, suggested_actions=["Review dashboard", "Check active strategy", "Set alert"])
