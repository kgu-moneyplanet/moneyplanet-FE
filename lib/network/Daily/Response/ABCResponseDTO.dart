class ABCResponseDTO {
  final int statusCode;
  final String message;
  final ABCResponseData data;

  ABCResponseDTO({required this.statusCode, required this.message, required this.data});

  factory ABCResponseDTO.fromJson(Map<String, dynamic> json) {
    return ABCResponseDTO(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? ABCResponseData.fromJson(json['data'])
          : ABCResponseData(reason: '', feedback: '', abc: ''),
    );
  }
}

class ABCResponseData {
  final String reason;
  final String feedback;
  final String abc;

  ABCResponseData({required this.reason, required this.feedback, required this.abc});

  factory ABCResponseData.fromJson(Map<String, dynamic> json) {
    return ABCResponseData(
      reason: json['reason'],
      feedback: json['feedback'],
      abc: json['abc'],
    );
  }
}