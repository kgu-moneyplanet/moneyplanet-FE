import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../global/theme/colors.dart';
import '../../../global/theme/textStyles.dart';
import '../viewModel/DailyAnalysisViewModel.dart';

class ChartFirstSection extends StatefulWidget {
  const ChartFirstSection({super.key, required this.jwtToken, required String selectedView});
  final String jwtToken;

  @override
  State<ChartFirstSection> createState() => _ChartFirstSectionState();
}

class _ChartFirstSectionState extends State<ChartFirstSection> {
  final DailyAnalysisViewModel viewModel = DailyAnalysisViewModel();

  @override
  void initState() {
    super.initState();
    final statDate = DateTime.now().toIso8601String().substring(0, 10);
    viewModel.addListener(_onViewModelChanged);
    viewModel.fetchDailyData(statDate);
  }

  void _onViewModelChanged() {
    if (mounted) {
      print('dailyData updated: ${viewModel.dailyData}');
      print('isLoading: ${viewModel.isLoading}, error: ${viewModel.error}');
      setState(() {});
    }
  }

  @override
  void dispose() {
    viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }
  String weekdayToKorean(int weekday) {
    switch (weekday) {
      case 1:
        return '월';
      case 2:
        return '화';
      case 3:
        return '수';
      case 4:
        return '목';
      case 5:
        return '금';
      case 6:
        return '토';
      case 7:
        return '일';
      default:
        return '';
    }
  }
  @override
  Widget build(BuildContext context) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (viewModel.error != null) {
      return Center(child: Text(viewModel.error!));
    }
    final dailyData = viewModel.dailyData;
    if (dailyData == null || dailyData.isEmpty) {
      return const Center(child: Text('데이터가 없습니다.'));
    }

    final maxY = (dailyData
        .map((e) => [
      e.totalIncome.toDouble(),
      e.totalExpense.toDouble()
    ].reduce((a, b) => a > b ? a : b))
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
                  "이번주 수입/지출 한 눈에 보기\n",
                  style: customTextStyle(
                    fontFamily: Pretendard_Semibold_16,
                    color: Colors.black,
                  ),
                ),
                const Icon(Icons.calendar_today, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 160,
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
                            return Text('${value ~/ 10000} 만원',
                                style: customTextStyle(fontFamily: Pretendard_Medium_10,color: Colors.black));
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() < dailyData.length) {
                            final data = dailyData[value.toInt()];
                            final weekday = data.weekday;
                            final formattedDate = DateFormat('MM/dd').format(data.day);
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(weekday, style: customTextStyle(fontFamily: Pretendard_Medium_12,color: Colors.black)),
                                Text(formattedDate, style: const TextStyle(fontSize: 10)),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      if (value % 10000 == 0 || value == 0) {
                        return FlLine(
                          color: primary_400,
                          strokeWidth: 1,
                          dashArray: [4, 4],
                        );
                      }
                      return FlLine(color: Colors.transparent);
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(dailyData.length, (index) {
                    final data = dailyData[index];
                    return BarChartGroupData(
                      x: index,
                      barsSpace: 4,
                      barRods: [
                        BarChartRodData(
                            toY: data.totalIncome.toDouble(),
                            width: 8,
                            color: primary_400),
                        BarChartRodData(
                            toY: data.totalExpense.toDouble(),
                            width: 8,
                            color: secondary_200),
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