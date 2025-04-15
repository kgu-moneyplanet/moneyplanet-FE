import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';

class MyPageThirdSection extends StatelessWidget {
  const MyPageThirdSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'lib/global/assets/images/rocket3.png', // 행성 아이콘 작은 이미지
                width: 27,
                height: 28,
              ),
              const SizedBox(width: 8),
              Text(
                "최신 피드백 모아보기",
                style: customTextStyle(
                  fontFamily: Pretendard_Medium_18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 172,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Text('회원 탈퇴',
                    style: customTextStyle(fontFamily: Pretendard_Medium_16,color: Colors.white)),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Text('로그아웃',
                    style: customTextStyle(fontFamily: Pretendard_Medium_16,color: Colors.white)),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}