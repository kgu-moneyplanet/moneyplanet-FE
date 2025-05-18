import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';

class HomeSecondSection extends StatelessWidget {
  const HomeSecondSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                        'assets/images/planet_icon/EARTH.png',
                        width: 88,
                        height: 88,
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  Text(
                    "도달률 50%",
                    style: customTextStyle(
                      fontFamily: Pretendard_Semibold_14,
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
                    Text(
                      "저번 달 최대 불필요 지출",
                      style: customTextStyle(
                        fontFamily: Pretendard_Medium_12,
                        color: neutral_1100,
                      ),
                    ),
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
                          Image.asset(
                            'assets/images/icons/category_rest.png',
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "여가생활",
                            style: customTextStyle(
                              fontFamily: Pretendard_Medium_12,
                              color: neutral_1100,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "20,000원",
                            style: customTextStyle(
                              fontFamily: Pretendard_Semibold_14,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    Text(
                      "이번 달 최대 불필요 지출",
                      style: customTextStyle(
                        fontFamily: Pretendard_Medium_12,
                        color: neutral_1100,
                      ),
                    ),
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
                            Text(
                              "쇼핑",
                              style: customTextStyle(
                                fontFamily: Pretendard_Medium_12,
                                color: neutral_1100,
                              ),
                            ),
                            Spacer(),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "30,000원",
                                  style: customTextStyle(
                                    fontFamily: Pretendard_Semibold_14,
                                    color: neutral_1100,
                                  ),
                                ),

                                Text(
                                  "(+10,000원)",
                                  style: customTextStyle(
                                    fontFamily: Pretendard_Semibold_12,
                                    color: primary_400,
                                  ),
                                ),
                              ],
                            ),
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
