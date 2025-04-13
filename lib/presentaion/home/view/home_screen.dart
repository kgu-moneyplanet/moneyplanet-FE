import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/presentaion/home/view/home_first_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: neutral_900,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                children: [
                  home_first_section(),

                  SizedBox(height: 48,),



                ],
            ),
          ),
        ),
      ),
    );
  }
}
