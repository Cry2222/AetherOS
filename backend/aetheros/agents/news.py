"""News intelligence agent for headline analysis."""

from aetheros.agents.base import Agent


class NewsAnalysisAgent(Agent):
    """Scores news sentiment with deterministic heuristics."""

    name = "news-analysis"

    async def run(self, prompt: str) -> str:
        positive_terms = {"beat", "growth", "approval", "partnership", "upgrade"}
        negative_terms = {"miss", "lawsuit", "downgrade", "hack", "probe"}
        words = set(prompt.lower().split())
        score = len(words & positive_terms) - len(words & negative_terms)
        if score > 0:
            return "bullish"
        if score < 0:
            return "bearish"
        return "neutral"
