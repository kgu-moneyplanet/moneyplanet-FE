class UserInfoResponseDTO {
  final int statusCode;
  final String message;
  final UserInfoData;

  UserInfoResponseDTO({
    required this.statusCode,
    required this.message,
    required this.UserInfoData,
  });
}

class UserInfoData {
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

  UserInfoData({
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
    required this.prefer,
  });
}
