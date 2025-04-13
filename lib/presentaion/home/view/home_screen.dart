import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '홈 화면',
        style: customTextStyle(fontFamily: Pretendard_Medium_12, color: primary_050),
      ),
    );
  }
}
