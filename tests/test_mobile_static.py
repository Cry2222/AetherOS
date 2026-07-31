from pathlib import Path


def test_mobile_app_contains_core_navigation_destinations():
    source = Path("mobile/lib/main.dart").read_text()

    assert "NavigationDestination(icon: Icon(Icons.candlestick_chart), label: 'Markets')" in source
    assert "NavigationDestination(icon: Icon(Icons.smart_toy), label: 'AI Chat')" in source
    assert "NavigationDestination(icon: Icon(Icons.pie_chart), label: 'Portfolio')" in source
    assert "NavigationDestination(icon: Icon(Icons.tune), label: 'Strategy')" in source
    assert "NavigationDestination(icon: Icon(Icons.notifications), label: 'Alerts')" in source


def test_mobile_api_service_has_demo_data_contracts():
    source = Path("mobile/lib/services/aetheros_api.dart").read_text()

    assert "Future<List<MarketTicker>> fetchMarketDashboard()" in source
    assert "Future<List<PortfolioPosition>> fetchPortfolio()" in source
    assert "Future<String> askAssistant(String message)" in source
    assert "List<TradeAlert> fetchAlerts()" in source
