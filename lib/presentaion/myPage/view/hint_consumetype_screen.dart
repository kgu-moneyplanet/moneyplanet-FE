import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import '../../../global/planet_list.dart';
import '../../../global/theme/colors.dart';


class HintConsumeTypeScreen extends StatelessWidget {
  const HintConsumeTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: primary_050,
        child: Column(
          children: planetList.map((planet) => _buildCard(planet)).toList(),
        ),
      ),
    );
  }

  Widget _buildCard(PlanetModel planet) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 23),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Stack(
          alignment: Alignment.center,
          children: [
          // Glow 효과용 원
          Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [secondary_100_1, secondary_100_2],
            ),
            shape: BoxShape.circle,
          ),
        ),
        Image.asset(
          planet.imageURL,
          width: 90,
          height: 90,
          fit: BoxFit.contain,
        ),
        ],
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Container(
              alignment: Alignment.center,
              height: 28,
              width: 135,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: primary_400
              ),
              child: Text('행성타입 - ${planet.name}',
                  style: customTextStyle(
                      fontFamily: Pretendard_Semibold_14, color: Colors.white)
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Image.asset(
                  planet.iconsURL,
                  width: 18,
                  height: 18,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 10,),
                Text(planet.summary,
                    style: customTextStyle(
                        fontFamily: Pretendard_Semibold_12, color: primary_400)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              planet.description,
              style: customTextStyle(
                  fontFamily: Pretendard_Medium_12, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: Text('자세히 보기 >',
                  style: customTextStyle(
                      fontFamily: Pretendard_Medium_12, color: neutral_500)),
            )
          ],
        ),
      ),
      ],
    ),)
    ,
    );
  }
}