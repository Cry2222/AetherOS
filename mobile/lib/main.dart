import 'package:flutter/material.dart';

import 'models/market_models.dart';
import 'services/aetheros_api.dart';
import 'widgets/metric_card.dart';

void main() {
  runApp(const AetherOSApp());
}

class AetherOSApp extends StatelessWidget {
  const AetherOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF39D98A),
      brightness: Brightness.dark,
    );

    return MaterialApp(
      title: 'AetherOS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: const Color(0xFF080B12),
        colorScheme: colorScheme,
        cardTheme: CardThemeData(
          color: const Color(0xFF111827),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _selectedIndex = 0;

  final _pages = const [
    DashboardPage(),
    AssistantPage(),
    PortfolioPage(),
    StrategyPage(),
    AlertsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AetherOS'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.nightlight_round),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.candlestick_chart), label: 'Markets'),
          NavigationDestination(icon: Icon(Icons.smart_toy), label: 'AI Chat'),
          NavigationDestination(icon: Icon(Icons.pie_chart), label: 'Portfolio'),
          NavigationDestination(icon: Icon(Icons.tune), label: 'Strategy'),
          NavigationDestination(icon: Icon(Icons.notifications), label: 'Alerts'),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const api = AetherOSApi();

    return FutureBuilder<List<MarketTicker>>(
      future: api.fetchMarketDashboard(),
      builder: (context, snapshot) {
        final tickers = snapshot.data ?? const <MarketTicker>[];
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const _HeroCard(),
            const SizedBox(height: 16),
            if (!snapshot.hasData) const LinearProgressIndicator(),
            Text('Live market dashboard', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            for (final ticker in tickers) _MarketTile(ticker: ticker),
          ],
        );
      },
    );
  }
}

class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  final _controller = TextEditingController(text: 'How should I manage risk today?');
  String _answer = 'Ask AetherOS about market context, portfolio exposure, risk, or strategy signals.';
  bool _loading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    setState(() => _loading = true);
    final answer = await const AetherOSApi().askAssistant(_controller.text);
    setState(() {
      _answer = answer;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('AI trading assistant', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        const Text('Chat with AetherOS for explainable signals, risk controls, and news analysis.'),
        const SizedBox(height: 16),
        TextField(
          controller: _controller,
          minLines: 2,
          maxLines: 4,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Message',
            prefixIcon: Icon(Icons.chat_bubble_outline),
          ),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: _loading ? null : _send,
          icon: _loading ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.send),
          label: const Text('Ask AetherOS'),
        ),
        const SizedBox(height: 16),
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Text(_answer))),
      ],
    );
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    const api = AetherOSApi();
    return FutureBuilder<List<PortfolioPosition>>(
      future: api.fetchPortfolio(),
      builder: (context, snapshot) {
        final positions = snapshot.data ?? const <PortfolioPosition>[];
        final totalValue = positions.fold<double>(0, (sum, item) => sum + item.marketValue);
        final totalPnl = positions.fold<double>(0, (sum, item) => sum + item.unrealizedPnl);

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(child: MetricCard(title: 'Value', value: '\$${totalValue.toStringAsFixed(2)}', subtitle: 'Marked portfolio', icon: Icons.account_balance_wallet)),
                const SizedBox(width: 12),
                Expanded(child: MetricCard(title: 'PnL', value: '\$${totalPnl.toStringAsFixed(2)}', subtitle: 'Unrealized', icon: Icons.trending_up)),
              ],
            ),
            const SizedBox(height: 16),
            Text('Portfolio tracking', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            for (final position in positions) _PortfolioTile(position: position),
          ],
        );
      },
    );
  }
}

class StrategyPage extends StatelessWidget {
  const StrategyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strategies = const AetherOSApi().fetchStrategies();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Strategy management', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        const Text('Enable, pause, and tune AI-assisted strategies from one Android dashboard.'),
        const SizedBox(height: 16),
        for (final strategy in strategies) Card(
          child: SwitchListTile(
            value: strategy.status != 'Paused',
            onChanged: (_) {},
            title: Text(strategy.name),
            subtitle: Text('${strategy.description}\nRisk: ${strategy.riskLevel} • Status: ${strategy.status}'),
          ),
        ),
      ],
    );
  }
}

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = const AetherOSApi().fetchAlerts();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Price and trade alerts', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        const Text('Use alerts to monitor targets, stops, and trade automation guardrails.'),
        const SizedBox(height: 16),
        for (final alert in alerts) Card(
          child: ListTile(
            leading: Icon(alert.enabled ? Icons.notifications_active : Icons.notifications_off),
            title: Text(alert.symbol),
            subtitle: Text('${alert.condition} \$${alert.targetPrice.toStringAsFixed(2)}'),
            trailing: Switch(value: alert.enabled, onChanged: (_) {}),
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AI Trading Operating System', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            const Text('Flutter Android client connected to FastAPI, AI agents, trading engine, and database services.'),
            const SizedBox(height: 16),
            FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.bolt), label: const Text('Open dashboard')),
          ],
        ),
      ),
    );
  }
}

class _MarketTile extends StatelessWidget {
  const _MarketTile({required this.ticker});

  final MarketTicker ticker;

  @override
  Widget build(BuildContext context) {
    final color = ticker.isPositive ? const Color(0xFF39D98A) : const Color(0xFFFF6B6B);
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(ticker.symbol.substring(0, 1))),
        title: Text(ticker.symbol),
        subtitle: Text('Volume ${ticker.volume.toStringAsFixed(0)}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('\$${ticker.price.toStringAsFixed(2)}'),
            Text('${ticker.changePercent.toStringAsFixed(2)}%', style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}

class _PortfolioTile extends StatelessWidget {
  const _PortfolioTile({required this.position});

  final PortfolioPosition position;

  @override
  Widget build(BuildContext context) {
    final pnlColor = position.unrealizedPnl >= 0 ? const Color(0xFF39D98A) : const Color(0xFFFF6B6B);
    return Card(
      child: ListTile(
        title: Text(position.symbol),
        subtitle: Text('${position.quantity} units • Entry \$${position.averageEntry.toStringAsFixed(2)}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('\$${position.marketValue.toStringAsFixed(2)}'),
            Text('\$${position.unrealizedPnl.toStringAsFixed(2)}', style: TextStyle(color: pnlColor)),
          ],
        ),
      ),
    );
  }
}
