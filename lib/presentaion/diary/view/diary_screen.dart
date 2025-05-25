import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_planet/presentaion/diary/viewModel/diary_viewModel.dart';
import 'package:money_planet/presentaion/home/view/home_third_section.dart';

import '../../../global/components/floating_dial_button.dart';
import '../../../global/theme/colors.dart';
import '../../../global/theme/textStyles.dart';
import '../../home/viewModel/home_viewModel.dart';
import '../../myPage/view/hint_screen.dart';
import 'empty_diary_screen.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final DiaryViewModel viewModel = DiaryViewModel();
  final HomeViewModel homeViewModel = HomeViewModel();
  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  void _refreshData() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral_900,
      floatingActionButton: floatingDialButton(context, _refreshData),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 헤더부분
              SizedBox(
                height: 52,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 28),
                    Text(
                      "가계부",
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
                          MaterialPageRoute(
                            builder: (context) => const HintScreen(),
                          ),
                        );
                      },
                      icon: Image.asset('assets/images/icons/help_circle.png'),
                    ),

                    SizedBox(width: 28),
                  ],
                ),
              ),

              SizedBox(height: 29),

              // 가계부
              HomeThirdSection(viewModel: homeViewModel),

              Image.asset(
                "assets/images/splash_image.png",
                width: 300,
                height: 300,
                fit: BoxFit.fill,

              ),
            ],
          ),
        ),
      ),
    );
  }
}
