import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/textStyles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '홈 화면',
        style: Pretendard_Bold_18,
      ),
    );
  }
}
