class MonthlyAnalysisResponse {
  final int statusCode;
  final String message;
  final MonthlyAnalysisData? data;

  MonthlyAnalysisResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory MonthlyAnalysisResponse.fromJson(Map<String, dynamic> json) {
    return MonthlyAnalysisResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? MonthlyAnalysisData.fromJson(json['data']) : null,
    );
  }

  @override
  String toString() => 'MonthlyAnalysisResponse(statusCode: $statusCode, message: $message, data: $data)';
}

class MonthlyAnalysisData {
  final List<MonthlySumStat> sumStatList;
  final int year;
  final int month;
  final int totalExpense;
  final int totalIncome;
  final int totalAmount;
  final MonthlySumStat? sumStat;
  final MonthlyCategoryStatList categoryStat;
  final MonthlyAbcStat abcStat;
  final MonthlyCateAbcStat cateAbcStat;

  MonthlyAnalysisData({
    required this.sumStatList,
    required this.year,
    required this.month,
    required this.totalExpense,
    required this.totalIncome,
    required this.totalAmount,
    this.sumStat,
    required this.categoryStat,
    required this.abcStat,
    required this.cateAbcStat,
  });

  factory MonthlyAnalysisData.fromJson(Map<String, dynamic> json) {
    return MonthlyAnalysisData(
      sumStatList: (json['sumStatList'] as List<dynamic>? ?? [])
          .map((e) => MonthlySumStat.fromJson(e))
          .toList(),
      year: json['year'] ?? 0,
      month: json['month'] ?? 0,
      totalExpense: (json['totalExpense'] ?? 0).toInt(),
      totalIncome: (json['totalIncome'] ?? 0).toInt(),
      totalAmount: (json['totalAmount'] ?? 0).toInt(),
      sumStat: json['sumStat'] != null
          ? MonthlySumStat.fromJson(json['sumStat'])
          : null,
      categoryStat: json['categoryStat'] != null
          ? MonthlyCategoryStatList.fromJson(json['categoryStat'])
          : MonthlyCategoryStatList(categoryStatDtoList: [], totalAmount: 0),
      abcStat: json['abcStat'] != null
          ? MonthlyAbcStat.fromJson(json['abcStat'])
          : MonthlyAbcStat(totalA: 0, totalB: 0, totalC: 0),
      cateAbcStat: json['cateAbcStat'] != null
          ? MonthlyCateAbcStat.fromJson(json['cateAbcStat'])
          : MonthlyCateAbcStat(cateAbcStatDtoList: [], totalAmount: 0),
    );
  }

  @override
  String toString() {
    return 'MonthlyAnalysisData(year: $year, month: $month, totalExpense: $totalExpense, totalIncome: $totalIncome, totalAmount: $totalAmount, '
        'sumStat: $sumStat, categoryStat: $categoryStat, abcStat: $abcStat, cateAbcStat: $cateAbcStat, sumStatList: $sumStatList)';
  }
}

class MonthlySumStat {
  final int year;
  final int month;
  final int totalExpense;
  final int totalIncome;
  final int totalAmount;

  MonthlySumStat({
    required this.year,
    required this.month,
    required this.totalExpense,
    required this.totalIncome,
    required this.totalAmount,
  });

  factory MonthlySumStat.fromJson(Map<String, dynamic> json) {
    return MonthlySumStat(
      year: json['year'] ?? 0,
      month: json['month'] ?? 0,
      totalExpense: (json['totalExpense'] ?? 0).toInt(),
      totalIncome: (json['totalIncome'] ?? 0).toInt(),
      totalAmount: (json['totalAmount'] ?? 0).toInt(),
    );
  }

  @override
  String toString() =>
      'MonthlySumStat(year: $year, month: $month, totalExpense: $totalExpense, totalIncome: $totalIncome, totalAmount: $totalAmount)';
}

class MonthlyCategoryStatList {
  final List<MonthlyCategoryStat> categoryStatDtoList;
  final int totalAmount;

  MonthlyCategoryStatList({
    required this.categoryStatDtoList,
    required this.totalAmount,
  });

