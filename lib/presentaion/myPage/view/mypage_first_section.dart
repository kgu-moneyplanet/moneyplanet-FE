import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import 'package:money_planet/presentaion/myPage/view/hint_screen.dart';

import '../../../global/planet_list.dart';
import '../../../network/Mypage/Response/MyPageResponseDTO.dart';
import '../../onboarding/view/question_screen.dart';
import '../viewModel/MypageViewModel.dart';


class MypageFirstSection extends StatelessWidget {
  final MyPageResponseDTO user;
  final PlanetModel planet;

  const MypageFirstSection({
    super.key,
    required this.user,
    required this.planet,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyPageResponseDTO?>(
      future: fetchMyPageData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('유저 정보를 불러올 수 없습니다.'));
        }

        final user = snapshot.data!;
        final planet = planetList.firstWhere(
              (p) => p.apiValue == user.planet,
          orElse: () => planetList[0],
        );

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
                    "마이페이지",
                    style: customTextStyle(
                      fontFamily: Pretendard_Bold_28,
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
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HintScreen()),
                    );
                    print("tapped help");
                    },
                    icon: Image.asset('assets/images/icons/help_circle.png'),
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
                Container(
                  width: 190,
                  height: 190,
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
                Image.asset(
                  planet.imageURL,
                  width: 190,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ],
            ),

            SizedBox(height: 10),

            // 이름 + 편집 아이콘 부분
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.name,
                  style: customTextStyle(
                    fontFamily: Pretendard_Bold_24,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primary_400,
                        boxShadow: [
                          BoxShadow(
                            color: secondary_100_1,
                            blurRadius: 70,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        print('닉네임 편집');
                      },
                      icon: Image.asset(
                        'assets/images/icons/pencil_line.png',
                        width: 13,
                        height: 13,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // 아이디
            Text(
              user.username,
              style: customTextStyle(
                fontFamily: Pretendard_Medium_16,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 20),


            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 48),
              child: GestureDetector(
                onTap: () {
                  // 재검사하기 눌렀을 때 동작
                },
                child: Container(
                  width: 343,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [secondary_100_1, secondary_100_2],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "소비 성향 재검사하기",
                    style: customTextStyle(
                      fontFamily: Pretendard_Medium_18,
                      color: neutral_900,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}