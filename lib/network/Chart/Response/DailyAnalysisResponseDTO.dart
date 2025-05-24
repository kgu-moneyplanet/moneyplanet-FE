class DailyAnalysisResponse {
  final int statusCode;
  final String message;
  final DailyAnalysisData? data;

  DailyAnalysisResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory DailyAnalysisResponse.fromJson(Map<String, dynamic> json) {
    return DailyAnalysisResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? DailyAnalysisData.fromJson(json['data']) : null,
    );
  }
}

class DailyAnalysisData {
  final List<SumStat> sumStatList;
  final String weekday;
  final DateTime day;
  final int totalExpense;
  final int totalIncome;
  final int totalAmount;
  final SumStat? sumStat;
  final CategoryStatList categoryStat;
  final AbcStat abcStat;
  final CateAbcStat cateAbcStat;

  DailyAnalysisData({
    required this.sumStatList,
    required this.weekday,
    required this.day,
    required this.totalExpense,
    required this.totalIncome,
    required this.totalAmount,
    this.sumStat,
    required this.categoryStat,
    required this.abcStat,
    required this.cateAbcStat,
  });

  factory DailyAnalysisData.fromJson(Map<String, dynamic> json) {
    return DailyAnalysisData(
      sumStatList: (json['sumStatList'] as List<dynamic>? ?? [])
          .map((e) => SumStat.fromJson(e))
          .toList(),
      weekday: json['weekday'] ?? '',
      day: _parseDate(json['day']),
      totalExpense: json['totalExpense'] ?? 0,
      totalIncome: json['totalIncome'] ?? 0,
      totalAmount: json['totalAmount'] ?? 0,
      sumStat: json['sumStat'] != null ? SumStat.fromJson(json['sumStat']) : null,
      categoryStat: json['categoryStat'] != null
          ? CategoryStatList.fromJson(json['categoryStat'])
          : CategoryStatList(categoryStatDtoList: [], totalAmount: 0),
      abcStat: json['abcStat'] != null
          ? AbcStat.fromJson(json['abcStat'])
          : AbcStat(totalA: 0, totalB: 0, totalC: 0),
      cateAbcStat: json['cateAbcStat'] != null
          ? CateAbcStat.fromJson(json['cateAbcStat'])
          : CateAbcStat(cateAbcStatDtoList: [], totalAmount: 0),
    );
  }

  static DateTime _parseDate(dynamic date) {
    if (date == null) return DateTime.now();
    try {
      return DateTime.parse(date.toString());
    } catch (_) {
      return DateTime.now();
    }
  }
}

class SumStat {
  final DateTime day;
  final String weekday;
  final int totalExpense;
  final int totalIncome;
  final int totalAmount;

  SumStat({
    required this.day,
    required this.weekday,
    required this.totalExpense,
    required this.totalIncome,
    required this.totalAmount,
  });

  factory SumStat.fromJson(Map<String, dynamic> json) {
    return SumStat(
      day: DailyAnalysisData._parseDate(json['day']),
      weekday: json['weekday'] ?? '',
      totalExpense: json['totalExpense'] ?? 0,
      totalIncome: json['totalIncome'] ?? 0,
      totalAmount: json['totalAmount'] ?? 0,
    );
  }
}

class CategoryStatList {
  final List<CategoryStat> categoryStatDtoList;
  final int totalAmount;

  CategoryStatList({
    required this.categoryStatDtoList,
    required this.totalAmount,
  });

  factory CategoryStatList.fromJson(Map<String, dynamic> json) {
    return CategoryStatList(
      categoryStatDtoList: (json['categoryStatDtoList'] as List<dynamic>? ?? [])
          .map((e) => CategoryStat.fromJson(e))
          .toList(),
      totalAmount: json['totalAmount'] ?? 0,
    );
  }
}

class CategoryStat {
  final int categoryId;
  final String categoryName;
  final int amount;

  CategoryStat({
    required this.categoryId,
    required this.categoryName,
    required this.amount,
  });

  factory CategoryStat.fromJson(Map<String, dynamic> json) {
    return CategoryStat(
      categoryId: json['categoryId'] ?? 0,
      categoryName: json['categoryName'] ?? '',
      amount: json['amount'] ?? 0,
    );
  }
}

class AbcStat {
  final int totalA;
  final int totalB;
  final int totalC;

  AbcStat({
    required this.totalA,
    required this.totalB,
    required this.totalC,
  });

  factory AbcStat.fromJson(Map<String, dynamic> json) {
    return AbcStat(
      totalA: json['totalA'] ?? 0,
      totalB: json['totalB'] ?? 0,
      totalC: json['totalC'] ?? 0,
    );
  }
}

class CateAbcStat {
  final List<CateAbcStatDto> cateAbcStatDtoList;
  final int totalAmount;

  CateAbcStat({
    required this.cateAbcStatDtoList,
    required this.totalAmount,
  });

  factory CateAbcStat.fromJson(Map<String, dynamic> json) {
    return CateAbcStat(
      cateAbcStatDtoList: (json['cateAbcStatDtoList'] as List<dynamic>? ?? [])
          .map((e) => CateAbcStatDto.fromJson(e))
          .toList(),
      totalAmount: json['totalAmount'] ?? 0,
    );
  }
}

enum AbcType { A, B, C }

AbcType abcTypeFromString(String? s) {
  switch (s) {
    case 'A':
      return AbcType.A;
    case 'B':
      return AbcType.B;
    case 'C':
      return AbcType.C;
    default:
      return AbcType.A; // 기본값 A로 설정
  }
}

class CateAbcStatDto {
  final int categoryId;
  final String categoryName;
  final AbcType abc;
  final int amount;

  CateAbcStatDto({
    required this.categoryId,
    required this.categoryName,
    required this.abc,
    required this.amount,
  });

  factory CateAbcStatDto.fromJson(Map<String, dynamic> json) {
    return CateAbcStatDto(
      categoryId: json['categoryId'] ?? 0,
      categoryName: json['categoryName'] ?? '',
      abc: abcTypeFromString(json['abc']),
      amount: json['amount'] ?? 0,
    );
  }
}