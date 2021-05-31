class FaqResponse {
  FaqResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final List<FAQ> data;

  factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data: List<FAQ>.from(json['data'].map((x) => FAQ.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FAQ {
  FAQ({
    required this.id,
    required this.pertanyaan,
    required this.jawaban,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String pertanyaan;
  final String jawaban;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory FAQ.fromJson(Map<String, dynamic> json) => FAQ(
        id: json['id'],
        pertanyaan: json['pertanyaan'],
        jawaban: json['jawaban'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'pertanyaan': pertanyaan,
        'jawaban': jawaban,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
