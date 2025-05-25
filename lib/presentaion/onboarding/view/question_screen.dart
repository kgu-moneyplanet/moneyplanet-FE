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
import '../../../global/theme/textStyles.dart';
import '../../../network/Login/Response/LoginFailureResponseDTO.dart';
import '../../../network/Login/Response/LoginSuccessResponseDTO.dart';
import '../../../network/TokenStorage.dart';
import '../viewModel/LoginViewModel.dart';
import '../viewModel/SignupViewModel.dart';
import 'guidetype_screen.dart';

class QuestionScreen extends StatefulWidget {
  final SignUpViewModel viewModel;

  const QuestionScreen({required this.viewModel, super.key});

  @override
  State<QuestionScreen> createState() => _QuestionFlowState();
}

class _QuestionFlowState extends State<QuestionScreen> {
  final PageController _pageController = PageController();
  final Map<String, int> _answers = {};

  @override
  Widget build(BuildContext context) {
    final pages = [
      GuideTypeScreen(controller: _pageController),
      SelectTypeScreen1(controller: _pageController,
          answers: _answers,
          onAnswerSelected: _onAns,
          onNext: _next),
      SelectTypeScreen2(controller: _pageController,
          answers: _answers,
          onAnswerSelected: _onAns,
          onNext: _next),
      SelectTypeScreen3(controller: _pageController,
          answers: _answers,
          onAnswerSelected: _onAns,
          onNext: _next),
      SelectTypeScreen4(controller: _pageController,
          answers: _answers,
          onAnswerSelected: _onAns,
          onNext: _next),
      SelectTypeScreen5(
        controller: _pageController,
        answers: _answers,
        onDone: _onDone,
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          PageView(controller: _pageController,
              physics: const BouncingScrollPhysics(),
              children: pages),
          Positioned(
            bottom: 100,
            left: 0, right: 0,
            child: Center(child: SmoothPageIndicator(
                controller: _pageController,
                count: pages.length,
                effect: WormEffect(dotHeight: 10,
                    dotWidth: 10,
                    spacing: 8,
                    activeDotColor: neutral_600,
                    dotColor: neutral_200),
            ),
            ),
          ),
        ],
      ),
    );
  }

  void _onAns(String k, int v) => setState(() => _answers[k] = v);

  void _next() => _pageController.nextPage(
    duration: const Duration(milliseconds: 300),
    curve: Curves.ease,
  );

  Future<void> _onDone() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (_) => const _RocketLoadingDialog(),
    );

    final planetModel = classifyPlanet(_answers);
    widget.viewModel.prefer = _answers['q13']?.toString();
    widget.viewModel.planet = planetModel.apiValue;

    final signUpError = await widget.viewModel.signUp();

    if (context.mounted) Navigator.of(context, rootNavigator: true).pop();

    if (signUpError != null) {
      // 회원가입 실패 처리
      return showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: const Text('회원가입 실패'),
              content: Text(signUpError.message),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context),
                    child: const Text('확인')),
              ],
            ),
      );
    }

    // 4) 자동 로그인
    final loginVM = LoginViewModel()
      ..usernameController.text = widget.viewModel.usernameController.text
      ..passwordController.text = widget.viewModel.passwordController.text;

    final loginResult = await loginVM.login();

    if (loginResult is LoginFailureResponseDTO) {
      // 로그인 실패 처리
      return showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: const Text('자동 로그인 실패'),
              content: Text(loginResult.message),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context),
                    child: const Text('확인')),
              ],
            ),
      );
    }

    // 5) 로그인 성공 시 토큰 저장 & 화면 이동
    if (loginResult is LoginSuccessResponseDTO) {
      await TokenStorage.saveToken(loginResult.token);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => ResultTypeScreen(planet: planetModel)),
      );
    }
  }
  }

class _RocketLoadingDialog extends StatelessWidget {
  const _RocketLoadingDialog();

  @override
  Widget build(BuildContext context) =>
      Scaffold(backgroundColor: Colors.black,
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                'assets/images/rocket1.png', width: 338, height: 338),
            const SizedBox(height: 24),
            Text('행성을 분석하고 있습니다.', style: customTextStyle(
                fontFamily: Pretendard_Medium_24, color: Colors.white)),
            const SizedBox(height: 12),
            Text('로켓발사 준비 중…', style: customTextStyle(
                fontFamily: Pretendard_Medium_20, color: Colors.white))
          ],
        ),
        ),
      );
}