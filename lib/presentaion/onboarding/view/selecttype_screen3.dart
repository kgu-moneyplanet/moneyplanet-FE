import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../global/theme/colors.dart';
import '../../../global/theme/textStyles.dart';

class SelectTypeScreen3 extends StatelessWidget {
  final PageController controller;
  const SelectTypeScreen3({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary_050,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SizedBox(height: 16),
            SizedBox(
              width: 343,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  controller.animateToPage(
                    4,
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
                child: Text(
                  '다음',
                  style: customTextStyle(
                    fontFamily: Pretendard_Medium_18,
                    color: Colors.white,
                  ),
                ),
              ),
            ), // 다음
          ],
        ),
      ),
    );
  }
}
