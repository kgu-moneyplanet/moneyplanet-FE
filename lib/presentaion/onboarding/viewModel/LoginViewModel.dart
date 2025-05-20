import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:money_planet/network/Login/Request/LoginRequestDTO.dart';
import 'package:money_planet/network/Login/Response/LoginFailureResponseDTO.dart';
import 'package:money_planet/network/Login/Response/LoginSuccessResponseDTO.dart';
import 'package:money_planet/network/TokenStorage.dart';

class LoginViewModel {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginRequestDTO get loginRequestDTO => LoginRequestDTO(
    username: usernameController.text,
    password: passwordController.text,
  );

  /// 로그인 API 요청 함수
  Future<dynamic> login() async {
    const url = 'https://money-planet.store/api//login';

    final requestDTO = loginRequestDTO;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': requestDTO.username,
          'password': requestDTO.password,
        }),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return LoginSuccessResponseDTO(
          type: json['type'],
          token: json['token'],
        );
      } else {
        final json = jsonDecode(response.body);
        return LoginFailureResponseDTO(
          statusCode: response.statusCode,
          message: json['message'] ?? '로그인 실패',
        );
      }
    } catch (e) {
      return LoginFailureResponseDTO(
        statusCode: 500,
        message: '서버 오류: ${e.toString()}',
      );
    }
  }

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
  }
}

