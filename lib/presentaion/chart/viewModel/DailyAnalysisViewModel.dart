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
  AbcStat? _abcStat;


  List<SumStat>? get dailyData => _dailyData;
  SumStat? get sumStat => _sumStat;  // getter 추가
  bool get isLoading => _isLoading;
  String? get error => _error;
  AbcStat? get abcStat => _abcStat;

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

      if (response.statusCode == 200) {
        final responseDTO = DailyAnalysisResponse.fromJson(json.decode(response.body));

        if (responseDTO.statusCode == 200 && responseDTO.data != null) {
          _dailyData = responseDTO.data!.sumStatList;
          _sumStat = responseDTO.data!.sumStat;
          _abcStat = responseDTO.data!.abcStat;
        } else {
          _error = responseDTO.message;
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
      notifyListeners();
    }
  }
}