import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:money_planet/network/TokenStorage.dart';
import 'package:money_planet/network/User/Response/UserInfoResponseDTO.dart';

import '../../../global/planet_list.dart';
import '../../../network/Daily/Response/DailyCategoryResponseDTO.dart';
import '../../../network/Daily/Response/LWTWResponseDTO.dart';

class HomeViewModel {
  /// 유저 정보 API GET 요청 함수
  Future<dynamic> getUserInfo() async {
    const url = 'https://money-planet.store/api//v1/user';

    try {
      final token = await TokenStorage.getToken();

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      final decodedBody = utf8.decode(response.bodyBytes);
      final json = jsonDecode(decodedBody);

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

  /// 이번주 저번주 지출 비교 API GET 요청 함수
  Future<LWTWResponseDTO?> fetchLWTWComparison({required int year, required int weekNum,}) async {

    final url = 'https://money-planet.store/api//v1/weekly/lwtw/$year/$weekNum';

    try {
      final token = await TokenStorage.getToken();

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(decodedBody);
        return LWTWResponseDTO(
          statusCode: jsonData['statusCode'],
          message: jsonData['message'],
          data: LWTWResponseData(
            lastWeekCategoryName: jsonData['data']['lastWeekCategoryName'],
            lastWeekCategoryAmount: jsonData['data']['lastWeekCategoryAmount'],
            thisWeekCategoryName: jsonData['data']['thisWeekCategoryName'],
            thisWeekCategoryAmount: jsonData['data']['thisWeekCategoryAmount'],
            diffAmount: jsonData['data']['diffAmount'],
          ),
        );
      } else {
        print('Failed to load comparison data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching comparison data: $e');
      return null;
    }
  }

  /// 일일 총 지출 금액 조회(카테고리별)
  /// url은 https://money-planet.store/api//v1/daily/category/$statDate
  Future<DailyCategoryResponseDTO?> fetchDailyCategoryStats(String statDate) async {
    final token = await TokenStorage.getToken();
    //TODO: - 여기 변경
    final url = Uri.parse("https://money-planet.store/api//v1/daily/category/2025-05-16");
    // final url = Uri.parse("https://money-planet.store/api//v1/daily/category/$statDate");
    print('🌐 GET $url');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(decodedBody);

      debugPrint("🌐 Response Status Code: ${response.statusCode}");
      debugPrint("📦 Response Body: ${jsonData}");

      return DailyCategoryResponseDTO.fromJson(jsonData);
    } else {
      print("Failed to fetch daily category stats: ${response.statusCode}");
      return null;
    }
  }

  /// 주간 총 지출 금액 조회(카테고리별)
  /// url: https://money-planet.store/api//v1/weekly/category/{year}/{weekNum}
  Future<DailyCategoryResponseDTO?> fetchWeeklyCategoryStats(int year, int weekNum) async {
    final token = await TokenStorage.getToken();
    final url = Uri.parse("https://money-planet.store/api//v1/weekly/category/$year/$weekNum");
    print('🌐 GET $url');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(decodedBody);

      debugPrint("✅ Weekly Stats: $jsonData");

      return DailyCategoryResponseDTO.fromJson(jsonData);
    } else {
      print("Failed to fetch weekly category stats: ${response.statusCode}");
      return null;
    }
  }

  /// 월별 총 지출 금액 조회(카테고리별)
  /// url: https://money-planet.store/api//v1/monthly/category/{year}/{month}
  Future<DailyCategoryResponseDTO?> fetchMonthlyCategoryStats(int year, int month) async {
    final token = await TokenStorage.getToken();
    final url = Uri.parse("https://money-planet.store/api//v1/monthly/category/$year/$month");
    print('🌐 GET $url');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(decodedBody);

      debugPrint("✅ Monthly Stats: $jsonData");

      return DailyCategoryResponseDTO.fromJson(jsonData);
    } else {
      print("Failed to fetch monthly category stats: ${response.statusCode}");
      return null;
    }
  }

}
