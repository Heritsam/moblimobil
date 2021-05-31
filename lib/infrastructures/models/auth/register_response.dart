import '../profile/user.dart';

class RegisterResponse {
  RegisterResponse({
    required this.token,
    required this.tokenType,
    required this.expiresIn,
    required this.tokenEmail,
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final String token;
  final String tokenType;
  final int expiresIn;
  final String tokenEmail;
  final int code;
  final bool success;
  final String message;
  final User data;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        token: json['token'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
        tokenEmail: json['token_email'],
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data: User.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'token_type': tokenType,
        'expires_in': expiresIn,
        'token_email': tokenEmail,
        'code': code,
        'success': success,
        'message': message,
        'data': data.toJson(),
      };
}
