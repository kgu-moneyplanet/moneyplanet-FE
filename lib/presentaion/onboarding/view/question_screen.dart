import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import 'package:money_planet/presentaion/onboarding/view/selecttype_screen1.dart';
import 'package:money_planet/presentaion/onboarding/view/selecttype_screen2.dart';
import 'package:money_planet/presentaion/onboarding/view/selecttype_screen3.dart';
import 'package:money_planet/presentaion/onboarding/view/selecttype_screen4.dart';
import 'package:money_planet/presentaion/onboarding/view/selecttype_screen5.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'guidetype_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  _QuestionFlowState createState() => _QuestionFlowState();
}

class _QuestionFlowState extends State<QuestionScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  late final List<Widget> _pages;  // 나중에 값을 넣겠다고 표시

  @override
  void initState() {
    super.initState();
    _pages = [
      GuideTypeScreen(controller: _pageController),
      SelectTypeScreen1(controller: _pageController, onAnswerSelected: (String key, int value) {  }, onNext: () {  }, answers: {},),
      SelectTypeScreen2(controller: _pageController, onAnswerSelected: (String key, int value) {  }, onNext: () {  }, answers: {},),
      SelectTypeScreen3(controller: _pageController, onAnswerSelected: (String key, int value) {  }, onNext: () {  }, answers: {},),
      SelectTypeScreen4(controller: _pageController, onAnswerSelected: (String key, int value) {  }, onNext: () {  }, answers: {},),
      SelectTypeScreen5(controller: _pageController,)
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  void _onNextPressed() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      // 마지막 화면에서 완료 액션
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (idx) => setState(() => _currentPage = idx),
        children: _pages,

      ),

    );
  }
  }


