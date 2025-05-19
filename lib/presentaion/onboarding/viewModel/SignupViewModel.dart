import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:money_planet/network/Login/Request/SignUpRequestDTO.dart';
import 'package:money_planet/network/Login/Response/SignUpFailureResponseDTO.dart';

class SignUpViewModel {
  // 입력값들
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cellphoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  // 선택값
  String? gender; // 'M' or 'F'
  String? prefer; // 설문 결과
  String? planet;

  SignUpRequestDTO get signUpRequestDTO => SignUpRequestDTO(
    username: usernameController.text,
    name: nameController.text,
    cellphone: cellphoneController.text,
    email: emailController.text,
    password: passwordController.text,
    birth: birthController.text,
    gender: gender ?? 'M',
    job: jobController.text,
    prefer: prefer ?? '',
    planet: planet ?? 'EARTH',
  );

  /// 회원가입 API 요청
  Future<dynamic> signUp() async {
    const url = 'http://www.money-planet.store:8080/v1/user';

    final requestDTO = signUpRequestDTO;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestDTO.toJson()),
      );

      if (response.statusCode == 201) {
        return null; // 성공: 에러 없음
      } else {
        final json = jsonDecode(response.body);
        return SignUpFailureResponseDTO(
          statusCode: response.statusCode,
          message: json['message'] ?? '회원가입 실패',
        );
      }
    } catch (e) {
      return SignUpFailureResponseDTO(
        statusCode: 500,
        message: '서버 오류: ${e.toString()}',
      );
    }
  }

  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    cellphoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    birthController.dispose();
    jobController.dispose();
  }
}