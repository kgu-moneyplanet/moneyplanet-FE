class RegisterRequestDTO {
  final String txDate;
  final String type;
  final int categoryId;
  final String abc;
  final int amount;
  final String method;
  final String content;
  final String memo;
  final String feedback;

  RegisterRequestDTO({
    required this.txDate,
    required this.type,
    required this.categoryId,
    required this.abc,
    required this.amount,
    required this.method,
    required this.content,
    required this.memo,
    required this.feedback,
  });

  Map<String, dynamic> toJson() {
    return {
      'txDate': txDate,
      'type': type,
      'categoryId': categoryId,
      'abc': abc,
      'amount': amount,
      'method': method,
      'content': content,
      'memo': memo,
      'feedback': feedback,
    };
  }

  factory RegisterRequestDTO.fromJson(Map<String, dynamic> json) {
    return RegisterRequestDTO(
      txDate: json['txDate'],
      type: json['type'],
      categoryId: json['categoryId'],
      abc: json['abc'],
      amount: json['amount'],
      method: json['method'],
      content: json['content'],
      memo: json['memo'],
      feedback: json['feedback'],
    );
  }
}