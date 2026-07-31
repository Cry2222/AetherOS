"""Rule-backed assistant agent used until an LLM provider is configured."""

from aetheros.agents.base import Agent


class TradingAssistantAgent(Agent):
    """Provides cautious trading guidance for the mobile chat feature."""

    name = "trading-assistant"

    async def run(self, prompt: str) -> str:
        normalized = prompt.lower()
        if "risk" in normalized:
            return "Keep position sizing small, define invalidation before entry, and use alerts for stop levels."
        if "news" in normalized:
            return "Summarize catalysts, separate facts from sentiment, and wait for market confirmation."
        return "I can review market context, portfolio exposure, trading signals, and risk controls."
