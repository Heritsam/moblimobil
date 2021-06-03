class FuelTypeResponse {
  FuelTypeResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final List<FuelType> data;

  factory FuelTypeResponse.fromJson(Map<String, dynamic> json) =>
      FuelTypeResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data:
            List<FuelType>.from(json['data'].map((x) => FuelType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FuelType {
  FuelType({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  factory FuelType.fromJson(Map<String, dynamic> json) => FuelType(
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
