import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../global/theme/colors.dart';
import '../../../global/theme/textStyles.dart';

class SelectTypeScreen2 extends StatefulWidget {
  final PageController controller;
  final VoidCallback onNext;
  final void Function(String key, int value) onAnswerSelected;
  final Map<String, int> answers;

  const SelectTypeScreen2({
    super.key,
    required this.onNext,
    required this.onAnswerSelected,
    required this.answers,
    required this.controller,
  });

  @override
  State<SelectTypeScreen2> createState() => _SelectTypeScreen2State();
}

class _SelectTypeScreen2State extends State<SelectTypeScreen2> {
  int? q4;
  int? q5;
  int? q6;

  void select(String key, int index) {
    setState(() {
      if (key == 'q4') q4 = index;
      if (key == 'q5') q5 = index;
      if (key == 'q6') q6 = index;
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
                    title: '4. 물건을 살 때 나는?',
                    keyStr: 'q4',
                    selectedIndex: q4,
                    options: [
                      '후기를 꼼꼼히 읽고 실용성을 따진다.',
                      '감각적으로 끌리는 제품을 선택한다.',
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildQuestion(
                    title: '5. 가계부를 작성할 때 나는?',
                    keyStr: 'q5',
                    selectedIndex: q5,
                    options: [
                      '숫자와 데이터를 꼼꼼하게 정리한다.',
                      '소비 패턴의 흐름을 감각적으로 파악한다.',
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildQuestion(
                    title: '6. 내가 더 선호하는 소비 방식은?',
                    keyStr: 'q6',
                    selectedIndex: q6,
                    options: [
                      '가성비 좋은 실용적인 물건을 구매한다.',
                      '약간 비싸더라도 트렌디하고 감성적인 아이템을 산다.',
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
