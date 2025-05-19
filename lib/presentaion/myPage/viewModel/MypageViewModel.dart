import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../network/Mypage/Response/MyPageResponseDTO.dart';
import '../../../network/TokenStorage.dart';

Future<MyPageResponseDTO?> fetchMyPageData() async {
  final url = Uri.parse('http://www.money-planet.store:8080/v1/user');
  final token = await TokenStorage.getToken();

  if (token == null) {
    print('토큰이 없습니다.');
    return null;
  }

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('응답 코드: ${response.statusCode}');
    print('응답 본문: ${response.body}');

    final jsonData = json.decode(response.body);

    if (response.statusCode == 200) {
      if (jsonData['data'] == null) {
        print('data가 null 입니다.');
        return null;
      }
      return MyPageResponseDTO.fromJson(jsonData['data']);
    } else {
      print('에러: ${jsonData['message']}');
      return null;
    }
  } catch (e) {
    print('Exception: $e');
    return null;
  }
}