class User {
  User({
    required this.id,
    required this.fullname,
    required this.phone,
    required this.email,
    this.bornDate,
    this.file,
    required this.status,
    required this.emailVerifiedToken,
    this.emailVerifiedAt,
    required this.isVendor,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String fullname;
  final String phone;
  final String email;
  final DateTime? bornDate;
  final String? file;
  final String status;
  final String emailVerifiedToken;
  final DateTime? emailVerifiedAt;
  final String isVendor;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        fullname: json['fullname'],
        phone: json['phone'],
        email: json['email'],
        bornDate: json['born_date'] != null
            ? DateTime.tryParse(json['born_date'])
            : null,
        file: json['file'],
        status: json['status'],
        emailVerifiedToken: json['email_verified_token'],
        emailVerifiedAt: json['email_verified_at'] != null
            ? DateTime.tryParse(json['email_verified_at'])
            : null,
        isVendor: json['is_vendor'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullname,
        'phone': phone,
        'email': email,
        'born_date': bornDate,
        'file': file,
        'status': status,
        'email_verified_token': emailVerifiedToken,
        'email_verified_at': emailVerifiedAt?.toIso8601String(),
        'is_vendor': isVendor,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
