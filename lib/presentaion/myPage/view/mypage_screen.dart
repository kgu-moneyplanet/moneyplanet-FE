import 'package:flutter/material.dart';
import 'package:money_planet/presentaion/myPage/view/mypage_first_section.dart';
import 'package:money_planet/presentaion/myPage/view/mypage_second_section.dart';
import 'package:money_planet/presentaion/myPage/view/mypage_third_section.dart';

import '../../../global/planet_list.dart';
import '../../../global/theme/colors.dart';
import '../../../network/Mypage/Response/MyPageResponseDTO.dart';
import '../viewModel/MypageViewModel.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: neutral_900,
        body: SafeArea(
          child: FutureBuilder<MyPageResponseDTO?>(
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

              return SingleChildScrollView(
                child: Column(
                  children: [
                    MypageFirstSection(user: user, planet: planet),
                    const SizedBox(height: 10),
                    MyPageSecondSection(planet: planet),
                    const SizedBox(height: 10),
                    const MyPageThirdSection(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
