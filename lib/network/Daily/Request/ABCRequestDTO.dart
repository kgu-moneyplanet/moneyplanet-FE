class ABCRequestDTO {
  final String txDate;
  final int amount;
  final int categoryId;
  final String content;
  final String memo;

  ABCRequestDTO({
    required this.txDate,
    required this.amount,
    required this.categoryId,
    required this.content,
    required this.memo,
  });

  Map<String, dynamic> toJson() => {
    'txDate': txDate,
    'amount': amount,
    'categoryId': categoryId,
    'content': content,
    'memo': memo,
  };
}