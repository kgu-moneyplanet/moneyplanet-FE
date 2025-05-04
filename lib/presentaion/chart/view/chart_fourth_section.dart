import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import 'package:money_planet/presentaion/myPage/view/hint_screen.dart';

import '../../onboarding/view/question_screen.dart';

class ChartFourthSection extends StatelessWidget {
  const ChartFourthSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Container(
        width: 393,
        height: 507,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),

      ),
    );
  }

}