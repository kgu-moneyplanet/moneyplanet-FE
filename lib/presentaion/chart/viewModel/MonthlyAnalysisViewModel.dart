import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:money_planet/network/Chart/Response/MonthlyAnalysisResponseDTO.dart';

class MonthlyAnalysisViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  MonthlyAnalysisData? monthlyData;

  Future<void> fetchMonthlyAnalysis(int year, int month, String jwtToken) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final url = Uri.parse('https://money-planet.store/api/v1/monthly/summary/$year/$month');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(response.bodyBytes));

        final monthlyResponse = MonthlyAnalysisResponse.fromJson(jsonData);

        if (monthlyResponse.statusCode == 200 && monthlyResponse.data != null) {
          monthlyData = monthlyResponse.data;
         print('abcStat totalA: ${monthlyData?.abcStat.totalA}');
          print('abcStat totalB: ${monthlyData?.abcStat.totalB}');
          print('abcStat totalC: ${monthlyData?.abcStat.totalC}');
          errorMessage = null;
        } else {
          errorMessage = monthlyResponse.message;
          monthlyData = null;
        }
      } else if (response.statusCode == 401) {
        errorMessage = '유효하지 않은 토큰입니다. 다시 로그인 해주세요..';
        monthlyData = null;
      } else if (response.statusCode == 404) {
        errorMessage = '사용자를 찾을 수 없습니다.';
        monthlyData = null;
      } else if (response.statusCode == 400) {
        errorMessage = '잘못된 요청입니다.';
        monthlyData = null;
      } else {
        errorMessage = '서버 오류가 발생했습니다. 코드: ${response.statusCode}';
        monthlyData = null;
      }
    } catch (e) {
      errorMessage = '오류가 발생했습니다: $e';
      monthlyData = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}