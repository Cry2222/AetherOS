from pathlib import Path


def test_mobile_app_contains_core_navigation_destinations():
    source = Path("mobile/lib/main.dart").read_text()

    assert "NavigationDestination(icon: Icon(Icons.candlestick_chart), label: 'Markets')" in source
    assert "NavigationDestination(icon: Icon(Icons.smart_toy), label: 'AI Chat')" in source
    assert "NavigationDestination(icon: Icon(Icons.pie_chart), label: 'Portfolio')" in source
    assert "NavigationDestination(icon: Icon(Icons.tune), label: 'Strategy')" in source
    assert "NavigationDestination(icon: Icon(Icons.notifications), label: 'Alerts')" in source


def test_mobile_api_service_has_backend_configuration_contracts():
    source = Path("mobile/lib/services/aetheros_api.dart").read_text()
    config = Path("mobile/lib/config.dart").read_text()

    assert "Future<List<MarketTicker>> fetchMarketDashboard()" in source
    assert "Future<List<PortfolioPosition>> fetchPortfolio()" in source
    assert "Future<String> askAssistant(String message)" in source
    assert "AETHEROS_API_BASE_URL" in config
    assert "AETHEROS_USE_DEMO_DATA" in config


def test_developer_launcher_supports_backend_mobile_and_apk_commands():
    source = Path("scripts/aetheros.sh").read_text()

    assert "scripts/aetheros.sh backend" in source
    assert "scripts/aetheros.sh mobile" in source
    assert "scripts/aetheros.sh apk" in source
    assert "AETHEROS_BACKEND_DIR" in source
    assert "AETHEROS_MOBILE_DIR" in source


def test_github_workflow_uploads_android_apk_artifact():
    source = Path(".github/workflows/android-apk.yml").read_text()

    assert "flutter build apk --release" in source
    assert "actions/upload-artifact" in source
    assert "app-release.apk" in source
