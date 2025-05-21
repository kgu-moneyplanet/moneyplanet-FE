import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../network/Signup/Request/SignUpRequestDTO.dart';
import '../../../network/Signup/Response/SignUpFailureResponseDTO.dart';




class SignUpViewModel {
  // 화면1
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cellphoneController = TextEditingController();
  final birthController = TextEditingController(); // YYYY-MM-DD

  // 화면2
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final jobController = TextEditingController();
  String? gender;   // 'M' or 'F'

  // 설문
  String? prefer;   // q13 텍스트
  String? planet;   // MBTI → Planet

  SignUpRequestDTO get dto => SignUpRequestDTO(
    username: usernameController.text.trim(),
    name: nameController.text.trim(),
    email: emailController.text.trim(),
    cellphone: cellphoneController.text.trim(),
    birth: birthController.text.trim(),
    password: passwordController.text.trim(),
    gender: gender ?? 'M',
    job: jobController.text.trim(),
    prefer: prefer ?? '',
    planet: planet ?? 'EARTH',
  );

  Future<SignUpFailureResponseDTO?> signUp() async {
    const url = 'https://money-planet.store/api/v1/user';
    try {
      final res = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dto.toJson()),
      );
      if (res.statusCode == 201) {
        return null;
      } else {
        final j = jsonDecode(res.body);
        return SignUpFailureResponseDTO(
          statusCode: res.statusCode,
          message: j['message'] ?? '회원가입 실패',
        );
      }
    } catch (e) {
      return SignUpFailureResponseDTO(
        statusCode: 500,
        message: '서버 오류: $e',
      );
    }
  }

  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    emailController.dispose();
    cellphoneController.dispose();
    birthController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    jobController.dispose();
  }
}