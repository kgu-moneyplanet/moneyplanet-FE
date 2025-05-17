import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/presentaion/onboarding/view/selecttype_screen1.dart';
import 'package:money_planet/presentaion/onboarding/view/selecttype_screen2.dart';
import 'package:money_planet/presentaion/onboarding/view/selecttype_screen3.dart';
import 'package:money_planet/presentaion/onboarding/view/selecttype_screen4.dart';
import 'package:money_planet/presentaion/onboarding/view/selecttype_screen5.dart';
import 'package:money_planet/presentaion/onboarding/view/resulttype_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../global/planet_list.dart';
import 'guidetype_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  _QuestionFlowState createState() => _QuestionFlowState();
}

class _QuestionFlowState extends State<QuestionScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late final List<Widget> _pages;
  final Map<String, int> _answers = {};

  @override
  void initState() {
    super.initState();
    _pages = [
      GuideTypeScreen(controller: _pageController),
      SelectTypeScreen1(
        controller: _pageController,
        answers: _answers,
        onAnswerSelected: _onAnswerSelected, onNext: () {  },
      ),
      SelectTypeScreen2(
        controller: _pageController,
        answers: _answers,
        onAnswerSelected: _onAnswerSelected, onNext: () {  },
      ),
      SelectTypeScreen3(
        controller: _pageController,
        answers: _answers,
        onAnswerSelected: _onAnswerSelected, onNext: () {  },
      ),
      SelectTypeScreen4(
        controller: _pageController,
        answers: _answers,
        onAnswerSelected: _onAnswerSelected, onNext: () {  },
      ),
      SelectTypeScreen5(
        controller: _pageController,
        answers: _answers,
        onDone: _onAllAnswered,
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onAnswerSelected(String key, int value) {
    setState(() {
      _answers[key] = value;
    });
  }

  void _onAllAnswered() {
    final planet = classifyPlanet(_answers);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultTypeScreen(planet: planet),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (idx) => setState(() => _currentPage = idx),
            children: _pages,
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _pages.length,
                effect: WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 8,
                  activeDotColor: neutral_600,
                  dotColor: neutral_200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
