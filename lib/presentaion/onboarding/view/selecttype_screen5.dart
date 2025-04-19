import 'package:flutter/material.dart';
import 'package:money_planet/presentaion/home/view/home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../application/tabBar/view/tab_screen.dart';
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  const TabScreen(),
                    ),
                  );
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
            ), // 다음
          ],
        ),
      ),
    );
  }
}
