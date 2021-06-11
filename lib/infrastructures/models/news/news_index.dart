import 'news.dart';

class NewsIndexResponse {
  NewsIndexResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final int currentPage;
  final int lastPage;
  final int total;
  final List<News> data;

  factory NewsIndexResponse.fromJson(Map<String, dynamic> json) =>
      NewsIndexResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        currentPage: json['current_page'],
        lastPage: json['last_page'],
        total: json['total'],
        data: List<News>.from(json['data'].map((x) => News.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'current_page': currentPage,
        'last_page': lastPage,
        'total': total,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
