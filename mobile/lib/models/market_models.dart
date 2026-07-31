class MarketTicker {
  const MarketTicker({
    required this.symbol,
    required this.price,
    required this.changePercent,
    required this.volume,
  });

  factory MarketTicker.fromJson(Map<String, dynamic> json) {
    return MarketTicker(
      symbol: json['symbol'] as String,
      price: (json['price'] as num).toDouble(),
      changePercent: (json['change_percent'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
    );
  }

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

  factory PortfolioPosition.fromJson(Map<String, dynamic> json) {
    return PortfolioPosition(
      symbol: json['symbol'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      averageEntry: (json['average_entry'] as num).toDouble(),
      markPrice: (json['mark_price'] as num).toDouble(),
    );
  }

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
