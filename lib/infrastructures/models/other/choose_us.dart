class ChooseUsResponse {
  ChooseUsResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final List<ChooseUs> data;

  factory ChooseUsResponse.fromJson(Map<String, dynamic> json) =>
      ChooseUsResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data:
            List<ChooseUs>.from(json['data'].map((x) => ChooseUs.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ChooseUs {
  ChooseUs({
    required this.id,
    required this.title,
    required this.description,
    required this.file,
  });

  final int id;
  final String title;
  final String description;
  final String file;

  factory ChooseUs.fromJson(Map<String, dynamic> json) => ChooseUs(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        file: json['file'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'file': file,
      };
}
