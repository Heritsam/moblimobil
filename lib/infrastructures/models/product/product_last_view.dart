import 'product.dart';

class ProductLastViewResponse {
  const ProductLastViewResponse({
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
  final List<ProductLastView> data;

  factory ProductLastViewResponse.fromJson(Map<String, dynamic> json) =>
      ProductLastViewResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        currentPage: json['current_page'],
        lastPage: json['last_page'],
        total: json['total'],
        data: List<ProductLastView>.from(
            json['data'].map((x) => ProductLastView.fromJson(x))),
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

class ProductLastView {
  const ProductLastView({
    required this.id,
    required this.userId,
    required this.productId,
    required this.createdAt,
    required this.product,
  });

  final int id;
  final String userId;
  final String productId;
  final DateTime createdAt;
  final Product product;

  factory ProductLastView.fromJson(Map<String, dynamic> json) =>
      ProductLastView(
        id: json['id'],
        userId: json['user_id'],
        productId: json['product_id'],
        createdAt: DateTime.parse(json['created_at']),
        product: Product.fromJson(json['product']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'product_id': productId,
        'created_at': createdAt.toIso8601String(),
        'product': product.toJson(),
      };
}
