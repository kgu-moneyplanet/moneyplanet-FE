import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';

import '../viewModel/DailyAnalysisCategoyViewModel.dart';
import '../viewModel/MonthlyAnalysisCategoryViewModel.dart';
import '../viewModel/WeeklyAnalysisCategoryViewModel.dart';

class ChartThirdSection extends StatefulWidget {
  final String selectedView;
  final String jwtToken;

  const ChartThirdSection({
    super.key,
    required this.selectedView,
    required this.jwtToken,
  });

  @override
  State<ChartThirdSection> createState() => _ChartThirdSectionState();
}

class _ChartThirdSectionState extends State<ChartThirdSection> {
  final DailyAnalysisCategoryViewModel dailyCategoryViewModel =
      DailyAnalysisCategoryViewModel();
  final WeeklyAnalysisCategoryViewModel weeklyCategoryViewModel =
      WeeklyAnalysisCategoryViewModel();
  final MonthlyAnalysisCategoryViewModel monthlyCategoryViewModel =
      MonthlyAnalysisCategoryViewModel();

  @override
  void initState() {
    super.initState();
    _fetchDataIfNeeded();
    dailyCategoryViewModel.addListener(_onViewModelChanged);
    weeklyCategoryViewModel.addListener(_onViewModelChanged);
    monthlyCategoryViewModel.addListener(_onViewModelChanged);
  }

