class WeeklyAnalysisResponse {
  final int statusCode;
  final String message;
  final WeeklyAnalysisData? data;

  WeeklyAnalysisResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory WeeklyAnalysisResponse.fromJson(Map<String, dynamic> json) {
    return WeeklyAnalysisResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? WeeklyAnalysisData.fromJson(json['data']) : null,
    );
  }
}

class WeeklyAnalysisData {
  final List<SumStat> sumStatList;
  final SumStat sumStat;
  final int year;
  final int month;
  final int week;
  final CategoryStat categoryStat;
  final AbcStat abcStat;
  final CateAbcStat cateAbcStat;

  WeeklyAnalysisData({
    required this.sumStatList,
    required this.sumStat,
    required this.year,
    required this.month,
    required this.week,
    required this.categoryStat,
    required this.abcStat,
    required this.cateAbcStat,
  });

  factory WeeklyAnalysisData.fromJson(Map<String, dynamic> json) {
    return WeeklyAnalysisData(
      sumStatList: (json['sumStatList'] as List<dynamic>? ?? [])
          .map((e) => SumStat.fromJson(e))
          .toList(),
      sumStat: json['sumStat'] != null
          ? SumStat.fromJson(json['sumStat'])
          : SumStat(year: 0, month: 0, week: 0, totalExpense: 0, totalIncome: 0, totalAmount: 0),
      year: json['year'] ?? 0,
      month: json['month'] ?? 0,
      week: json['week'] ?? 0,
      categoryStat: json['categoryStat'] != null
          ? CategoryStat.fromJson(json['categoryStat'])
          : CategoryStat(categoryStatDtoList: []),
      abcStat: json['abcStat'] != null
          ? AbcStat.fromJson(json['abcStat'])
          : AbcStat(totalA: 0, totalB: 0, totalC: 0, totalExpense: 0),
      cateAbcStat: json['cateAbcStat'] != null
          ? CateAbcStat.fromJson(json['cateAbcStat'])
          : CateAbcStat(cateAbcStatDtoList: []),
    );
  }
}

class SumStat {
  final int year;
  final int month;
  final int week;
  final int totalExpense;
  final int totalIncome;
  final int totalAmount;

  SumStat({
    required this.year,
    required this.month,
    required this.week,
    required this.totalExpense,
    required this.totalIncome,
    required this.totalAmount,
  });

  factory SumStat.fromJson(Map<String, dynamic> json) {
    return SumStat(
      year: json['year'] ?? 0,
      month: json['month'] ?? 0,
      week: json['week'] ?? 0,
      totalExpense: json['totalExpense'] ?? 0,
      totalIncome: json['totalIncome'] ?? 0,
      totalAmount: json['totalAmount'] ?? 0,
    );
  }
}

class CategoryStat {
  final List<CategoryStatDto> categoryStatDtoList;

  CategoryStat({
    required this.categoryStatDtoList,
  });

  factory CategoryStat.fromJson(Map<String, dynamic> json) {
    return CategoryStat(
      categoryStatDtoList: (json['categoryStatDtoList'] as List<dynamic>? ?? [])
          .map((e) => CategoryStatDto.fromJson(e))
          .toList(),
    );
  }
}

class CategoryStatDto {
  final int categoryId;
  final String categoryName;
  final int amount;

  CategoryStatDto({
    required this.categoryId,
    required this.categoryName,
    required this.amount,
  });

  factory CategoryStatDto.fromJson(Map<String, dynamic> json) {
    return CategoryStatDto(
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
  final int totalExpense;

  AbcStat({
    required this.totalA,
    required this.totalB,
    required this.totalC,
    required this.totalExpense,
  });

  factory AbcStat.fromJson(Map<String, dynamic> json) {
    return AbcStat(
      totalA: json['totalA'] ?? 0,
      totalB: json['totalB'] ?? 0,
      totalC: json['totalC'] ?? 0,
      totalExpense: json['totalExpense'] ?? 0,
    );
  }
}

class CateAbcStat {
  final List<CateAbcStatDto> cateAbcStatDtoList;

  CateAbcStat({
    required this.cateAbcStatDtoList,
  });

  factory CateAbcStat.fromJson(Map<String, dynamic> json) {
    return CateAbcStat(
      cateAbcStatDtoList: (json['cateAbcStatDtoList'] as List<dynamic>? ?? [])
          .map((e) => CateAbcStatDto.fromJson(e))
          .toList(),
    );
  }
}

class CateAbcStatDto {
  final int categoryId;
  final String categoryName;
  final String abc;
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
      abc: json['abc'] ?? '',
      amount: json['amount'] ?? 0,
    );
  }
}