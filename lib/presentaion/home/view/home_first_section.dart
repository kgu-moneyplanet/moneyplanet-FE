import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';

import '../../../global/planet_list.dart';
import '../../../network/User/Response/UserInfoResponseDTO.dart';
import '../../myPage/view/hint_screen.dart';

class HomeFirstSection extends StatelessWidget {
  final PlanetModel planetModel;

  const HomeFirstSection({super.key, required this.planetModel});

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
              planetModel!.imageURL,
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
            Text(
              planetModel.name,
              style: customTextStyle(
                fontFamily: Pretendard_Bold_24,
                color: Colors.white,
              ),
            ),
          ],
        ),

        SizedBox(height: 10,),

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
              planetModel.summary,
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
