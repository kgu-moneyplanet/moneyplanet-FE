import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/presentaion/register/view/selecttype_screen.dart';

import '../../../global/theme/textStyles.dart';

class GuideTypeScreen extends StatelessWidget {
  const GuideTypeScreen({super.key});

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
                  'lib/global/assets/images/planet.png',
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectTypeScreen1(),
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
