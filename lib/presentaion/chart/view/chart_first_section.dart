import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import 'package:money_planet/presentaion/myPage/view/hint_screen.dart';

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
              height: 147,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Row(

              ),
            ),
          ),
        ],
    );
  }
}
