import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/textStyles.dart';

import '../../../global/theme/colors.dart';

class HintABCScreen extends StatelessWidget {
  const HintABCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: primary_050,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Glow 효과용 원
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: neutral_500,
                          ),
                        ),
                        Text(
                          '1',
                          style: customTextStyle(
                            fontFamily: Pretendard_Medium_18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '각 소비 항목들은 AI 분석을 통해 다음과 같이 분류 됩니다.',
                      style: customTextStyle(
                        fontFamily: Pretendard_Semibold_20,
                        color: neutral_1100,
                      ),
                    ),
                  ),
                ],
              ),
            ), // 1번
            Container(
              width: 384,
              height: 450,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Container(
                    width: 356,
                    height: 55,
                    decoration: BoxDecoration(
                      color: primary_400,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'A - 필수 소비',
                      style: customTextStyle(
                        fontFamily: Pretendard_Semibold_18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      '먹고사는 데 필수적인 소비. 교통비나 식대, 아파트 관리비, 세금과 같은 소비가 이 소비에 속한다.',
                      style: customTextStyle(
                        fontFamily: Pretendard_Medium_16,
                        color: neutral_1100,
                      ),
                    ),
                  ),
                  Container(
                    width: 356,
                    height: 55,
                    decoration: BoxDecoration(
                      color: primary_050,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'B - 선택적 소비',
                      style: customTextStyle(
                        fontFamily: Pretendard_Semibold_18,
                        color: primary_400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      '반드시까지는 아니더라도 필요한 소비. 자녀 학원비나 미용실 같은 소비가 이 소비에 속한다.',
                      style: customTextStyle(
                        fontFamily: Pretendard_Medium_16,
                        color: neutral_1100,
                      ),
                    ),
                  ),
                  Container(
                    width: 356,
                    height: 55,
                    decoration: BoxDecoration(
                      color: secondary_200,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'C - 불필요 소비',
                      style: customTextStyle(
                        fontFamily: Pretendard_Semibold_18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      '그다지 필요 없는 낭비성 지출에 가까운 소비. 명품이나 잦은 외식, 또는 신경쓰면 나가지 않아도 되는 주차위반 딱지나 과태료가 이 소비에 속한다.',
                      style: customTextStyle(
                        fontFamily: Pretendard_Medium_16,
                        color: neutral_1100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Glow 효과용 원
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: neutral_500,
                          ),
                        ),
                        Text(
                          '2',
                          style: customTextStyle(
                            fontFamily: Pretendard_Medium_18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'AI 분석 결과는 수정할 수 있습니다.',
                      style: customTextStyle(
                        fontFamily: Pretendard_Semibold_20,
                        color: neutral_1100,
                      ),
                    ),
                  ),
                ],
              ),
            ), // 2번
            Container(
              width: 384,
              height: 638,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height: 28),
                  Text(
                    'AI 분석 수정',
                    style: customTextStyle(
                      fontFamily: Pretendard_Semibold_22,
                      color: neutral_1100,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    width: 289,
                    height: 55,
                    decoration: BoxDecoration(
                      color: primary_400,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          'A - 필수 소비',
                          style: customTextStyle(
                            fontFamily: Pretendard_Semibold_18,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Spacer(),
                        Icon(Icons.check_circle, color: Colors.white, size: 25),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    width: 289,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: primary_400, width: 1),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'B - 선택적 소비',
                      style: customTextStyle(
                        fontFamily: Pretendard_Semibold_18,
                        color: primary_400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    width: 289,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: primary_400, width: 1),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'C - 불필요 소비',
                      style: customTextStyle(
                        fontFamily: Pretendard_Semibold_18,
                        color: primary_400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '더 나은 맞춤형 분석을 위해 의견을 입력해주세요!',
                    style: customTextStyle(
                      fontFamily: Pretendard_Medium_16,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    width: 289,
                    height: 173,
                    decoration: BoxDecoration(
                      color: neutral_050,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Text(
                      '예) 이러이러한 이유로 해당 소비를 다음과 같이 변경했습니다.',
                      style: customTextStyle(
                        fontFamily: Pretendard_Semibold_14,
                        color: neutral_200,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    width: 289,
                    height: 55,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [secondary_050_1,
                        secondary_050_2],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '수정완료',
                      style: customTextStyle(
                        fontFamily: Pretendard_Semibold_18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Glow 효과용 원
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: neutral_500,
                          ),
                        ),
                        Text(
                          '3',
                          style: customTextStyle(
                            fontFamily: Pretendard_Medium_18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '분석이 완료된 소비는 다음과 같이 카테고리의 배경색으로 타입이 표시됩니다.',
                      style: customTextStyle(
                        fontFamily: Pretendard_Semibold_20,
                        color: neutral_1100,
                      ),
                    ),
                  ),
                ],
              ),
            ), //3번
            Container(
              width: 384,
              height: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 102,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primary_400,
                            ),
                          ),
                          Image.asset(
                            'lib/global/assets/images/type_icon/type_food.png',
                            width: 50,
                            height: 52,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '식비, A',
                        style: customTextStyle(
                          fontFamily: Pretendard_Medium_16,
                          color: neutral_1100,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 102,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primary_050,
                            ),
                          ),
                          Image.asset(
                            'lib/global/assets/images/type_icon/type_cafe.png',
                            width: 50,
                            height: 52,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '카페/간식, B',
                        style: customTextStyle(
                          fontFamily: Pretendard_Medium_16,
                          color: neutral_1100,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 102,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: secondary_200,
                            ),
                          ),
                          Image.asset(
                            'lib/global/assets/images/type_icon/type_shopping.png',
                            width: 50,
                            height: 52,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '패션/쇼핑, C',
                        style: customTextStyle(
                          fontFamily: Pretendard_Medium_16,
                          color: neutral_1100,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
