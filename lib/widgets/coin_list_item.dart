import 'package:coinmerce/models/coin_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CoinListItem extends StatelessWidget {
  final CoinModel coin;

  const CoinListItem({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final isPositiveChange = coin.dailyPriceChange >= 0;
    final priceChangeColor = isPositiveChange ? Colors.green : Colors.red;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(coin.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coin.name,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        coin.symbol.toUpperCase(),
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      coin.currentPrice.toPriceString(),
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: priceChangeColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '24h',
                                style: textTheme.bodySmall?.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                coin.dailyPriceChange.toPercentageString(),
                                style: textTheme.bodyMedium?.copyWith(
                                  color: priceChangeColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 60,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: coin.sparklinePrices.asMap().entries.map((e) {
                        return FlSpot(
                          e.key.toDouble(),
                          double.parse(e.value.toStringAsFixed(5)),
                        );
                      }).toList(),
                      isCurved: true,
                      color: priceChangeColor,
                      barWidth: 1.5,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: priceChangeColor.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Last 7 days',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension DoubleExtension on double {
  String toPercentageString() {
    final sign = this >= 0 ? '+' : '';
    return '$sign${toStringAsFixed(2)}%';
  }

  String toPriceString() {
    return '\$${toStringAsFixed(2)}';
  }
}
