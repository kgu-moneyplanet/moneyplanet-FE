import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../network/Chart/Response/WeeklyAnalysisCategoryResponseDTO.dart';

class WeeklyAnalysisCategoryViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  WeeklyCategoryData? weeklyCategoryData;

  Future<void> fetchWeeklyCategory(int year, int weekNum, String jwtToken) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final url = Uri.parse('https://money-planet.store/api/v1/weekly/category/$year/$weekNum');

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

        final weeklyResponse = WeeklyAnalysisCategoryResponse.fromJson(jsonData);

        if (weeklyResponse.statusCode == 200) {
          weeklyCategoryData = weeklyResponse.data;
          print('weeklyCategoryData loaded: ${weeklyCategoryData!.categoryStatDtoList.length} categories');
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