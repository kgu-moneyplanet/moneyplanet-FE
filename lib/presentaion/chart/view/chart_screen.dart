import 'package:flutter/material.dart';

import '../../../global/theme/colors.dart';
import 'chart_first_section.dart';
import 'chart_second_section.dart';
import 'chart_first_section.dart';

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

                  SizedBox(height: 10),

                  ChartSecondSection(),

                  SizedBox(height: 10),

                  //ChartThirdSection(),

                ],
              ),
            ),
          )
      ),
    );
  }
}