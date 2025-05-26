import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../network/Chart/Response/DailyAnalysisABCResponseDTO.dart';
import '../../../network/TokenStorage.dart';


class DailyABCAnalysisViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  AbcStat? _abcStat;

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

    final url = Uri.parse('https://money-planet.store/api/v1/daily/abc/$statDate');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(utf8.decode(response.bodyBytes));
        final dto = DailyAbcStatResponseDTO.fromJson(jsonMap);
        if (dto.statusCode == 200 && dto.data != null) {
          _abcStat = dto.data; // 바로 할당 가능
        } else {
          _error = dto.message;
          print('ABC NULL: ${dto.message}');
        }
      } else {
        _error = 'HTTP Error: ${response.statusCode}';
        print(_error);
      }
    } catch (e) {
      _error = '에러 발생: $e';
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}