import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';

import '../../../global/planet_list.dart';
import '../../../network/Daily/Response/LWTWResponseDTO.dart';

class HomeSecondSection extends StatelessWidget {
  final PlanetModel planetModel;
  final double planetTarget;
  final LWTWResponseData? comparisonData;

  const HomeSecondSection({super.key, required this.planetModel, this.comparisonData, required this.planetTarget});

  @override
  Widget build(BuildContext context) {
    final lastWeekName = comparisonData?.lastWeekCategoryName ?? "N/A";
    final lastWeekAmount = comparisonData?.lastWeekCategoryAmount ?? 0;

    final thisWeekName = comparisonData?.thisWeekCategoryName ?? "N/A";
    final thisWeekAmount = comparisonData?.thisWeekCategoryAmount ?? 0;

    final diffAmount = comparisonData?.diffAmount ?? 0;
    final diffSign = diffAmount >= 0 ? "+" : "";
    final diffColor = diffAmount >= 0 ? primary_400 : Colors.red;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23, vertical: 0),
      child: Container(
        height: 201,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // 도달률 및 아이콘
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/planet_icon/planet_border.png',
                        width: 108,
                        height: 108,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        planetModel.imageURL,
                        width: 88,
                        height: 88,
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  Text('$planetTarget%',
                    style: customTextStyle(
                      fontFamily: Pretendard_Semibold_16,
                      color: neutral_1100,
                    ),
                  ),
                ],
              ),
            ),

            // 저번 달, 이번 달 불필요 지출
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 18, 20, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("저번 주 최대 불필요 지출"),
                    SizedBox(height: 6),
                    Container(
                      height: 39,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: primary_050,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          // 아이콘은 category별로 매핑 필요
                          Image.asset(
                            'assets/images/icons/category_rest.png',
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(width: 4),
                          Text(lastWeekName, style: Pretendard_Medium_10,),
                          Spacer(),
                          Text("$lastWeekAmount원", style: Pretendard_Medium_10,),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    Text("이번 주 최대 불필요 지출"),
                    SizedBox(height: 6),

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: primary_050,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/icons/category_shopping.png',
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(width: 4),
                            Text(thisWeekName, style: Pretendard_Medium_10,),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$thisWeekAmount원", style: Pretendard_Medium_10,),
                                Text(
                                  "($diffSign$diffAmount원)",
                                    style: Pretendard_Medium_10,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
