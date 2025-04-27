import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/presentaion/onboarding/view/signup_screen.dart';

import '../../../global/theme/textStyles.dart';

class GuideProfileScreen extends StatelessWidget {
  const GuideProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonColor = const Color(0xFF849BEB); // 하늘 버튼
    final backgroundColor = const Color(0xFF202029);
    return Scaffold(
      backgroundColor: backgroundColor,
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
                  'assets/images/rocket3.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 40),

              Center(
                child: Text(
                  '만나서 반가워요!',
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
                  '시작 전에 간단한\n프로필을 작성해주세요',
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '작성하기',
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
