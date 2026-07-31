import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/market_models.dart';

class AetherOSApi {
  const AetherOSApi({
    this.baseUrl = AetherOSConfig.apiBaseUrl,
    this.useDemoData = AetherOSConfig.useDemoData,
  });

  final String baseUrl;
  final bool useDemoData;

  Future<List<MarketTicker>> fetchMarketDashboard() async {
    if (useDemoData) return _demoMarketDashboard();

    final response = await http.get(Uri.parse('$baseUrl/markets'));
    if (response.statusCode != 200) {
      throw AetherOSApiException('Unable to load markets: HTTP ${response.statusCode}');
    }

    final payload = jsonDecode(response.body) as List<dynamic>;
    return payload.map((item) => MarketTicker.fromJson(item as Map<String, dynamic>)).toList(growable: false);
  }

  Future<List<PortfolioPosition>> fetchPortfolio() async {
    if (useDemoData) return _demoPortfolio();

    final response = await http.get(Uri.parse('$baseUrl/portfolio'));
    if (response.statusCode != 200) {
      throw AetherOSApiException('Unable to load portfolio: HTTP ${response.statusCode}');
    }

    final payload = jsonDecode(response.body) as List<dynamic>;
    return payload.map((item) => PortfolioPosition.fromJson(item as Map<String, dynamic>)).toList(growable: false);
  }

  Future<String> askAssistant(String message) async {
    if (useDemoData) return _demoAssistantAnswer(message);

    final response = await http.post(
      Uri.parse('$baseUrl/chat'),
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message, 'context': 'strategy'}),
    );
    if (response.statusCode != 200) {
      throw AetherOSApiException('Unable to contact assistant: HTTP ${response.statusCode}');
    }

    final payload = jsonDecode(response.body) as Map<String, dynamic>;
    return payload['answer'] as String? ?? 'AetherOS returned an empty response.';
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

  List<MarketTicker> _demoMarketDashboard() {
    return const [
      MarketTicker(symbol: 'BTC/USD', price: 67250, changePercent: 1.8, volume: 12500),
      MarketTicker(symbol: 'ETH/USD', price: 3450, changePercent: -0.4, volume: 8200),
      MarketTicker(symbol: 'AAPL', price: 214.30, changePercent: 0.7, volume: 48100000),
      MarketTicker(symbol: 'NVDA', price: 118.65, changePercent: 2.1, volume: 39200000),
    ];
  }

  List<PortfolioPosition> _demoPortfolio() {
    return const [
      PortfolioPosition(symbol: 'BTC/USD', quantity: 0.15, averageEntry: 64000, markPrice: 67250),
      PortfolioPosition(symbol: 'ETH/USD', quantity: 1.2, averageEntry: 3200, markPrice: 3450),
      PortfolioPosition(symbol: 'AAPL', quantity: 12, averageEntry: 189.40, markPrice: 214.30),
    ];
  }

  String _demoAssistantAnswer(String message) {
    if (message.toLowerCase().contains('risk')) {
      return 'Risk view: keep position sizes small, define invalidation before entry, and set alerts around stop levels.';
    }
    return 'AetherOS can analyze markets, explain strategy signals, summarize news, and review portfolio exposure.';
  }
}

class AetherOSApiException implements Exception {
  const AetherOSApiException(this.message);

  final String message;

  @override
  String toString() => message;
}
