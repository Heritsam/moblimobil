class EmailNotVerified {
  const EmailNotVerified({
    required this.userId,
    required this.password,
    required this.fullname,
    required this.email,
  });

  final int userId;
  final String password;
  final String fullname;
  final String email;

  factory EmailNotVerified.fromJson(Map<String, dynamic> json) {
    return EmailNotVerified(
      userId: json['user_id'],
      password: json['password'],
      fullname: json['user_fullname'],
      email: json['user_email'],
    );
  }
}
