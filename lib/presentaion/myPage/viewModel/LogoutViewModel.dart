import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../network/TokenStorage.dart';

class LogoutViewModel with ChangeNotifier {
  Future<bool> logout() async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      print('토큰 없음');
      return false;
    }

    final url = Uri.parse('http://www.money-planet.store:8080/log-out'); // 실제 URL 사용

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("응답 코드: ${response.statusCode}");
      print("응답 본문: ${response.body}");

      if (response.statusCode == 200) {
        await TokenStorage.clearToken();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("로그아웃 에러: $e");
      return false;
    }
  }
}