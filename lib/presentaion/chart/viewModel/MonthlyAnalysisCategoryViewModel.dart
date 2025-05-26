import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../network/Chart/Response/MonthlyAnalysisCategoryResponseDTO.dart';

class MonthlyAnalysisCategoryViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  MonthlyCategoryData? monthlyCategoryData;

  Future<void> fetchMonthlyCategory(int year, int month, String jwtToken) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final url = Uri.parse('https://money-planet.store/api/v1/monthly/category/$year/$month');

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

        final monthlyResponse = MonthlyAnalysisCategoryResponse.fromJson(jsonData);

        if (monthlyResponse.statusCode == 200) {
          monthlyCategoryData = monthlyResponse.data;
          print('monthlyCategoryData loaded: ${monthlyCategoryData!.categoryStatDtoList.length} categories');
        } else {
          errorMessage = monthlyResponse.message;
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