class CarColorResponse {
  CarColorResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final List<CarColor> data;

  factory CarColorResponse.fromJson(Map<String, dynamic> json) =>
      CarColorResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data:
            List<CarColor>.from(json['data'].map((x) => CarColor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CarColor {
  CarColor({
    required this.id,
    required this.code,
    required this.title,
  });

  final int id;
  final String code;
  final String title;

  factory CarColor.fromJson(Map<String, dynamic> json) => CarColor(
        id: json['id'],
        code: json['code'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'title': title,
      };
}
