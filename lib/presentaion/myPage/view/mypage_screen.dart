import 'package:flutter/material.dart';
import 'package:money_planet/presentaion/myPage/view/mypage_first_section.dart';

import '../../../global/theme/colors.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: neutral_900,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MypageFirstSection(),

                SizedBox(height: 40),


                SizedBox(height: 40),


                SizedBox(height: 50),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
