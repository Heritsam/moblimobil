class WishlistResponse {
  WishlistResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final List<Wishlist> data;

  factory WishlistResponse.fromJson(Map<String, dynamic> json) =>
      WishlistResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data:
            List<Wishlist>.from(json['data'].map((x) => Wishlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Wishlist {
  Wishlist({
    required this.id,
    required this.type,
    required this.userId,
    required this.keyId,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.file,
    this.vendorName,
    this.vendorVerified,
  });

  final int id;
  final String type;
  final String userId;
  final String keyId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;
  final String file;
  final String? vendorName;
  final bool? vendorVerified;

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        id: json['id'],
        type: json['type'],
        userId: json['user_id'],
        keyId: json['key_id'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        title: json['title'],
        file: json['file'],
        vendorName: json['vendor_name'] != null ? json['vendor_name'] : null,
        vendorVerified: json['vendor_verified'] != null
            ? json['vendor_verified'] == 'true'
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'user_id': userId,
        'key_id': keyId,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'title': title,
        'file': file,
        'vendor_name': vendorName,
        'vendor_verified': vendorVerified,
      };
}
