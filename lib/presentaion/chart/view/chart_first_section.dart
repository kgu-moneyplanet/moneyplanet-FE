import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import 'package:money_planet/presentaion/myPage/view/hint_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../onboarding/view/question_screen.dart';

class ChartFirstSection extends StatefulWidget {
  const ChartFirstSection({super.key});

  @override
  State<ChartFirstSection> createState() => ChartFirstSectionState();
}

class ChartFirstSectionState extends State<ChartFirstSection> {
  String selectedView = 'Daily';

  void changeView(String view) {
    setState(() {
      selectedView = view;
    });
  }
  final List<Map<String, double>> weeklyData = [
    {'income': 6000, 'expense': 10000},
    {'income': 2000, 'expense': 5000},
    {'income': 4000, 'expense': 8000},
    {'income': 1000, 'expense': 3000},
    {'income': 9000, 'expense': 12000},
    {'income': 3000, 'expense': 2000},
    {'income': 7000, 'expense': 6000},
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          // 앱 이름 및 도움말, 알림 아이콘 부분
          SizedBox(
            height: 52,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 28),
                Text(
                  "분석",
                  style: customTextStyle(
                    fontFamily: Pretendard_Bold_28,
                    color: Colors.white,
                  ),
                ),

                Spacer(),

                IconButton(
                  onPressed: () {
                    print("tapped bell");
                  },
                  icon: Image.asset('assets/images/icons/bell_01.png'),
                ),

                IconButton(
                  onPressed: () {
                    print("tapped help");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HintScreen()),
                    );
                  },
                  icon: Image.asset(
                    'assets/images/icons/help_circle.png',
                  ),
                ),

                SizedBox(width: 28),
              ],
            ),
          ),

          SizedBox(height: 30),


          //
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var viewType in ['Daily', 'Weekly', 'Monthly', 'Year'])
                    ElevatedButton(
                      onPressed: () => changeView(viewType),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        selectedView == viewType
                            ? primary_400
                            : neutral_900,
                        foregroundColor:
                        selectedView == viewType
                            ? Colors.white
                            : primary_400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: const BorderSide(color: primary_400),
                        ),
              
                      ),
                      child: Text(
                        viewType,
                        style: customTextStyle(
                          fontFamily: Pretendard_Semibold_18,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 23),
            child: Container(
              width: 393,
              height: 200,
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
                      Icon(Icons.calendar_today, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 16000,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                if (value % 5000 == 0) {
                                  return Text('${value ~/ 1000}k', style: TextStyle(fontSize: 10));
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const days = ['월', '화', '수', '목', '금', '토', '일'];
                                return Text(days[value.toInt()], style: TextStyle(fontSize: 12));
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        gridData: FlGridData(show: true, horizontalInterval: 5000),
                        borderData: FlBorderData(show: false),
                        barGroups: List.generate(7, (index) {
                          final income = weeklyData[index]['income']!;
                          final expense = weeklyData[index]['expense']!;
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(toY: income, width: 8, color: primary_400),
                              BarChartRodData(toY: expense, width: 8, color: secondary_200),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
    );
  }
}
