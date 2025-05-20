import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import 'package:money_planet/network/TokenStorage.dart';
import 'package:money_planet/presentaion/onboarding/view/guideprofile_screen.dart';

import '../../../application/tabBar/view/tab_screen.dart';
import '../../../network/Login/Response/LoginFailureResponseDTO.dart';
import '../../../network/Login/Response/LoginSuccessResponseDTO.dart';
import '../viewModel/LoginViewModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel viewModel = LoginViewModel();

  @override
  void dispose() {
    viewModel.dispose(); // 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral_900,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: SingleChildScrollView(
          child: ConstrainedBox(
          constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
    ),
    child: IntrinsicHeight(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Center(
              child: Text(
                '로그인',
                style: customTextStyle(
                  fontFamily: Pretendard_Bold_24,
                  color: secondary_050_1,
                ),
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
                      child: Text(
                        '아이디',
                        style: customTextStyle(
                            fontFamily: Pretendard_Medium_14,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: viewModel.usernameController,
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '비밀번호',
                        style: customTextStyle(
                            fontFamily: Pretendard_Medium_14,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: viewModel.passwordController,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('아이디 찾기',
                              style: customTextStyle(
                                  fontFamily: Pretendard_Medium_14,
                                  color: neutral_600)),
                        ),
                        Text('|'),
                        TextButton(
                          onPressed: () {},
                          child: Text('비밀번호 찾기',
                              style: customTextStyle(
                                  fontFamily: Pretendard_Medium_14,
                                  color: neutral_600)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () async {
                          final result = await viewModel.login();

                          if (result is LoginSuccessResponseDTO) {
                            print('로그인 성공: ${result.token}');

                            // 토큰 저장
                            await TokenStorage.saveToken(result.token);

                            // TabScreen으로 전환
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const TabScreen()),
                            );
                          } else if (result is LoginFailureResponseDTO) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('로그인 실패: ${result.message}')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: neutral_300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('로그인',
                            style: customTextStyle(
                                fontFamily: Pretendard_Medium_18,
                                color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const GuideProfileScreen()),
                        );
                      },
                      child: Text(
                        '계정이 없으신가요? 회원가입하기',
                        style: customTextStyle(
                            fontFamily: Pretendard_Medium_14,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
          ),
    ),
    );
  }
}