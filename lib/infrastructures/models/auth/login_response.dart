import 'package:moblimobil/infrastructures/models/profile/user.dart';

class LoginResponse {
  LoginResponse({
    required this.token,
    required this.tokenType,
    required this.expiresIn,
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final String token;
  final String tokenType;
  final int expiresIn;
  final int code;
  final bool success;
  final String message;
  final User data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json['token'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data: User.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'token_type': tokenType,
        'expires_in': expiresIn,
        'code': code,
        'success': success,
        'message': message,
        'data': data.toJson(),
      };
}
