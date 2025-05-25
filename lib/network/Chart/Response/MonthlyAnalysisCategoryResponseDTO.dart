class MonthlyCategoryData {
  final List<CategoryStat> categoryStatDtoList;
  final int totalAmount;

  MonthlyCategoryData({
    required this.categoryStatDtoList,
    required this.totalAmount,
  });

  factory MonthlyCategoryData.fromJson(Map<String, dynamic> json) {
    var listJson = json['categoryStatDtoList'] ?? [];
    List<CategoryStat> categoryStatList = [];
    if (listJson != null) {
      categoryStatList = (listJson as List)
          .map((e) => CategoryStat.fromJson(e))
          .toList();
    }
    return MonthlyCategoryData(
      categoryStatDtoList: categoryStatList,
      totalAmount: json['totalAmount'] ?? 0,
    );
  }
}

class MonthlyAnalysisCategoryResponse {
  final int statusCode;
  final String message;
  final MonthlyCategoryData? data;

  MonthlyAnalysisCategoryResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory MonthlyAnalysisCategoryResponse.fromJson(Map<String, dynamic> json) {
    return MonthlyAnalysisCategoryResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? MonthlyCategoryData.fromJson(json['data'])
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