  factory MonthlyCategoryStatList.fromJson(Map<String, dynamic> json) {
    return MonthlyCategoryStatList(
      categoryStatDtoList: (json['categoryStatDtoList'] as List<dynamic>? ?? [])
          .map((e) => MonthlyCategoryStat.fromJson(e))
          .toList(),
      totalAmount: (json['totalAmount'] ?? 0).toInt(),
    );
  }

  @override
  String toString() =>
      'MonthlyCategoryStatList(totalAmount: $totalAmount, categoryStatDtoList: $categoryStatDtoList)';
}

class MonthlyCategoryStat {
  final int categoryId;
  final String categoryName;
  final int amount;

  MonthlyCategoryStat({
    required this.categoryId,
    required this.categoryName,
    required this.amount,
  });

  factory MonthlyCategoryStat.fromJson(Map<String, dynamic> json) {
    return MonthlyCategoryStat(
      categoryId: json['categoryId'] ?? 0,
      categoryName: json['categoryName'] ?? '',
      amount: (json['amount'] ?? 0).toInt(),
    );
  }

  @override
  String toString() =>
      'MonthlyCategoryStat(categoryId: $categoryId, categoryName: $categoryName, amount: $amount)';
}

class MonthlyAbcStat {
  final int totalA;
  final int totalB;
  final int totalC;

  MonthlyAbcStat({
    required this.totalA,
    required this.totalB,
    required this.totalC,
  });

  factory MonthlyAbcStat.fromJson(Map<String, dynamic> json) {
    return MonthlyAbcStat(
      totalA: (json['totalA'] ?? 0).toInt(),
      totalB: (json['totalB'] ?? 0).toInt(),
      totalC: (json['totalC'] ?? 0).toInt(),
    );
  }

  @override
  String toString() => 'MonthlyAbcStat(totalA: $totalA, totalB: $totalB, totalC: $totalC)';
}

enum MonthlyAbcType { A, B, C }

MonthlyAbcType monthlyAbcTypeFromString(String s) {
  switch (s) {
    case 'A':
      return MonthlyAbcType.A;
    case 'B':
      return MonthlyAbcType.B;
    case 'C':
      return MonthlyAbcType.C;
    default:
      throw Exception('Unknown MonthlyAbcType: $s');
  }
}

class MonthlyCateAbcStat {
  final List<MonthlyCateAbcStatDto> cateAbcStatDtoList;
  final int totalAmount;

  MonthlyCateAbcStat({
    required this.cateAbcStatDtoList,
    required this.totalAmount,
  });

  factory MonthlyCateAbcStat.fromJson(Map<String, dynamic> json) {
    return MonthlyCateAbcStat(
      cateAbcStatDtoList: (json['cateAbcStatDtoList'] as List<dynamic>? ?? [])
          .map((e) => MonthlyCateAbcStatDto.fromJson(e))
          .toList(),
      totalAmount: (json['totalAmount'] ?? 0).toInt(),
    );
  }

  @override
  String toString() =>
      'MonthlyCateAbcStat(totalAmount: $totalAmount, cateAbcStatDtoList: $cateAbcStatDtoList)';
}

class MonthlyCateAbcStatDto {
  final int categoryId;
  final String categoryName;
  final MonthlyAbcType abc;
  final int amount;

  MonthlyCateAbcStatDto({
    required this.categoryId,
    required this.categoryName,
    required this.abc,
    required this.amount,
  });

  factory MonthlyCateAbcStatDto.fromJson(Map<String, dynamic> json) {
    return MonthlyCateAbcStatDto(
      categoryId: json['categoryId'] ?? 0,
      categoryName: json['categoryName'] ?? '',
      abc: monthlyAbcTypeFromString(json['abc'] ?? 'A'),
      amount: (json['amount'] ?? 0).toInt(),
    );
  }

  @override
  String toString() =>
      'MonthlyCateAbcStatDto(categoryId: $categoryId, categoryName: $categoryName, abc: $abc, amount: $amount)';
}