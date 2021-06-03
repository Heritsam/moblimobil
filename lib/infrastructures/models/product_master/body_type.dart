class BodyTypeResponse {
  BodyTypeResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final List<BodyType> data;

  factory BodyTypeResponse.fromJson(Map<String, dynamic> json) =>
      BodyTypeResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data:
            List<BodyType>.from(json['data'].map((x) => BodyType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BodyType {
  BodyType({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  factory BodyType.fromJson(Map<String, dynamic> json) => BodyType(
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
