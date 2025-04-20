import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/diary_model.dart';

class DiaryViewModel {
  int selectedMonth = DateTime.now().month;
  String selectedView = 'Daily';

  // 날짜별로 그룹핑한 Map 생성 함수
  Map<String, List<DiaryModel>> groupByDate(List<DiaryModel> data) {
    Map<String, List<DiaryModel>> grouped = {};

    for (var item in data) {
      final dateKey = DateFormat('yyyy-MM-dd').format(item.date);
      grouped.putIfAbsent(dateKey, () => []).add(item);
    }

    // 최신 날짜가 위에 오도록 정렬
    final sortedEntries =
    grouped.entries.toList()..sort((a, b) => b.key.compareTo(a.key));

    return Map.fromEntries(sortedEntries);
  }



}