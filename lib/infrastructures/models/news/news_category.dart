class NewsCategoryResponse {
  NewsCategoryResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final List<NewsCategory> data;

  factory NewsCategoryResponse.fromJson(Map<String, dynamic> json) =>
      NewsCategoryResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data: List<NewsCategory>.from(
            json['data'].map((x) => NewsCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class NewsCategory {
  NewsCategory({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  factory NewsCategory.fromJson(Map<String, dynamic> json) => NewsCategory(
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
