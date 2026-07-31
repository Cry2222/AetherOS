class MarketTicker {
  const MarketTicker({
    required this.symbol,
    required this.price,
    required this.changePercent,
    required this.volume,
  });

  final String symbol;
  final double price;
  final double changePercent;
  final double volume;

  bool get isPositive => changePercent >= 0;
}

class PortfolioPosition {
  const PortfolioPosition({
    required this.symbol,
    required this.quantity,
    required this.averageEntry,
    required this.markPrice,
  });

  final String symbol;
  final double quantity;
  final double averageEntry;
  final double markPrice;

  double get marketValue => quantity * markPrice;
  double get unrealizedPnl => (markPrice - averageEntry) * quantity;
}

class TradeAlert {
  const TradeAlert({
    required this.symbol,
    required this.condition,
    required this.targetPrice,
    required this.enabled,
  });

  final String symbol;
  final String condition;
  final double targetPrice;
  final bool enabled;
}

class StrategyCardModel {
  const StrategyCardModel({
    required this.name,
    required this.status,
    required this.riskLevel,
    required this.description,
  });

  final String name;
  final String status;
  final String riskLevel;
  final String description;
}
