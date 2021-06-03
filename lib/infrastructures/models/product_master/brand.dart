class BrandResponse {
  BrandResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.currentPage,
    required this.total,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final int currentPage;
  final int total;
  final List<Brand> data;

  factory BrandResponse.fromJson(Map<String, dynamic> json) => BrandResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        currentPage: json['current_page'],
        total: json['total'],
        data: List<Brand>.from(json['data'].map((x) => Brand.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'current_page': currentPage,
        'total': total,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Brand {
  Brand({
    required this.id,
    required this.title,
    required this.file,
  });

  final int id;
  final String title;
  final String file;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
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
