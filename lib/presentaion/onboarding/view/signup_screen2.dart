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
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Center(
              child: Text(
                '회원 가입',
                style: customTextStyle(fontFamily: Pretendard_Bold_24, color: secondary_050_1),
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
                        child: Text('비밀번호',
                            style: customTextStyle(fontFamily: Pretendard_Medium_14, color: Colors.black)),
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
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('비밀번호 확인',
                            style: customTextStyle(fontFamily: Pretendard_Medium_14, color: Colors.black)),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '비밀번호를 다시 입력해 주세요',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('직업',
                            style: customTextStyle(fontFamily: Pretendard_Medium_14, color: Colors.black)),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '직업을 입력해 주세요',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('성별',
                            style: customTextStyle(fontFamily: Pretendard_Medium_14, color: Colors.black)),
                      ),
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
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const QuestionScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: neutral_300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text('다음',
                              style: customTextStyle(fontFamily: Pretendard_Medium_18, color: Colors.white)),
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
                          style: customTextStyle(fontFamily: Pretendard_Medium_14, color: Colors.black),
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