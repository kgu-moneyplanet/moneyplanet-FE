import 'package:flutter/material.dart';
import '../../../global/theme/colors.dart';
import '../../../global/theme/textStyles.dart';

class SelectTypeScreen3 extends StatefulWidget {
  final PageController controller;
  final VoidCallback onNext;
  final void Function(String key, int value) onAnswerSelected;
  final Map<String, int> answers;

  const SelectTypeScreen3({
    Key? key,
    required this.controller,
    required this.onAnswerSelected,
    required this.answers, required this.onNext,
  }) : super(key: key);

  @override
  State<SelectTypeScreen3> createState() => _SelectTypeScreen3State();
}

class _SelectTypeScreen3State extends State<SelectTypeScreen3> {
  int? q7;
  int? q8;
  int? q9;

  void select(String key, int index) {
    setState(() {
      if (key == 'q7') q7 = index;
      if (key == 'q8') q8 = index;
      if (key == 'q9') q9 = index;
    });
    widget.onAnswerSelected(key, index);
  }
  bool get allSelected => q7 != null && q8 != null && q9 != null;
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
                    title: '7. 큰 지출을 결정할 때 나는?',
                    keyStr: 'q7',
                    selectedIndex: q7,
                    options: [
                      '논리적으로 따져보고 결론을 내린다.',
                      '내 감정과 직관을 반영해서 결정하는 편이다.',
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildQuestion(
                    title: '8. 친구가 비싼 브랜드 제품을 추천하면 나는?',
                    keyStr: 'q8',
                    selectedIndex: q8,
                    options: [
                      '가성비가 좋은지 먼저 따진다.',
                      '브랜드의 감성과 가치가 더 중요하다.',
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildQuestion(
                    title: '9. 선물을 고를 때 나는?',
                    keyStr: 'q9',
                    selectedIndex: q9,
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
                onPressed: allSelected
                    ? () {
                  widget.controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
                    : null,
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

