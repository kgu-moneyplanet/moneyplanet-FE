class DiaryDailyListResponseDTO {
  final int statusCode;
  final String message;
  final List<DiaryDailyListData> data;

  DiaryDailyListResponseDTO({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory DiaryDailyListResponseDTO.fromJson(Map<String, dynamic> json) {
    return DiaryDailyListResponseDTO(
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => DiaryDailyListData.fromJson(e))
          .toList(),
    );
  }
}

class DiaryDailyListData {
  final String id;
  final String userId;
  final String txDate;
  final String type;
  final int categoryId;
  final String? abc;
  final int amount;
  final String method;
  final String content;
  final String memo;
  final ReportResponseDto? reportResponseDto;

  DiaryDailyListData({
    required this.id,
    required this.userId,
    required this.txDate,
    required this.type,
    required this.categoryId,
    required this.abc,
    required this.amount,
    required this.method,
    required this.content,
    required this.memo,
    required this.reportResponseDto,
  });

  factory DiaryDailyListData.fromJson(Map<String, dynamic> json) {
    return DiaryDailyListData(
      id: json['id'],
      userId: json['userId'],
      txDate: json['txDate'],
      type: json['type'],
      categoryId: json['categoryId'],
      abc: json['abc'],
      amount: json['amount'],
      method: json['method'],
      content: json['content'],
      memo: json['memo'],
      reportResponseDto: json['reportResponseDto'] != null
          ? ReportResponseDto.fromJson(json['reportResponseDto'])
          : null,
    );
  }
}

class ReportResponseDto {
  final String abc;
  final String reason;
  final String feedback;

  ReportResponseDto({
    required this.abc,
    required this.reason,
    required this.feedback,
  });

  factory ReportResponseDto.fromJson(Map<String, dynamic> json) {
    return ReportResponseDto(
      abc: json['abc'],
      reason: json['reason'],
      feedback: json['feedback'],
    );
  }
}