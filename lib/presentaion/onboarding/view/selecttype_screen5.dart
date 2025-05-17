import 'package:flutter/material.dart';
import 'package:money_planet/presentaion/onboarding/view/resulttype_screen.dart';
import '../../../global/theme/colors.dart';
import '../../../global/theme/textStyles.dart';

class SelectTypeScreen5 extends StatelessWidget {
  final PageController controller;
  final Map<String, int> answers;
  final VoidCallback onDone;

  const SelectTypeScreen5({
    Key? key,
    required this.controller,
    required this.answers,
    required this.onDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary_050,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '13. 추가로 선장님(AI)이 꼭 알아야 하는 사실들이 있으면 적어주세요. 최대한 다양하고 자세하게 적어주시면 항해가 수월해집니다!',
                style: customTextStyle(
                  fontFamily: Pretendard_Medium_16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: 357,
                child: TextField(
                  onChanged: (text) => answers['q13'] = text.hashCode,
                  minLines: 5,
                  maxLines: 10,
                  maxLength: 100,
                  decoration: InputDecoration(
                    hintText: '예) 저는 직업, 취미 등의 이유로 기호식품(담배, 커피, 술등)의 소비가 필수적입니다.',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              SizedBox(
                width: 343,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    // 1) 다이얼로그 띄울 때 showDialog 사용 & rootNavigator 지정
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      useRootNavigator: true,
                      builder: (_) => const _RocketLoadingDialog(),
                    );

                    // 2) 분석 작업 (예: 2초 대기)
                    await Future.delayed(const Duration(seconds: 2));

                    // 3) 다이얼로그 닫기 (최상위 네비게이터에서)
                    if (context.mounted) {
                      Navigator.of(context, rootNavigator: true).pop();
                      onDone();  // 설문 완료 콜백 실행
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: neutral_300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    '다음',
                    style: customTextStyle(
                      fontFamily: Pretendard_Medium_18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RocketLoadingDialog extends StatelessWidget {
  const _RocketLoadingDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/rocket1.png',
              width: 338,
              height: 338,
            ),
            const SizedBox(height: 24),
            Text(
              '행성을 분석하고 있습니다.',
              style: customTextStyle(
                fontFamily: Pretendard_Medium_24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '로켓발사 준비 중…',
              style: customTextStyle(
                fontFamily: Pretendard_Medium_20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}