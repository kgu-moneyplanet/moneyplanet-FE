import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';

class ChartThirdSection extends StatelessWidget {
  final String selectedView;

  const ChartThirdSection({super.key, required this.selectedView});

  @override
  Widget build(BuildContext context) {
    final categories = _getCategoriesByView(selectedView);

    final total = categories.fold<double>(0, (sum, item) => sum + (item['value'] as double));
    categories.sort((a, b) => (b['value'] as double).compareTo(a['value'] as double));
    final top = categories.isNotEmpty ? categories.first : null;
    final topLabel = top != null ? top['label'] as String : '';
    final topPercent = (top != null && total != 0) ? (top['value'] as double) / total * 100 : 0;

    List<PieChartSectionData> _buildSections() {
      return categories.map((c) {
        final value = c['value'] as double;
        final percent = total == 0 ? 0 : value / total * 100;
        return PieChartSectionData(
          color: c['color'] as Color,
          value: percent.toDouble(),
          title: '',
          radius: c == top ? 70 : 60,
        );
      }).toList();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
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
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                      ),
                      child: Column(
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
                children: categories.map((c) {
                  final value = c['value'] as double;
                  final percent = total == 0 ? 0 : value / total * 100;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: c['color'] as Color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${c['label']} (${percent.toStringAsFixed(1)}%)',
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

  List<Map<String, Object>> _getCategoriesByView(String view) {
    switch (view) {
      case 'Weekly':
        return [
          {'label': '식비', 'value': 10000.0, 'color': primary_400},
          {'label': '교통/차량', 'value': 800.0, 'color': primary_300},
          {'label': '문화생활', 'value': 600.0, 'color': primary_200},
          {'label': '마트/편의점', 'value': 900.0, 'color': primary_100},
          {'label': '패션/미용', 'value': 700.0, 'color': primary_050},
          {'label': '생활용품', 'value': 400.0, 'color': secondary_200},
          {'label': '주거/통신', 'value': 1100.0, 'color': secondary_200},
          {'label': '건강', 'value': 300.0, 'color': secondary_300},
          {'label': '교육', 'value': 500.0, 'color': secondary_100_2},
          {'label': '경조사/회비', 'value': 200.0, 'color': neutral_300},
          {'label': '부모님', 'value': 600.0, 'color': neutral_400},
          {'label': '저축성 지출', 'value': 1000.0, 'color': neutral_500},
          {'label': '세금', 'value': 550.0, 'color': neutral_600},
          {'label': '반려동물', 'value': 250.0, 'color': neutral_700},
          {'label': '기타', 'value': 350.0, 'color': neutral_800},
        ];
      case 'Monthly':
        return [
          {'label': '식비', 'value': 100000.0, 'color': primary_400},
          {'label': '교통/차량', 'value': 80000.0, 'color': primary_300},
          {'label': '문화생활', 'value': 60000.0, 'color': primary_200},
          {'label': '마트/편의점', 'value': 90000.0, 'color': primary_100},
          {'label': '패션/미용', 'value': 70000.0, 'color': primary_050},
          {'label': '생활용품', 'value': 40000.0, 'color': secondary_200},
          {'label': '주거/통신', 'value': 110000.0, 'color': secondary_200},
          {'label': '건강', 'value': 30000.0, 'color': secondary_300},
          {'label': '교육', 'value': 50000.0, 'color': secondary_100_2},
          {'label': '경조사/회비', 'value': 21110.0, 'color': neutral_300},
          {'label': '부모님', 'value': 61110.0, 'color': neutral_400},
          {'label': '저축성 지출', 'value': 101110.0, 'color': neutral_500},
          {'label': '세금', 'value': 551110.0, 'color': neutral_600},
          {'label': '반려동물', 'value': 252222.0, 'color': neutral_700},
          {'label': '기타', 'value': 353333.0, 'color': neutral_800},
        ];
      case 'Daily':
      default:
        return [
          {'label': '식비', 'value': 1000.0, 'color': primary_400},
          {'label': '교통/차량', 'value': 80.0, 'color': primary_300},
          {'label': '문화생활', 'value': 60.0, 'color': primary_200},
          {'label': '마트/편의점', 'value': 90.0, 'color': primary_100},
          {'label': '패션/미용', 'value': 70.0, 'color': primary_050},
          {'label': '생활용품', 'value': 40.0, 'color': secondary_200},
          {'label': '주거/통신', 'value': 110.0, 'color': secondary_200},
          {'label': '건강', 'value': 30.0, 'color': secondary_300},
          {'label': '교육', 'value': 50.0, 'color': secondary_100_2},
          {'label': '경조사/회비', 'value': 20.0, 'color': neutral_300},
          {'label': '부모님', 'value': 60.0, 'color': neutral_400},
          {'label': '저축성 지출', 'value': 100.0, 'color': neutral_500},
          {'label': '세금', 'value': 55.0, 'color': neutral_600},
          {'label': '반려동물', 'value': 25.0, 'color': neutral_700},
          {'label': '기타', 'value': 35.0, 'color': neutral_800},
        ];
    }
  }
}
