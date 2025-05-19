import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/textStyles.dart';

import '../../../global/planet_list.dart';
import '../../../global/theme/colors.dart';

class MyPageSecondSection extends StatelessWidget {
  final PlanetModel planet;

  const MyPageSecondSection({super.key, required this.planet});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/login_planet.png',
                width: 27,
                height: 28,
              ),
              const SizedBox(width: 8),
              Text(
                "행성 소개글",
                style: customTextStyle(
                  fontFamily: Pretendard_Medium_18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // planet.name형 - planet.summary
                Text(
                  '${planet.name} - ${planet.summary}',
                  style: customTextStyle(
                    fontFamily: Pretendard_Semibold_20,
                    color: primary_400,
                  ),
                ),
                const SizedBox(height: 12),
                // planet.description
                Text(
                  planet.description,
                  style: customTextStyle(
                    fontFamily: Pretendard_Medium_14,
                    color: neutral_900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
