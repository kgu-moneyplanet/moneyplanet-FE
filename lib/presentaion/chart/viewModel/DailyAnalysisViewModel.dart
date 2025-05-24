import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../network/Chart/Response/DailyAnalysisResponseDTO.dart';
import '../../../network/TokenStorage.dart';


class DailyAnalysisViewModel extends ChangeNotifier {
  List<SumStat>? _dailyData;
  SumStat? _sumStat;           // 오늘 수입/지출 합계 추가
  bool _isLoading = false;
  String? _error;

  List<SumStat>? get dailyData => _dailyData;
  SumStat? get sumStat => _sumStat;  // getter 추가
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchDailyData(String statDate) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final jwtToken = await TokenStorage.getToken();
    if (jwtToken == null) {
      _error = '로그인 정보가 없습니다. 다시 로그인 해주세요.';
      _isLoading = false;
      notifyListeners();
      return;
    }

    final url = Uri.parse('https://money-planet.store/api/v1/daily/summary/$statDate');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // statusCode, message 사용으로 변경
        if (jsonData['statusCode'] == 200 && jsonData['data'] != null) {
          final data = jsonData['data'];
          final List<dynamic>? sumStatList = data['sumStatList'];

          if (sumStatList != null && sumStatList is List) {
            _dailyData = sumStatList.map<SumStat>((item) => SumStat.fromJson(item)).toList();
          } else {
            _dailyData = [];
          }

          _sumStat = data['sumStat'] != null
              ? SumStat.fromJson(data['sumStat'])
              : null;
        } else {
          _error = jsonData['message'] ?? '데이터가 없습니다.';
        }

      } else if (response.statusCode == 401) {
        _error = '로그인 정보가 만료되었습니다. 다시 로그인 해주세요.';
        await TokenStorage.clearToken();
      } else {
        _error = '서버 에러: ${response.statusCode}';
      }

    } catch (e) {
      _error = '에러 발생: $e';
    } finally {
      _isLoading = false;
      print('fetchDailyData finished. dailyData: $_dailyData, sumStat: $_sumStat, error: $_error');
      notifyListeners();
    }
  }
}