  @override
  void didUpdateWidget(covariant ChartThirdSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedView != oldWidget.selectedView ||
        widget.jwtToken != oldWidget.jwtToken) {
      _fetchDataIfNeeded();
    }
  }

  void _fetchDataIfNeeded() {
    final now = DateTime.now();

    if (widget.selectedView == 'Daily') {
      final now = DateTime.now(); // DateTime 타입
      print(
        'Fetching Daily Category for date: ${now.toIso8601String().substring(0, 10)}',
      );
      dailyCategoryViewModel.fetchDailyCategory(now, widget.jwtToken).then((_) {
        print(
          'Daily fetch complete. Data: ${dailyCategoryViewModel.dailyCategoryData}',
        );
        print('Error: ${dailyCategoryViewModel.errorMessage}');
      });
    } else if (widget.selectedView == 'Weekly') {
      final weekNum = _getWeekNumber(now);
      print('Fetching Weekly Category for year: ${now.year}, week: $weekNum');
      weeklyCategoryViewModel
          .fetchWeeklyCategory(now.year, weekNum, widget.jwtToken)
          .then((_) {
            print(
              'Weekly fetch complete. Data: ${weeklyCategoryViewModel.weeklyCategoryData}',
            );
            print('Error: ${weeklyCategoryViewModel.errorMessage}');
          });
    } else if (widget.selectedView == 'Monthly') {
      print(
        'Fetching Monthly Category for year: ${now.year}, month: ${now.month}',
      );
      monthlyCategoryViewModel
          .fetchMonthlyCategory(now.year, now.month, widget.jwtToken)
          .then((_) {
            print(
              'Monthly fetch complete. Data: ${monthlyCategoryViewModel.monthlyCategoryData}',
            );
            print('Error: ${monthlyCategoryViewModel.errorMessage}');
          });
    }
  }

  int _getWeekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysPassed = date.difference(firstDayOfYear).inDays;
    return ((daysPassed + firstDayOfYear.weekday) / 7).ceil();
  }

  void _onViewModelChanged() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    dailyCategoryViewModel.removeListener(_onViewModelChanged);
    weeklyCategoryViewModel.removeListener(_onViewModelChanged);
    monthlyCategoryViewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = _getCategoriesByView();

    final total = categories.fold<double>(
      0,
      (sum, item) => sum + (item['value'] as double),
    );
    categories.sort(
      (a, b) => (b['value'] as double).compareTo(a['value'] as double),
    );
    final top = categories.isNotEmpty ? categories.first : null;
    final topLabel = top != null ? top['label'] as String : '';
    final topPercent =
        (top != null && total != 0)
            ? (top['value'] as double) / total * 100
            : 0;

    List<PieChartSectionData> _buildSections() {
      return categories.map((s) {
        final percent =
            total == 0
                ? 0.0
                : ((s['value'] as double) / total * 100).toDouble();
        return PieChartSectionData(
          color: s['color'] as Color,
          value: percent,
          title: '',
          radius: s == top ? 70 : 60,
        );
      }).toList();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '카테고리별 지출',
                style: customTextStyle(
                  fontFamily: Pretendard_Semibold_18,
                  color: neutral_1100,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1.2,
                  child: PieChart(
                    PieChartData(
                      sections: _buildSections(),
                      centerSpaceRadius: 50,
                      sectionsSpace: 4,
                      startDegreeOffset: -90,
                    ),
                  ),
                ),
                if (top != null)
                  Positioned(
                    right: 40,
                    bottom: 40,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            topLabel,
                            style: customTextStyle(
                              fontFamily: Pretendard_Medium_12,
                              color: neutral_1100,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${topPercent.toStringAsFixed(1)}%',
                            style: customTextStyle(
                              fontFamily: Pretendard_Semibold_16,
                              color: primary_400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children:
                    categories.map((s) {
                      final value = s['value'] as double;
                      final percent = total == 0 ? 0 : value / total * 100;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: s['color'] as Color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${s['label']} (${percent.toStringAsFixed(1)}%)',
                                style: customTextStyle(
                                  fontFamily: Pretendard_Medium_16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              '${value.toStringAsFixed(0)}원',
                              style: customTextStyle(
                                fontFamily: Pretendard_Medium_16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  List<Map<String, Object?>> _getCategoriesByView() {
    List categories;
    if (widget.selectedView == 'Daily' &&
        dailyCategoryViewModel.dailyCategoryData != null) {
      categories =
          dailyCategoryViewModel.dailyCategoryData!.categoryStatDtoList;
    } else if (widget.selectedView == 'Weekly' &&
        weeklyCategoryViewModel.weeklyCategoryData != null) {
      categories =
          weeklyCategoryViewModel.weeklyCategoryData!.categoryStatDtoList;
    } else if (widget.selectedView == 'Monthly' &&
        monthlyCategoryViewModel.monthlyCategoryData != null) {
      categories =
          monthlyCategoryViewModel.monthlyCategoryData!.categoryStatDtoList;
    } else {
      return [
        {'label': '식비', 'value': 30000.0, 'color': primary_400},
        {'label': '교통', 'value': 20000.0, 'color': secondary_200},
        {'label': '문화', 'value': 10000.0, 'color': primary_050},
      ];
    }

    // 월급 카테고리 제외 (categoryId가 16인 항목 제외)
    final filtered =
        categories.where((category) => category.categoryId != 16).toList();

    return filtered.map((category) {
      return {
        'label': category.categoryName,
        'value': category.amount.toDouble(),
        'color': _getCategoryColor(category.categoryId),
      };
    }).toList();
  }

  Color _getCategoryColor(int categoryId) {
    switch (categoryId) {
      case 0:
        return primary_100;
      case 1:
        return secondary_200;
      case 2:
        return primary_050;
      case 3:
        return secondary_300;
      case 4:
        return neutral_200;
      case 5:
        return primary_400;
      case 6:
        return neutral_600;
      case 7:
        return Colors.amberAccent;
      case 8:
        return Color(0xFFCDDC39);
      case 9:
        return Color(0xFF795548);
      case 10:
        return Colors.deepOrangeAccent;
      case 11:
        return Colors.teal;
      case 12:
        return Colors.blueGrey;
      case 13:
        return Colors.deepPurpleAccent;
      case 14:
        return Colors.cyanAccent;
      default:
        return neutral_400;
    }
  }
}
