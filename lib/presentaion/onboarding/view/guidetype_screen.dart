import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/presentaion/onboarding/view/selecttype_screen1.dart';

import '../../../application/tabBar/view/tab_screen.dart';
import '../../../global/theme/textStyles.dart';

class GuideTypeScreen extends StatelessWidget {
  final PageController controller;
  const GuideTypeScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral_900,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(),
                child: Image.asset(
                  'lib/global/assets/images/login_planet.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 40),

              Center(
                child: Text(
                  '지향하는 소비유형을\n선택해주세요!',
                  textAlign: TextAlign.center,
                  style: customTextStyle(
                    fontFamily: Pretendard_Bold_28,
                    color: secondary_050_1,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  '유형에 따라 나만의 행성이 형성됩니다',
                  textAlign: TextAlign.center,
                  style: customTextStyle(
                    fontFamily: Pretendard_Medium_20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: 343,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    controller.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary_400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '선택하기',
                      style: customTextStyle(fontFamily: Pretendard_Medium_18,color: Colors.white),
                    ),
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
