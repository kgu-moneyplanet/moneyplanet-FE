import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';

import '../../../network/Chart/Response/MonthlyAnalysisResponseDTO.dart';
import '../../../network/Chart/Response/WeeklyAnalysisResponseDTO.dart';
import '../viewModel/DailyAnalysisViewModel.dart';
import '../viewModel/MonthlyAnalysisViewModel.dart';
import '../viewModel/WeeklyAnalysisViewModel.dart';

class ChartFourthSection extends StatefulWidget {
  final String selectedView; // 'Daily', 'Weekly', 'Monthly'
  final String jwtToken;

  const ChartFourthSection({
    super.key,
    required this.selectedView,
    required this.jwtToken,
  });

  @override
  State<ChartFourthSection> createState() => _ChartFourthSectionState();
}

class _ChartFourthSectionState extends State<ChartFourthSection> {
  final WeeklyAnalysisViewModel weeklyViewModel = WeeklyAnalysisViewModel();
  final MonthlyAnalysisViewModel monthlyViewModel = MonthlyAnalysisViewModel();

  @override
  void initState() {
    super.initState();
    _fetchDataIfNeeded();
    weeklyViewModel.addListener(_onViewModelChanged);
    monthlyViewModel.addListener(_onViewModelChanged);
  }

  @override
  void didUpdateWidget(covariant ChartFourthSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedView != oldWidget.selectedView || widget.jwtToken != oldWidget.jwtToken) {
      _fetchDataIfNeeded();
    }
  }

  void _fetchDataIfNeeded() {
    final now = DateTime.now();

    if (widget.selectedView == 'Weekly') {
      final weekOfYear = _getWeekNumber(now);
      weeklyViewModel.fetchWeeklyAnalysis(now.year, weekOfYear, widget.jwtToken);
    } else if (widget.selectedView == 'Monthly') {
      monthlyViewModel.fetchMonthlyAnalysis(now.year, now.month, widget.jwtToken);
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
    print('월간 abcStat: A=${monthlyViewModel.monthlyData?.abcStat.totalA}, '
        'B=${monthlyViewModel.monthlyData?.abcStat.totalB}, '
        'C=${monthlyViewModel.monthlyData?.abcStat.totalC}');
  }

  @override
  void dispose() {
    weeklyViewModel.removeListener(_onViewModelChanged);
    monthlyViewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final weeklyAbc = widget.selectedView == 'Weekly' ? weeklyViewModel.weeklyData?.abcStat : null;
    final monthlyAbc = widget.selectedView == 'Monthly' ? monthlyViewModel.monthlyData?.abcStat : null;

    final sections = _getSectionsByView(widget.selectedView, weeklyAbc, monthlyAbc);

    final total = sections.fold<double>(0, (sum, s) => sum + (s['value']! as double));
    sections.sort((a, b) => (b['value']! as double).compareTo(a['value']! as double));
    final topSection = sections.isNotEmpty ? sections.first : null;
    final topLabel = topSection != null ? topSection['label'] as String : '';
    final topPercent = (topSection != null && total != 0)
        ? (topSection['value']! as double) / total * 100
        : 0;

    List<PieChartSectionData> _buildSections() {
      return sections.map((s) {
        final percent = total == 0 ? 0 : (s['value']! as double) / total * 100;
        return PieChartSectionData(
          color: s['color'] as Color,
          value: percent.toDouble(),
          title: '',
          radius: s == topSection ? 70 : 60,
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
                '소비 타입별 지출',
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
                if (topSection != null)
                  Positioned(
                    right: 40,
                    bottom: 40,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                            topLabel.split(' - ').first,
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
                children: sections.map((s) {
                  final value = s['value']! as double;
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

  List<Map<String, Object?>> _getSectionsByView(
      String view, AbcStat? weekly, MonthlyAbcStat? monthly) {
    if (view == 'Weekly' && weekly != null) {
      return _mapToChartSections({
        'A': weekly.totalA.toDouble(),
        'B': weekly.totalB.toDouble(),
        'C': weekly.totalC.toDouble(),
      });
    } else if (view == 'Monthly' && monthly != null) {
      return _mapToChartSections({
        'A': monthly.totalA.toDouble(),
        'B': monthly.totalB.toDouble(),
        'C': monthly.totalC.toDouble(),
      });
    } else {
      return _mapToChartSections({
        'A': 40.0,
        'B': 35.0,
        'C': 25.0,
      });
    }
  }

  List<Map<String, Object?>> _mapToChartSections(Map<String, double> abc) {
    return [
      {
        'label': 'A - 필수 소비',
        'value': abc['A'] ?? 0,
        'color': primary_400,
      },
      {
        'label': 'B - 선택적 소비',
        'value': abc['B'] ?? 0,
        'color': primary_050,
      },
      {
        'label': 'C - 불필요 소비',
        'value': abc['C'] ?? 0,
        'color': secondary_200,
      },
    ];
  }
}


