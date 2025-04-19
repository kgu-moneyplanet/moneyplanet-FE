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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              questionBlock('10. 월급을 받으면 나는?', 'q10', q10, [
                '먼저 예산을 짜고 계획적으로 소비한다.',
                '필요한 순간마다 유동적으로 소비한다.',
              ]),
              const SizedBox(height: 24),
              questionBlock('11. 여행을 갈 때 나는?', 'q11', q11, [
                '세부 일정과 예산을 미리 철저히 계획한다.',
                '즉흥적으로 계획을 세우고 유연하게 움직인다.',
              ]),
              const SizedBox(height: 24),
              questionBlock('12. 지출을 줄이려 할 때 나는?', 'q12', q12, [
                '계획을 세워 하나씩 조절한다.',
                '줄이려고 하지만 감정에 따라 변동이 생긴다.',
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
