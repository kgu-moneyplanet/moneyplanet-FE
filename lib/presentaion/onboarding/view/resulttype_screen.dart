import 'package:flutter/material.dart';
import 'package:money_planet/global/planet_list.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';

import '../../../application/tabBar/view/tab_screen.dart';

class ResultTypeScreen extends StatelessWidget {
  final PlanetModel planet;

  const ResultTypeScreen({
    Key? key,
    required this.planet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral_900,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 245,
                height: 245,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: secondary_100_1,
                      blurRadius: 70,
                    ),
                  ],
                ),
              ),
              // 동적으로 받은 행성 이미지
              Image.asset(
                planet.imageURL,
                width: 329,
                height: 329,
                fit: BoxFit.cover,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "당신이 가고싶은 행성은\n'${planet.name}' 입니다",
            textAlign: TextAlign.center,
            style: customTextStyle(
              color: Colors.white,
              fontFamily: Pretendard_Medium_24,
            ),
          ),
          const SizedBox(height: 16),
          // 키워드 태그: summary를 기준으로 아이콘 및 텍스트 표시
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTag(planet.iconsURL, planet.summary),
            ],
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              planet.description,
              textAlign: TextAlign.center,
              style: customTextStyle(
                color: Colors.white,
                fontFamily: Pretendard_Medium_16,
              ),
            ),
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TabScreen()),
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
              '시작하기',
              style: customTextStyle(
                fontFamily: Pretendard_Medium_18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String iconUrl, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            colors: [secondary_100_1, secondary_100_2],
          ),
        ),
        child: Row(
          children: [
            Image.asset(iconUrl, width: 16, height: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: customTextStyle(
                fontFamily: Pretendard_Medium_14,
                color: neutral_600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
