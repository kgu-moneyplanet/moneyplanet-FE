import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';

class ChartFourthSection extends StatelessWidget {
  final String selectedView;

  const ChartFourthSection({super.key, required this.selectedView});

  @override
  Widget build(BuildContext context) {
    final sections = _getSectionsByView(selectedView);

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
                textAlign: TextAlign.left,
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
                        boxShadow: [
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
                            topLabel.split(' - ').first, // A, B, C
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

  List<Map<String, Object?>> _getSectionsByView(String view) {
    switch (view) {
      case 'Weekly':
        return [
          {'label': 'A - 필수 소비', 'value': 4000.0, 'color': primary_400},
          {'label': 'B - 선택적 소비', 'value': 3100.0, 'color': primary_050},
          {'label': 'C - 불필요 소비', 'value': 1020.0, 'color': secondary_200},
        ];
      case 'Monthly':
        return [
          {'label': 'A - 필수 소비', 'value': 18000.0, 'color': primary_400},
          {'label': 'B - 선택적 소비', 'value': 1600.0, 'color': primary_050},
          {'label': 'C - 불필요 소비', 'value': 1200.0, 'color': secondary_200},
        ];
      case 'Daily':
      default:
        return [
          {'label': 'A - 필수 소비', 'value': 20.0, 'color': primary_400},
          {'label': 'B - 선택적 소비', 'value': 150.0, 'color': primary_050},
          {'label': 'C - 불필요 소비', 'value': 50.0, 'color': secondary_200},
        ];
    }
  }
}
