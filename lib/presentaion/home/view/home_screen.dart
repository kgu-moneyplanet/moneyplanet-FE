import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/presentaion/home/view/home_first_section.dart';
import 'package:money_planet/presentaion/home/view/home_third_section.dart';

import 'home_second_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: neutral_900,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HomeFirstSection(),

                SizedBox(height: 40),

                HomeSecondSection(),

                SizedBox(height: 40),

                HomeThirdSection(),

                SizedBox(height: 70),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
