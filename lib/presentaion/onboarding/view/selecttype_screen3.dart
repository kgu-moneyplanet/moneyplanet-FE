import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../global/theme/colors.dart';
import '../../../global/theme/textStyles.dart';

class SelectTypeScreen3 extends StatefulWidget {
  final PageController controller;
  final VoidCallback onNext;
  final void Function(String key, int value) onAnswerSelected;
  final Map<String, int> answers;

  const SelectTypeScreen3({
    super.key,
    required this.onNext,
    required this.onAnswerSelected,
    required this.answers,
    required this.controller,
  });

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary_050,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              questionBlock('7. 큰 지출을 결정할 때 나는?', 'q7', q7, [
                '논리적으로 따져보고 결론을 내린다.',
                '내 감정과 직관을 반영해서 결정하는 편이다.',
              ]),
              const SizedBox(height: 24),
              questionBlock('8. 친구가 비싼 브랜드 제품을 추천하면 나는?', 'q8', q8, [
                '가성비가 좋은지 먼저 따진다.',
                '브랜드의 감성과 가치가 더 중요하다.',
              ]),
              const SizedBox(height: 24),
              questionBlock('9. 선물을 고를 때 나는?', 'q9', q9, [
                '가격 대비 실용성을 고려한다.',
                '받는 사람이 좋아할 감정을 더 중요하게 생각한다.',
              ]),
              const SizedBox(height: 100),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    widget.controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary_400,
                    fixedSize: const Size(343, 56),
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

  Widget questionBlock(
      String title,
      String key,
      int? selectedIndex,
      List<String> options,
      ) {
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
        const SizedBox(height: 8),
        for (int i = 0; i < options.length; i++)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: ElevatedButton(
              onPressed: () => select(key, i),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                selectedIndex == i ? primary_300 : Colors.white,
                fixedSize: const Size(357, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                options[i],
                style: customTextStyle(
                  fontFamily: Pretendard_Medium_14,
                  color: selectedIndex == i ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

