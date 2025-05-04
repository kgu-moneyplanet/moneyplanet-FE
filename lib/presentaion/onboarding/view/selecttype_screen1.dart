import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../global/theme/textStyles.dart';

class SelectTypeScreen1 extends StatefulWidget {
  final PageController controller;

  final VoidCallback onNext;
  final void Function(String key, int value) onAnswerSelected;
  final Map<String, int> answers;

  const SelectTypeScreen1({
    super.key,
    required this.onNext,
    required this.onAnswerSelected,
    required this.answers,
    required this.controller,
  });

  @override
  State<SelectTypeScreen1> createState() => _SelectTypeScreen1State();
}

class _SelectTypeScreen1State extends State<SelectTypeScreen1> {
  int? q1;
  int? q2;
  int? q3;

  void select(String key, int index) {
    setState(() {
      if (key == 'q1') q1 = index;
      if (key == 'q2') q2 = index;
      if (key == 'q3') q3 = index;
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
                    title: '1. 외출 시 소비 패턴은?',
                    keyStr: 'q1',
                    selectedIndex: q1,
                    options: [
                      '카페나 맛집에서 돈을 쓰는 걸 즐긴다.',
                      '꼭 필요한 경우가 아니면 외출을 줄이고 돈을 아낀다.',

                    ],
                  ),
                  const SizedBox(height: 20),
                  buildQuestion(
                    title: '2. 쇼핑할 때 나는?',
                    keyStr: 'q2',
                    selectedIndex: q2,
                    options: [
                      '친구들과 함께 다니면서 쇼핑하는 것을 좋아한다.',
                      '혼자 조용히 쇼핑하는 게 더 편한다.',
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildQuestion(
                    title: '3. 충동구매 시 나는?',
                    keyStr: 'q3',
                    selectedIndex: q3,
                    options: [
                      '친구나 주변 사람의 추천에 영향을 받는다.',
                      '내 판단대로 결정하는 편이다.',
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
