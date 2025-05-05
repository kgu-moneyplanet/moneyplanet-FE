import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../global/theme/colors.dart';
import '../../../global/theme/textStyles.dart';

class SelectTypeScreen4 extends StatefulWidget {
  final PageController controller;
  final VoidCallback onNext;
  final void Function(String key, int value) onAnswerSelected;
  final Map<String, int> answers;

  const SelectTypeScreen4({
    super.key,
    required this.onNext,
    required this.onAnswerSelected,
    required this.answers,
    required this.controller,
  });

  @override
  State<SelectTypeScreen4> createState() => _SelectTypeScreen4State();
}

class _SelectTypeScreen4State extends State<SelectTypeScreen4> {
  int? q10;
  int? q11;
  int? q12;

  void select(String key, int index) {
    setState(() {
      if (key == 'q10') q10 = index;
      if (key == 'q11') q11 = index;
      if (key == 'q12') q12 = index;
    });
    widget.onAnswerSelected(key, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary_050,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 20),
        child: Column(
          children: [
            // 질문 및 선택지
            Expanded(
              child: ListView(
                children: [
                  buildQuestion(
                    title: '10. 월급을 받으면 나는?',
                    keyStr: 'q10',
                    selectedIndex: q10,
                    options: [
                      '예산을 짜고 계획적으로 소비한다',
                      '필요할 때마다 유동적으로 소비한다',
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildQuestion(
                    title: '11. 여행을 갈 때 나는?',
                    keyStr: 'q11',
                    selectedIndex: q11,
                    options: [
                      '미리 철저히 계획하고 예산을 짠다',
                      '즉흥적으로 움직이고 유연하게 대응한다',
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildQuestion(
                    title: '12. 지출을 줄이려 할 때 나는?',
                    keyStr: 'q12',
                    selectedIndex: q12,
                    options: [
                      '계획을 세워 하나씩 조절한다',
                      '감정에 따라 지출이 들쭉날쭉하다',
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 다음 버튼
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  widget.controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary_400,
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

  Widget buildQuestion({
    required String title,
    required String keyStr,
    required int? selectedIndex,
    required List<String> options,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: customTextStyle(
            fontFamily: Pretendard_Medium_16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        for (int i = 0; i < options.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ElevatedButton(
              onPressed: () => select(keyStr, i),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    selectedIndex == i ? primary_300 : Colors.white,
                fixedSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  options[i],
                  style: customTextStyle(
                    fontFamily: Pretendard_Medium_14,
                    color: selectedIndex == i ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
