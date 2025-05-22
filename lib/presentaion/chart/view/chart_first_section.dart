import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../global/theme/colors.dart';
import '../../../global/theme/textStyles.dart';

class SumStat {
  final String weekday;
  final DateTime day;
  final int totalIncome;
  final int totalExpense;

  SumStat({
    required this.weekday,
    required this.day,
    required this.totalIncome,
    required this.totalExpense,
  });
}

class ChartFirstSection extends StatelessWidget {
  final String selectedView;

  const ChartFirstSection({super.key, required this.selectedView});

  // 더미 데이터 (일간 기준)
  List<SumStat> get dailyData => [
    SumStat(weekday: '월', day: DateTime(2025, 5, 19), totalIncome: 1000, totalExpense: 800),
    SumStat(weekday: '화', day: DateTime(2025, 5, 20), totalIncome: 1200, totalExpense: 600),
    SumStat(weekday: '수', day: DateTime(2025, 5, 21), totalIncome: 800, totalExpense: 500),
    SumStat(weekday: '목', day: DateTime(2025, 5, 22), totalIncome: 900, totalExpense: 400),
    SumStat(weekday: '금', day: DateTime(2025, 5, 23), totalIncome: 700, totalExpense: 700),
    SumStat(weekday: '토', day: DateTime(2025, 5, 24), totalIncome: 1000, totalExpense: 900),
    SumStat(weekday: '일', day: DateTime(2025, 5, 25), totalIncome: 1100, totalExpense: 1000),
  ];
  List<SumStat> get weeklyData => [
    SumStat(weekday: '1주차', day: DateTime(2025, 5, 1), totalIncome: 6000, totalExpense: 4500),
    SumStat(weekday: '2주차', day: DateTime(2025, 5, 8), totalIncome: 7500, totalExpense: 5200),
    SumStat(weekday: '3주차', day: DateTime(2025, 5, 15), totalIncome: 7000, totalExpense: 6300),
    SumStat(weekday: '4주차', day: DateTime(2025, 5, 22), totalIncome: 8000, totalExpense: 5000),
  ];

  List<SumStat> get monthlyData => [
    SumStat(weekday: '1월', day: DateTime(2025, 1, 1), totalIncome: 25000, totalExpense: 22000),
    SumStat(weekday: '2월', day: DateTime(2025, 2, 1), totalIncome: 27000, totalExpense: 21000),
    SumStat(weekday: '3월', day: DateTime(2025, 3, 1), totalIncome: 26000, totalExpense: 23000),
    SumStat(weekday: '4월', day: DateTime(2025, 4, 1), totalIncome: 28000, totalExpense: 24000),
    SumStat(weekday: '5월', day: DateTime(2025, 5, 1), totalIncome: 30000, totalExpense: 25000),
  ];
  List<SumStat> get currentData {
    switch (selectedView) {
      case 'Daily':
        return dailyData;
      case 'Weekly':
        return weeklyData;
      case 'Monthly':
        return monthlyData;
      default:
        return dailyData;
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxY = (currentData
        .map((e) => [e.totalIncome.toDouble(), e.totalExpense.toDouble()].reduce((a, b) => a > b ? a : b))
        .reduce((a, b) => a > b ? a : b) *
        1.2)
        .ceilToDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Container(
        width: double.infinity,
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "수입/지출 한 눈에 보기",
                  style: customTextStyle(
                    fontFamily: Pretendard_Semibold_16,
                    color: Colors.black,
                  ),
                ),
                const Icon(Icons.calendar_today, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxY,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          if (value % 5000 == 0) {
                            return Text('${value ~/ 1000}k',
                                style: const TextStyle(fontSize: 10));
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() < currentData.length) {
                            return Text(
                              currentData[value.toInt()].weekday,
                              style: const TextStyle(fontSize: 12),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: true, horizontalInterval: 5000),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(currentData.length, (index) {
                    final data = currentData[index];
                    return BarChartGroupData(
                      x: index,
                      barsSpace: 4,
                      barRods: [
                        BarChartRodData(toY: data.totalIncome.toDouble(), width: 8, color: primary_400),
                        BarChartRodData(toY: data.totalExpense.toDouble(), width: 8, color: secondary_200),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}