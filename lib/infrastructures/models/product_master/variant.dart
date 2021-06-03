class VariantResponse {
  VariantResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final List<Variant> data;

  factory VariantResponse.fromJson(Map<String, dynamic> json) =>
      VariantResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data: List<Variant>.from(json['data'].map((x) => Variant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Variant {
  Variant({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
