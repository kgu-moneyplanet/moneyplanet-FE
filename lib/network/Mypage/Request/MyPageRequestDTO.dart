class MyPageUserDTO {
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
  final String target;
  final String prefer;

  MyPageUserDTO({
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
    required this.prefer,
  });

  factory MyPageUserDTO.fromJson(Map<String, dynamic> json) {
    return MyPageUserDTO(
      username: json['username'],
      name: json['name'],
      cellphone: json['cellphone'],
      email: json['email'],
      planet: json['planet'],
      totalIncome: json['totalIncome'],
      totalExpense: json['totalExpense'],
      birth: json['birth'],
      gender: json['gender'],
      job: json['job'],
      target: json['target'],
      prefer: json['prefer'],
    );
  }
}