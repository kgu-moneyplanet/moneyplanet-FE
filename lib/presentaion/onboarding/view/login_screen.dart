import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import 'package:money_planet/presentaion/onboarding/view/guideprofile_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: neutral_900,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Center(
              child: Text(
                '로그인',
                style: customTextStyle(fontFamily: Pretendard_Bold_24,color: secondary_050_1)
              ),
            ),
            const SizedBox(height: 60),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: primary_050,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 아이디 입력
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('아이디',
                          style: customTextStyle(fontFamily: Pretendard_Medium_14, color:Colors.black)),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '아이디를 입력해주세요',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // 비밀번호 입력
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('비밀번호',
                          style: customTextStyle(fontFamily: Pretendard_Medium_14, color:Colors.black)),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '비밀번호를 입력해주세요',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // 아이디/비밀번호 찾기
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('아이디 찾기',
                              style: customTextStyle(fontFamily: Pretendard_Medium_14,color: neutral_600)),
                        ),
                        Text('|'),
                        TextButton(
                          onPressed: () {},
                          child: Text('비밀번호 찾기',
                              style: customTextStyle(fontFamily: Pretendard_Medium_14,color: neutral_600)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // 로그인 버튼
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: neutral_300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('로그인',
                            style: customTextStyle(fontFamily: Pretendard_Medium_18,color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // 회원가입
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GuideProfileScreen()),
                      );
                      },
                      child: Text(
                        '계정이 없으신가요? 회원가입하기',
                        style: customTextStyle(fontFamily: Pretendard_Medium_14,color: Colors.black),
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
