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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              questionBlock(' 1. 외출 시 소비 패턴은?', 'q1', q1, [
                '카페나 맛집에서 돈을 쓰는 걸 즐긴다.',
                '꼭 필요한 경우가 아니면 외출을 줄이고 돈을 아낀다.',
              ]),
              const SizedBox(height: 24),
              questionBlock(' 2. 쇼핑할 때 나는?', 'q2', q2, [
                '친구들과 함께 다니면서 쇼핑하는 것을 좋아한다.',
                '혼자 조용히 쇼핑하는 게 더 편한다.',
              ]),
              const SizedBox(height: 24),
              questionBlock(' 3. 충동구매 시 나는?', 'q3', q3, [
                '친구나 주변 사람의 추천에 영향을 받는다.',
                '내 판단대로 결정하는 편이다.',
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
          textAlign: TextAlign.left,
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
                textAlign: TextAlign.left,
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
