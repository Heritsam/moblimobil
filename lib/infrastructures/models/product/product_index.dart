import 'product.dart';

class ProductIndexResponse {
  ProductIndexResponse({
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
  final List<Product> data;

  factory ProductIndexResponse.fromJson(Map<String, dynamic> json) =>
      ProductIndexResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        currentPage: json['current_page'],
        total: json['total'],
        data: List<Product>.from(json['data'].map((x) => Product.fromJson(x))),
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
