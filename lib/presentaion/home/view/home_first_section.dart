import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';

class HomeFirstSection extends StatelessWidget {
  const HomeFirstSection({super.key});

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
                "머니플래닛",
                style: customTextStyle(
                  fontFamily: Pretendard_Semibold_20,
                  color: Colors.white,
                ),
              ),

              Spacer(),

              IconButton(
                onPressed: () {
                  print("tapped bell");
                },
                icon: Image.asset('lib/global/assets/images/icons/bell_01.png'),
              ),

              IconButton(
                onPressed: () {
                  print("tapped help");
                },
                icon: Image.asset(
                  'lib/global/assets/images/icons/help_circle.png',
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
              'lib/global/assets/images/planet_icon/planet3.png',
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
              "지구형",
              style: customTextStyle(
                fontFamily: Pretendard_Bold_24,
                color: Colors.white,
              ),
            ),

            IconButton(
              onPressed: () {
                print('행성설명 부분');
              },
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 48),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                colors: [secondary_100_1, secondary_100_2],
              ),
            ),
            height: 42,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              "지갑은 열려있고 계획은 자유로운 유형",
              style: customTextStyle(
                fontFamily: Pretendard_Medium_16,
                color: neutral_900,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
