import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';

import '../../../application/tabBar/view/tab_screen.dart';

class ResultTypeScreen extends StatelessWidget {
  const ResultTypeScreen({super.key});

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
                      color: secondary_100_1, // 후광 색상
                      blurRadius: 70, // 흐림 정도 (이게 glow)
                    ),
                  ],
                ),
              ),

              // 실제 이미지
              Image.asset(
                'lib/global/assets/images/planet_icon/planet5.png',
                width: 329,
                height: 329,
                fit: BoxFit.cover,
              ),
            ],
          ),
          Center(
            child: Text(
              "당신이 가고싶은 행성은\n '목성' 입니다",
              textAlign: TextAlign.center,
              style: customTextStyle(
                color: Colors.white,
                fontFamily: Pretendard_Medium_24,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(
                      colors: [secondary_100_1, secondary_100_2],
                    ),
                  ),
                  height: 31,
                  width: 77,
                  alignment: Alignment.center,
                  child: Text(
                    "#성향",
                    style: customTextStyle(
                      fontFamily: Pretendard_Medium_16,
                      color: neutral_600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(
                      colors: [secondary_100_1, secondary_100_2],
                    ),
                  ),
                  height: 31,
                  width: 93,
                  alignment: Alignment.center,
                  child: Text(
                    "#성향",
                    style: customTextStyle(
                      fontFamily: Pretendard_Medium_16,
                      color: neutral_600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(
                      colors: [secondary_100_1, secondary_100_2],
                    ),
                  ),
                  height: 31,
                  width: 77,
                  alignment: Alignment.center,
                  child: Text(
                    "#성향",
                    style: customTextStyle(
                      fontFamily: Pretendard_Medium_16,
                      color: neutral_600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 40),

              Text(
                "행성 자세히 보기",
                style: customTextStyle(
                  fontFamily: Pretendard_Medium_14,
                  color: primary_400,
                ),
              ),

              IconButton(
                onPressed: () => showDetail(context),
                icon: Icon(Icons.keyboard_arrow_down, color: primary_400),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              "도전과제를 달성하면서 행성에 도달해 보세요",
              textAlign: TextAlign.center,
              style: customTextStyle(
                color: Colors.white,
                fontFamily: Pretendard_Medium_20,
              ),
            ),
          ),
          const SizedBox(height: 48),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TabScreen()),
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
          ),
        ],
      ),
    );
  }

  void showDetail(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 351,
            height: 252,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상단 뱃지와 닫기 버튼
                Row(
                  children: [
                    Container(
                      height: 31,
                      width: 149,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: primary_400,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        '행성타입 - 목성형',
                        style: customTextStyle(
                          fontFamily: Pretendard_Medium_16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '닫기',
                      style: customTextStyle(
                        fontFamily: Pretendard_Medium_14,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),


                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 107,
                            height: 106,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primary_050,
                            ),
                          ),
                          Image.asset(
                            'lib/global/assets/images/planet_icon/planet5.png',
                            width: 95,
                            height: 98,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '단순한 브랜드 소비를 넘어서, 자신에게 장기적으로 도움이 되는 소비를 추구. '
                                '프리미엄 제품보다는 자기 계발, 건강, 교육 등에 투자.',
                            style: customTextStyle(
                              fontFamily: Pretendard_Medium_14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
