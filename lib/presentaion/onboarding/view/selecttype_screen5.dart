import 'package:flutter/material.dart';
import 'package:money_planet/presentaion/onboarding/view/resulttype_screen.dart';
import '../../../global/theme/colors.dart';
import '../../../global/theme/textStyles.dart';

class SelectTypeScreen5 extends StatelessWidget {
  final PageController controller;

  const SelectTypeScreen5({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary_050,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    '13. 추가로 선장님(AI)이 꼭 알아야 하는 사실들이 있으면 적어주세요. 최대한 다양하고 자세하게 적어주시면 항해가 수월해집니다!',
                    style: customTextStyle(
                      fontFamily: Pretendard_Medium_16,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    child: TextField(
                      minLines: 1,
                      maxLines: 100,
                      maxLength: 100,
                      decoration: InputDecoration(
                        hintText:
                            '예) 저는 직업, 취미 등의 이유로 기호식품(담배, 커피, 술등)의 소비가 필수적입니다.',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 100,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: 343,
              height: 56,
              child: ElevatedButton(
                onPressed: () async {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: false,
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (context, animation1, animation2) {
                      return const _RocketLoadingDialog();
                    },
                  );

                  await Future.delayed(const Duration(seconds: 5));

                  if (context.mounted) {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ResultTypeScreen()),
                    );
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
    );
  }
}

class _RocketLoadingDialog extends StatelessWidget {
  const _RocketLoadingDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85), // 완전한 배경 덮기
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
