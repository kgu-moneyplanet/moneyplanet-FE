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
                'assets/images/rocket3.png', // 행성 아이콘 작은 이미지
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
                onPressed: () => showDeleteDialog(context),
                child: Text(
                  '회원 탈퇴',
                  style: customTextStyle(
                    fontFamily: Pretendard_Medium_16,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () => showLogoutDialog(context),
                child: Text(
                  '로그아웃',
                  style: customTextStyle(
                    fontFamily: Pretendard_Medium_16,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: EdgeInsets.all(30),
            width: 308,
            height: 183,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '로그아웃하시겠습니까?',
                  style: customTextStyle(
                    fontFamily: Pretendard_Semibold_16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '로그아웃해도 정보가 사라지지 않습니다.',
                  style: customTextStyle(
                    fontFamily: Pretendard_Medium_12,
                    color: neutral_400,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: neutral_200),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          // 로그아웃 처리 로직 삽입
                          print("로그아웃 실행");
                        },
                        child: Text(
                          '네',
                          style: customTextStyle(
                            fontFamily: Pretendard_Medium_14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: neutral_400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                        },
                        child: Text(
                          '아니요',
                          style: customTextStyle(
                            fontFamily: Pretendard_Medium_14,
                            color: Colors.white,
                          ),
                        ),
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
  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: EdgeInsets.all(30),
            width: 308,
            height: 183,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '회원탈퇴하시겠습니까?',
                  style: customTextStyle(
                    fontFamily: Pretendard_Semibold_16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '정말 탈퇴하시겠습니까?',
                  style: customTextStyle(
                    fontFamily: Pretendard_Medium_12,
                    color: neutral_400,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: neutral_200),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          // 탈퇴 처리 로직 삽입
                          print("탈퇴 실행");
                        },
                        child: Text(
                          '네',
                          style: customTextStyle(
                            fontFamily: Pretendard_Medium_14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: neutral_400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                        },
                        child: Text(
                          '아니요',
                          style: customTextStyle(
                            fontFamily: Pretendard_Medium_14,
                            color: Colors.white,
                          ),
                        ),
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
