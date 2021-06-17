class BankResponse {
  BankResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final List<Bank> data;

  factory BankResponse.fromJson(Map<String, dynamic> json) => BankResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data: List<Bank>.from(json['data'].map((x) => Bank.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Bank {
  const Bank({
    required this.id,
    required this.title,
    required this.file,
  });

  final int id;
  final String title;
  final String file;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json['id'],
        title: json['title'],
        file: json['file'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'file': file,
      };
}
