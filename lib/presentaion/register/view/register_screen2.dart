import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';

import '../../../global/theme/textStyles.dart';
import 'guidetype_screen.dart';
import 'login_screen.dart';

class RegisterScreen2 extends StatelessWidget {
  const RegisterScreen2({super.key});

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
                '회원 가입',
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('비밀번호', style: customTextStyle(fontFamily: Pretendard_Medium_14,color: Colors.black)),
                    ),
                    const SizedBox(height: 6),
                    TextField(
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
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('비밀번호 확인',
                          style: customTextStyle(fontFamily: Pretendard_Medium_14,color: Colors.black)),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '비밀번호를 다시 입력해 주세요',
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
                    const SizedBox(height: 240),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const GuideTypeScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: neutral_300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('다음',
                            style: customTextStyle(fontFamily: Pretendard_Medium_18,color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        '이미 계정이 있으신가요? 로그인하기',
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
