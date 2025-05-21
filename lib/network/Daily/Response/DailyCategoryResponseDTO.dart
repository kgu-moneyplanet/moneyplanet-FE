class DailyCategoryResponseDTO {
  final int statusCode;
  final String message;
  final DailyCategoryResponseData data;

  DailyCategoryResponseDTO({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory DailyCategoryResponseDTO.fromJson(Map<String, dynamic> json) {
    return DailyCategoryResponseDTO(
      statusCode: json['statusCode'],
      message: json['message'],
      data: DailyCategoryResponseData.fromJson(json['data']),
    );
  }
}

class DailyCategoryResponseData {
  final List<CategoryStatDtoList> categoryStatDtoList;
  final int totalAmount;

  DailyCategoryResponseData({
    required this.categoryStatDtoList,
    required this.totalAmount,
  });

  factory DailyCategoryResponseData.fromJson(Map<String, dynamic> json) {
    return DailyCategoryResponseData(
      categoryStatDtoList: (json['categoryStatDtoList'] as List)
          .map((e) => CategoryStatDtoList.fromJson(e))
          .toList(),
      totalAmount: json['totalAmount'],
    );
  }
}

class CategoryStatDtoList {
  final int categoryId;
  final String categoryName;
  final int amount;

  CategoryStatDtoList({
    required this.categoryId,
    required this.categoryName,
    required this.amount,
  });

  factory CategoryStatDtoList.fromJson(Map<String, dynamic> json) {
    return CategoryStatDtoList(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      amount: json['amount'],
    );
  }
}