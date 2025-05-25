import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../network/Chart/Response/WeeklyAnalysisResponseDTO.dart';


class WeeklyAnalysisViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  WeeklyAnalysisData? weeklyData;

  Future<void> fetchWeeklyAnalysis(int year, int weekNum, String jwtToken) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final url = Uri.parse('https://money-planet.store/api/v1/weekly/summary/$year/$weekNum');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final weeklyResponse = WeeklyAnalysisResponse.fromJson(jsonData);

        if (weeklyResponse.statusCode == 200 && weeklyResponse.data != null) {
          weeklyData = weeklyResponse.data;
         /* print('abcStat totalA: ${weeklyData?.abcStat.totalA}');
          print('abcStat totalB: ${weeklyData?.abcStat.totalB}');
          print('abcStat totalC: ${weeklyData?.abcStat.totalC}');*/
        } else {
          errorMessage = weeklyResponse.message;
        }
      } else {
        errorMessage = '서버 에러: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage = '오류 발생: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}