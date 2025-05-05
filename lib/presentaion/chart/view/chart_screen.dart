import 'package:flutter/material.dart';

import '../../../global/theme/colors.dart';
import 'chart_first_section.dart';
import 'chart_fourth_section.dart';
import 'chart_second_section.dart';
import 'chart_first_section.dart';
import 'chart_third_section.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: neutral_900,
          body: SafeArea(
            child:SingleChildScrollView(
              child: Column(
                children: [
                  ChartFirstSection(),

                  SizedBox(height: 20),

                  ChartSecondSection(),

                  SizedBox(height: 20),

                  ChartThirdSection(),

                  SizedBox(height: 20),

                  ChartFourthSection(),
                  SizedBox(height: 60),
                ],
              ),
            ),
          )
      ),
    );
  }
}