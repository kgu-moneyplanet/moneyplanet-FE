import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import 'package:money_planet/presentaion/myPage/view/hint_screen.dart';

import '../../onboarding/view/question_screen.dart';

class ChartSecondSection extends StatelessWidget {
  final String selectedView;

  const ChartSecondSection({super.key, required this.selectedView});

  @override
  Widget build(BuildContext context) {
    // selectedView 값에 따라 텍스트(레이블)와 금액(amount)을 바꾸는 예시
    String incomeLabel;
    String expenseLabel;
    String incomeAmount;
    String expenseAmount;

    switch (selectedView) {
      case 'Weekly':
        incomeLabel = '이번주 수입';
        expenseLabel = '이번주 지출';
        incomeAmount = '500,000원';
        expenseAmount = '300,000원';
        break;
      case 'Monthly':
        incomeLabel = '이번달 수입';
        expenseLabel = '이번달 지출';
        incomeAmount = '2,000,000원';
        expenseAmount = '1,200,000원';
        break;
      case 'Daily':
      default:
        incomeLabel = '오늘 수입';
        expenseLabel = '오늘 지출';
        incomeAmount = '50,000원';
        expenseAmount = '30,000원';
        break;
    }

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
            _buildInfoBlock(
              imagePath: 'assets/images/icons/arrow_square_upright.png',
              label: incomeLabel,
              amount: incomeAmount,
              labelColor: neutral_400,
              amountColor: Colors.black,
            ),
            Container(
              width: 1,
              height: 48,
              color: neutral_200,
            ),
            _buildInfoBlock(
              imagePath: 'assets/images/icons/arrow_square_downright.png',
              label: expenseLabel,
              amount: expenseAmount,
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