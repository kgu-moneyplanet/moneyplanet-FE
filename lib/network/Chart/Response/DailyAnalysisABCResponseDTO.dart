class DailyAbcStatResponseDTO {
  final int statusCode;
  final String message;
  final AbcStat? data;

  DailyAbcStatResponseDTO({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory DailyAbcStatResponseDTO.fromJson(Map<String, dynamic> json) {
    return DailyAbcStatResponseDTO(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? AbcStat.fromJson(json['data']) : null,
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