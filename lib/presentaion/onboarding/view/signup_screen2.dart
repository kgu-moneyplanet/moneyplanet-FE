import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/presentaion/onboarding/view/question_screen.dart';

import '../../../global/theme/textStyles.dart';
import '../../onboarding/view/guidetype_screen.dart';
import 'login_screen.dart';

class SignUpScreen2 extends StatefulWidget {
  const SignUpScreen2({super.key});

  @override
  State<SignUpScreen2> createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  String? _selectedGender;

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
                    _buildLabel('비밀번호'),
                    _buildInputField('비밀번호를 입력해주세요', obscure: true),
                    _buildLabel('비밀번호 확인'),
                    _buildInputField('비밀번호를 다시 입력해 주세요', obscure: true),
                    _buildLabel('직업'),
                    _buildInputField('직업을 입력해 주세요'),
                    _buildLabel('성별'),
                    const SizedBox(height: 6),
                    Row(
                      children: ['남성', '여성'].map((gender) {
                        final isSelected = _selectedGender == gender;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedGender = gender;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: isSelected ? primary_200 : primary_400,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  gender,
                                  style: customTextStyle(
                                    fontFamily: Pretendard_Medium_18,
                                    color: isSelected ? Colors.white : Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                    _buildPrimaryButton(context, '다음', const QuestionScreen()),
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

  Widget _buildInputField(String hintText, {bool obscure = false}) => TextField(
    obscureText: obscure,
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