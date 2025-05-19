class LWTWResponseDTO {
  final int statusCode;
  final String message;
  final LWTWResponseData data;

  LWTWResponseDTO(
      {required this.statusCode, required this.message, required this.data});
}

class LWTWResponseData {
  final String lastWeekCategoryName; // 이번주 이름
  final int lastWeekCategoryAmount; // 저번주 금액
  final String thisWeekCategoryName; // 이번주 이름
  final int thisWeekCategoryAmount; // 이번주 금액
  final int diffAmount // 금액차이


  LWTWResponseData(
      {required this.lastWeekCategoryName, required this.lastWeekCategoryAmount, required this.thisWeekCategoryName, required this.thisWeekCategoryAmount, required this.diffAmount},);
}
