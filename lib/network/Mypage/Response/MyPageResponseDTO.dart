class MyPageResponseDTO {
  final String username;
  final String name;
  final String cellphone;
  final String email;
  final String planet;
  final int totalIncome;
  final int totalExpense;
  final String birth;
  final String gender;
  final String job;
  final double target;
  final bool achieved;
  final String? prefer;

  MyPageResponseDTO({
    required this.username,
    required this.name,
    required this.cellphone,
    required this.email,
    required this.planet,
    required this.totalIncome,
    required this.totalExpense,
    required this.birth,
    required this.gender,
    required this.job,
    required this.target,
    required this.achieved,
    this.prefer,
  });

  factory MyPageResponseDTO.fromJson(Map<String, dynamic> json) {
    return MyPageResponseDTO(
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      cellphone: json['cellphone'] ?? '',
      email: json['email'] ?? '',
      planet: json['planet'] ?? 'EARTH', // 기본값 설정 가능
      totalIncome: json['totalIncome'] ?? 0,
      totalExpense: json['totalExpense'] ?? 0,
      birth: json['birth'] ?? '',
      gender: json['gender'] ?? '',
      job: json['job'] ?? '',
      target: (json['target'] != null) ? json['target'].toDouble() : 0.0,
      achieved: json['achieved'] ?? false,
      prefer: json['prefer'],
    );
  }
}