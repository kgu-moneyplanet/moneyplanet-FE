import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import 'package:money_planet/presentaion/myPage/view/hint_screen.dart';

import '../../onboarding/view/question_screen.dart';


class MypageFirstSection extends StatelessWidget {
  const MypageFirstSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 앱 이름 및 도움말, 알림 아이콘 부분
        SizedBox(
          height: 52,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 28),
              Text(
                "마이페이지",
                style: customTextStyle(
                  fontFamily: Pretendard_Bold_28,
                  color: Colors.white,
                ),
              ),

              Spacer(),

              IconButton(
                onPressed: () {
                  print("tapped bell");
                },
                icon: Image.asset('assets/images/icons/bell_01.png'),
              ),

              IconButton(
                onPressed: () {
                  print("tapped help");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HintScreen()),
                  );
                },
                icon: Image.asset(
                  'assets/images/icons/help_circle.png',
                ),
              ),

              SizedBox(width: 28),
            ],
          ),
        ),

        SizedBox(height: 10),

        // 행성 아이콘 부분
        Stack(
          alignment: Alignment.center,
          children: [
            // Glow 효과용 원
            Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: secondary_100_1, // 후광 색상
                    blurRadius: 70, // 흐림 정도 (이게 glow)
                  ),
                ],
              ),
            ),

            // 실제 이미지
            Image.asset(
              'assets/images/planet_icon/EARTH.png',
              width: 190,
              height: 190,
              fit: BoxFit.cover,
            ),
          ],
        ),

        // 행성 밑 유형 설명 부분
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 40),

            Text(
              "머니코치님",
              style: customTextStyle(
                fontFamily: Pretendard_Bold_24,
                color: Colors.white,
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary_400,
                    boxShadow: [
                      BoxShadow(
                        color: secondary_100_1, // 후광 색상
                        blurRadius: 70, // 흐림 정도 (이게 glow)
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print('닉네임 편집');
                  },
                  icon: Image.asset(
                    'assets/images/icons/pencil_line.png',
                    width: 13,
                    height: 13,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
        Center(
          child: Text(
            "admin1234",
            style: customTextStyle(
              fontFamily: Pretendard_Medium_16,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 48),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const QuestionScreen(),
                  ),
                      (route) => false,
                );
              },
              child: Container(
                width: 343,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [secondary_100_1, secondary_100_2],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "소비 성향 재검사하기",
                  style: customTextStyle(
                    fontFamily: Pretendard_Medium_18,
                    color: neutral_900,
                  ),
                ),
              ),
            )
        ),
      ],
    );
  }
}
