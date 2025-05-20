class SignUpRequestDTO {
  final String username, name, email, cellphone, birth;
  final String password, gender, job, prefer, planet;

  SignUpRequestDTO({
    required this.username,
    required this.name,
    required this.email,
    required this.cellphone,
    required this.birth,
    required this.password,
    required this.gender,
    required this.job,
    required this.prefer,
    required this.planet,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'name': name,
    'email': email,
    'cellphone': cellphone,
    'birth': birth,
    'password': password,
    'gender': gender,
    'job': job,
    'prefer': prefer,
    'planet': planet,
  };
}