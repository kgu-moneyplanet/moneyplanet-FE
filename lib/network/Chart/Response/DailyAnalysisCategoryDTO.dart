class DailyCategoryData {
  final List<CategoryStat> categoryStatDtoList;
  final int totalAmount;

  DailyCategoryData({
    required this.categoryStatDtoList,
    required this.totalAmount,
  });

  factory DailyCategoryData.fromJson(Map<String, dynamic> json) {
    var listJson = json['categoryStatDtoList'] ?? [];
    List<CategoryStat> categoryStatList = [];
    if (listJson != null) {
      categoryStatList = (listJson as List)
          .map((e) => CategoryStat.fromJson(e))
          .toList();
    }
    return DailyCategoryData(
      categoryStatDtoList: categoryStatList,
      totalAmount: json['totalAmount'] ?? 0,
    );
  }
}

class DailyAnalysisCategoryResponse {
  final int statusCode;
  final String message;
  final DailyCategoryData? data;

  DailyAnalysisCategoryResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory DailyAnalysisCategoryResponse.fromJson(Map<String, dynamic> json) {
    return DailyAnalysisCategoryResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? DailyCategoryData.fromJson(json['data'])
          : null,
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
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      amount: json['amount'],
    );
  }
}