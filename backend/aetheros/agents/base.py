"""Base primitives for AetherOS AI agents."""

from abc import ABC, abstractmethod


class Agent(ABC):
    """Minimal async interface implemented by all AI agents."""

    name: str

    @abstractmethod
    async def run(self, prompt: str) -> str:
        """Return an agent response for the supplied prompt."""
