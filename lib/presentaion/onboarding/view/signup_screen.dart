import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import 'package:money_planet/presentaion/onboarding/view/signup_screen2.dart';

import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral_900,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Center(
                child: Text(
                  '회원 가입',
                  style: customTextStyle(
                      fontFamily: Pretendard_Bold_24, color: secondary_050_1),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                decoration: BoxDecoration(
                  color: primary_050,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('아이디'),
                    _buildInputField('아이디를 입력해주세요',),
                    _buildLabel('이름'),
                    _buildInputField('이름을 입력해주세요',),
                    _buildLabel('이메일'),
                    _buildInputField('example@example.com',),
                    _buildLabel('전화번호'),
                    _buildInputField('+123 456 789',),
                    _buildLabel('생일'),
                    _buildInputField('YYYY-MM-DD',),
                    const SizedBox(height: 32),
                    _buildPrimaryButton(context, '다음', const SignUpScreen2()),
                    const SizedBox(height: 16),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const LoginScreen()));
                        },
                        child: Text(
                          '이미 계정이 있으신가요? 로그인하기',
                          style: customTextStyle(
                              fontFamily: Pretendard_Medium_14, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(top: 16.0, bottom: 6),
    child: Text(
      text,
      style: customTextStyle(
          fontFamily: Pretendard_Medium_14, color: Colors.black),
    ),
  );

  Widget _buildInputField(String hintText) => TextField(
    decoration: InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );

  Widget _buildPrimaryButton(BuildContext context, String label, Widget nextScreen) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => nextScreen));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: neutral_300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(label,
            style: customTextStyle(
                fontFamily: Pretendard_Medium_18, color: Colors.white)),
      ),
    );
  }
}