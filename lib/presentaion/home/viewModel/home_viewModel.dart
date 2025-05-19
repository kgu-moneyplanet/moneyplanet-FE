import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:money_planet/network/TokenStorage.dart';
import 'package:money_planet/network/User/Response/UserInfoResponseDTO.dart';

import '../../../global/planet_list.dart';

class HomeViewModel {
  /// 유저 정보 API GET 요청 함수
  Future<dynamic> getUserInfo() async {
    const url = 'http://www.money-planet.store:8080/v1/user';

    try {
      final token = await TokenStorage.getToken();

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return UserInfoResponseDTO(
          statusCode: response.statusCode,
          message: json['message'],
          UserInfoData: UserInfoData(
            username: json['data']['username'],
            name: json['data']['name'],
            cellphone: json['data']['cellphone'],
            email: json['data']['email'],
            planet: json['data']['planet'],
            totalIncome: json['data']['totalIncome'],
            totalExpense: json['data']['totalExpense'],
            birth: json['data']['birth'],
            gender: json['data']['gender'],
            job: json['data']['job'],
            target: json['data']['target'],
            achieved: json['data']['achieved'],
            prefer: json['data']['prefer'],
          ),
        );
      } else {
        return UserInfoResponseDTO(
          statusCode: response.statusCode,
          message: json['message'] ?? '유저 정보 받아오기 실패',
          UserInfoData: null,
        );
      }
    } catch (e) {
      return UserInfoResponseDTO(
        statusCode: 500,
        message: '서버 오류: ${e.toString()}',
        UserInfoData: null,
      );
    }
  }




  PlanetModel? getPlanetModelByCode(String? code) {
    if (code == null) return null;
    return planetList.firstWhere(
          (planet) => planet.code == code,
      orElse: () => planetList[0],
    );
  }

  Future<(UserInfoData?, PlanetModel?)> getUserInfoWithPlanet() async {
    final result = await getUserInfo();

    if (result is UserInfoResponseDTO && result.UserInfoData != null) {
      final user = result.UserInfoData!;
      final planet = getPlanetModelByCode(user.planet);
      return (user as UserInfoData?, planet as PlanetModel?);
    }
    return (null, null);
  }
}
