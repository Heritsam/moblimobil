class ProductRecommend {
  ProductRecommend({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.descriptionTitle,
    required this.description,
    required this.price,
    required this.brandId,
    required this.variantId,
    required this.bodyTypeId,
    required this.fuelTypeId,
    required this.transmissionId,
    required this.colorId,
    required this.kilometer,
    required this.yearProduct,
    required this.salesStatus,
    required this.view,
    required this.createdAt,
    required this.updatedAt,
    required this.brandName,
    required this.file,
  });

  final int id;
  final String userId;
  final String type;
  final String title;
  final String descriptionTitle;
  final String description;
  final String price;
  final String brandId;
  final String variantId;
  final String bodyTypeId;
  final String fuelTypeId;
  final String transmissionId;
  final String colorId;
  final String kilometer;
  final String yearProduct;
  final String salesStatus;
  final String view;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String brandName;
  final String file;

  factory ProductRecommend.fromJson(Map<String, dynamic> json) =>
      ProductRecommend(
        id: json['id'],
        userId: json['user_id'],
        type: json['type'],
        title: json['title'],
        descriptionTitle: json['description_title'],
        description: json['description'],
        price: json['price'],
        brandId: json['brand_id'],
        variantId: json['variant_id'],
        bodyTypeId: json['body_type_id'],
        fuelTypeId: json['fuel_type_id'],
        transmissionId: json['transmission_id'],
        colorId: json['color_id'],
        kilometer: json['kilometer'],
        yearProduct: json['year_product'],
        salesStatus: json['sales_status'],
        view: json['view'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        brandName: json['brand_name'],
        file: json['file'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'type': type,
        'title': title,
        'description_title': descriptionTitle,
        'description': description,
        'price': price,
        'brand_id': brandId,
        'variant_id': variantId,
        'body_type_id': bodyTypeId,
        'fuel_type_id': fuelTypeId,
        'transmission_id': transmissionId,
        'color_id': colorId,
        'kilometer': kilometer,
        'year_product': yearProduct,
        'sales_status': salesStatus,
        'view': view,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'file': file,
      };
}
