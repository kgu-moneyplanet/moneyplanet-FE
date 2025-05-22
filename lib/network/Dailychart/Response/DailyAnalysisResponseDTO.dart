class DailyAnalysisResponseDTO {
  final int statusCode;
  final String message;
  final DailyAnalysisData data;

  DailyAnalysisResponseDTO({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory DailyAnalysisResponseDTO.fromJson(Map<String, dynamic> json) {
    return DailyAnalysisResponseDTO(
      statusCode: json['statusCode'],
      message: json['message'],
      data: DailyAnalysisData.fromJson(json['data']),
    );
  }
}

class DailyAnalysisData {
  final List<SumStatItem> sumStatList;
  final SumStat sumStat;
  final CategoryStat categoryStat;
  final AbcStat abcStat;
  final CateAbcStat cateAbcStat;

  DailyAnalysisData({
    required this.sumStatList,
    required this.sumStat,
    required this.categoryStat,
    required this.abcStat,
    required this.cateAbcStat,
  });

  factory DailyAnalysisData.fromJson(Map<String, dynamic> json) {
    return DailyAnalysisData(
      sumStatList: List<SumStatItem>.from(
          json['sumStatList'].map((e) => SumStatItem.fromJson(e))),
      sumStat: SumStat.fromJson(json['sumStat']),
      categoryStat: CategoryStat.fromJson(json['categoryStat']),
      abcStat: AbcStat.fromJson(json['abcStat']),
      cateAbcStat: CateAbcStat.fromJson(json['cateAbcStat']),
    );
  }
}

class SumStatItem {
  final String weekday;
  final String day; // ISO 8601 string (e.g. "2025-05-01")
  final int totalExpense;
  final int totalIncome;
  final int totalAmount;

  SumStatItem({
    required this.weekday,
    required this.day,
    required this.totalExpense,
    required this.totalIncome,
    required this.totalAmount,
  });

  factory SumStatItem.fromJson(Map<String, dynamic> json) {
    return SumStatItem(
      weekday: json['weekday'],
      day: json['day'],
      totalExpense: json['totalExpense'],
      totalIncome: json['totalIncome'],
      totalAmount: json['totalAmount'],
    );
  }
}

class SumStat {
  final int totalExpense;
  final int totalIncome;
  final int totalAmount;

  SumStat({
    required this.totalExpense,
    required this.totalIncome,
    required this.totalAmount,
  });

  factory SumStat.fromJson(Map<String, dynamic> json) {
    return SumStat(
      totalExpense: json['totalExpense'],
      totalIncome: json['totalIncome'],
      totalAmount: json['totalAmount'],
    );
  }
}

class CategoryStat {
  final List<CategoryStatDto> categoryStatDtoList;
  final int totalAmount;

  CategoryStat({
    required this.categoryStatDtoList,
    required this.totalAmount,
  });

  factory CategoryStat.fromJson(Map<String, dynamic> json) {
    return CategoryStat(
      categoryStatDtoList: List<CategoryStatDto>.from(
          json['categoryStatDtoList'].map((e) => CategoryStatDto.fromJson(e))),
      totalAmount: json['totalAmount'],
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
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      amount: json['amount'],
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
      totalA: json['totalA'],
      totalB: json['totalB'],
      totalC: json['totalC'],
      totalExpense: json['totalExpense'],
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
      cateAbcStatDtoList: List<CateAbcStatDto>.from(
          json['cateAbcStatDtoList'].map((e) => CateAbcStatDto.fromJson(e))),
      totalAmount: json['totalAmount'],
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
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      abc: json['abc'],
      amount: json['amount'],
    );
  }
}