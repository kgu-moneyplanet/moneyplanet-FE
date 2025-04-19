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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              questionBlock('4. 물건을 살 때 나는?', 'q4', q4, [
                '후기를 꼼꼼히 읽고 실용성을 따진다.',
                '감각적으로 끌리는 제품을 선택한다.',
              ]),
              const SizedBox(height: 24),
              questionBlock('5. 가계부를 작성할 때 나는?', 'q5', q5, [
                '숫자와 데이터를 꼼꼼하게 정리한다.',
                '소비 패턴의 흐름을 감각적으로 파악한다.',
              ]),
              const SizedBox(height: 24),
              questionBlock('6. 내가 더 선호하는 소비 방식은?', 'q6', q6, [
                '가성비 좋은 실용적인 물건을 구매한다.',
                '약간 비싸더라도 트렌디하고 감성적인 아이템을 산다.',
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
