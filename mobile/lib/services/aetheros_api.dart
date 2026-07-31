import '../models/market_models.dart';

class AetherOSApi {
  const AetherOSApi();

  Future<List<MarketTicker>> fetchMarketDashboard() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return const [
      MarketTicker(symbol: 'BTC/USD', price: 67250, changePercent: 1.8, volume: 12500),
      MarketTicker(symbol: 'ETH/USD', price: 3450, changePercent: -0.4, volume: 8200),
      MarketTicker(symbol: 'AAPL', price: 214.30, changePercent: 0.7, volume: 48100000),
      MarketTicker(symbol: 'NVDA', price: 118.65, changePercent: 2.1, volume: 39200000),
    ];
  }

  Future<List<PortfolioPosition>> fetchPortfolio() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return const [
      PortfolioPosition(symbol: 'BTC/USD', quantity: 0.15, averageEntry: 64000, markPrice: 67250),
      PortfolioPosition(symbol: 'ETH/USD', quantity: 1.2, averageEntry: 3200, markPrice: 3450),
      PortfolioPosition(symbol: 'AAPL', quantity: 12, averageEntry: 189.40, markPrice: 214.30),
    ];
  }

  Future<String> askAssistant(String message) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    if (message.toLowerCase().contains('risk')) {
      return 'Risk view: keep position sizes small, define invalidation before entry, and set alerts around stop levels.';
    }
    return 'AetherOS can analyze markets, explain strategy signals, summarize news, and review portfolio exposure.';
  }

  List<TradeAlert> fetchAlerts() {
    return const [
      TradeAlert(symbol: 'BTC/USD', condition: 'Breaks above', targetPrice: 69000, enabled: true),
      TradeAlert(symbol: 'ETH/USD', condition: 'Falls below', targetPrice: 3300, enabled: true),
      TradeAlert(symbol: 'AAPL', condition: 'Breaks above', targetPrice: 220, enabled: false),
    ];
  }

  List<StrategyCardModel> fetchStrategies() {
    return const [
      StrategyCardModel(
        name: 'Momentum Scout',
        status: 'Active',
        riskLevel: 'Medium',
        description: 'Tracks cross-asset momentum and asks for confirmation before entries.',
      ),
      StrategyCardModel(
        name: 'Risk Sentinel',
        status: 'Always on',
        riskLevel: 'Low',
        description: 'Monitors portfolio drawdown, concentration, and stop alerts.',
      ),
    ];
  }
}
