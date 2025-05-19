class SignUpRequestDTO {
  final String username;
  final String name;
  final String cellphone;
  final String email;
  final String password;
  final String birth;
  final String gender; // 'M' or 'F'
  final String job;
  final String prefer;
  final String planet;

  SignUpRequestDTO({
    required this.username,
    required this.name,
    required this.cellphone,
    required this.email,
    required this.password,
    required this.birth,
    required this.gender,
    required this.job,
    required this.prefer,
    required this.planet,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'name': name,
    'cellphone': cellphone,
    'email': email,
    'password': password,
    'birth': birth,
    'gender': gender,
    'job': job,
    'prefer': prefer,
    'planet': planet,
  };
}