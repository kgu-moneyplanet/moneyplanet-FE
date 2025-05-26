import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../network/Chart/Response/DailyAnalysisCategoryDTO.dart';


class DailyAnalysisCategoryViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  DailyCategoryData? dailyCategoryData;

  Future<void> fetchDailyCategory(DateTime date, String jwtToken) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final statDate = '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    final url = Uri.parse('https://money-planet.store/api/v1/daily/category/$statDate');

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

        final dailyResponse = DailyAnalysisCategoryResponse.fromJson(jsonData);

        if (dailyResponse.statusCode == 200) {
          dailyCategoryData = dailyResponse.data;
          print('dailyCategoryData loaded: ${dailyCategoryData!.categoryStatDtoList.length} categories');
        } else {
          errorMessage = dailyResponse.message;
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
