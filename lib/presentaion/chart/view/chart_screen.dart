import 'package:flutter/material.dart';

import '../../../global/theme/colors.dart';
import '../../../global/theme/textStyles.dart';
import '../../myPage/view/hint_screen.dart';
import '../model/chartmodel.dart';
import 'chart_first_section.dart';
import 'chart_fourth_section.dart';
import 'chart_second_section.dart';
import 'chart_third_section.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  String selectedView = 'Daily';

  void changeView(String view) {
    setState(() {
      selectedView = view;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral_900,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 52,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 28),
                    Text(
                      "분석",
                      style: customTextStyle(
                        fontFamily: Pretendard_Bold_28,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HintScreen()),
                        );
                      },
                      icon: Image.asset('assets/images/icons/bell_01.png'),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HintScreen()),
                        );
                      },
                      icon: Image.asset('assets/images/icons/help_circle.png'),
                    ),
                    const SizedBox(width: 28),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var viewType in ['Daily', 'Weekly', 'Monthly'])
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ElevatedButton(
                            onPressed: () => changeView(viewType),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedView == viewType
                                  ? primary_400
                                  : neutral_900,
                              foregroundColor: selectedView == viewType
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
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 👉 selectedView 전달
              ChartFirstSection(selectedView: selectedView),

              const SizedBox(height: 20),

              ChartSecondSection(selectedView: selectedView),

              const SizedBox(height: 20),

              ChartThirdSection(selectedView: selectedView),

              const SizedBox(height: 20),

              ChartFourthSection(selectedView: selectedView),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}