import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import 'package:money_planet/presentaion/myPage/view/hint_screen.dart';

import '../../onboarding/view/question_screen.dart';

class ChartSecondSection extends StatelessWidget {
  const ChartSecondSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Container(
        width: 393,
        height: 147,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // 이번주 수입
            _buildInfoBlock(
              imagePath: 'assets/images/icons/arrow_square_upright.png',
              label: '이번주 수입',
              amount: '500,000원',
              labelColor: neutral_400,
              amountColor: Colors.black,
            ),

            Container(
              width: 1,
              height: 48,
              color: neutral_200,
            ),

            // 이번주 지출
            _buildInfoBlock(
              imagePath: 'assets/images/icons/arrow_square_downright.png',
              label: '이번주 지출',
              amount: '500,000원',
              labelColor: neutral_400,
              amountColor: secondary_200,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBlock({
    required String imagePath,
    required String label,
    required String amount,
    required Color labelColor,
    required Color amountColor,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon 대신 Image.asset 사용
          Image.asset(
            imagePath,
            width: 25.5,
            height: 25.5,
          ),
          const SizedBox(height: 9),
          Text(
            label,
            style: customTextStyle(
              fontFamily: Pretendard_Semibold_14,
              color: labelColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            amount,
            style: customTextStyle(
              fontFamily: Pretendard_Semibold_18,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}