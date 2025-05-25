class WeeklyCategoryData {
  final List<CategoryStat> categoryStatDtoList;
  final int totalAmount;

  WeeklyCategoryData({
    required this.categoryStatDtoList,
    required this.totalAmount,
  });

  factory WeeklyCategoryData.fromJson(Map<String, dynamic> json) {
    var listJson = json['categoryStatDtoList'] ?? [];
    List<CategoryStat> categoryStatList = [];
    if (listJson != null) {
      categoryStatList = (listJson as List)
          .map((e) => CategoryStat.fromJson(e))
          .toList();
    }
    return WeeklyCategoryData(
      categoryStatDtoList: categoryStatList,
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
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      amount: json['amount'],
    );
  }
}class WeeklyAnalysisCategoryResponse {
  final int statusCode;
  final String message;
  final WeeklyCategoryData? data;

  WeeklyAnalysisCategoryResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory WeeklyAnalysisCategoryResponse.fromJson(Map<String, dynamic> json) {
    return WeeklyAnalysisCategoryResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? WeeklyCategoryData.fromJson(json['data'])
          : null,
    );
  }
}