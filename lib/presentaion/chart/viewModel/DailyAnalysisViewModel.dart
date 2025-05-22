import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../network/Dailychart/Response/DailyAnalysisResponseDTO.dart';

class DailyAnalysisViewModel extends ChangeNotifier {
  DailyAnalysisData? _data;
  bool _isLoading = false;
  String? _errorMessage;

  DailyAnalysisData? get data => _data;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final String baseUrl = 'https://money-planet.store/api/v1/daily/summary';

  Future<void> fetchDailyAnalysis(DateTime txDate, String jwtToken) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final dateStr = txDate.toIso8601String().split('T')[0]; // yyyy-MM-dd 형태만 사용
      final response = await http.get(
        Uri.parse('$baseUrl/$dateStr'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _data = DailyAnalysisResponseDTO.fromJson(jsonData).data;
      } else {
        _errorMessage = json.decode(response.body)['message'] ??
            '데이터 로딩 실패 (status ${response.statusCode})';
      }
    } catch (e) {
      _errorMessage = '데이터 로딩 중 오류 발생: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _data = null;
    _errorMessage = null;
    notifyListeners();
  }
}