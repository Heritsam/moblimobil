import 'product_recommend.dart';

class Product {
  Product({
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
    this.cityId,
    required this.userFullname,
    required this.userFile,
    this.userPhone,
    required this.brandName,
    required this.variantName,
    required this.bodyTypeName,
    required this.fuelTypeName,
    required this.transmissionName,
    required this.colorName,
    required this.file,
    required this.productRecommend,
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
  final String? cityId;
  final String userFullname;
  final String userFile;
  final String? userPhone;
  final String brandName;
  final String variantName;
  final String bodyTypeName;
  final String fuelTypeName;
  final String transmissionName;
  final String colorName;
  final List<ProductFile> file;
  final List<ProductRecommend> productRecommend;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        cityId: json['city_id'] != null ? json['city_id'] : null,
        userFullname: json['user_fullname'],
        userFile: json['user_file'],
        userPhone: json['user_phone'] != null ? json['user_phone'] : null,
        brandName: json['brand_name'],
        variantName: json['variant_name'],
        bodyTypeName: json['body_type_name'],
        fuelTypeName: json['fuel_type_name'],
        transmissionName: json['transmission_name'],
        colorName: json['color_name'],
        file: List<ProductFile>.from(
            json['file'].map((x) => ProductFile.fromJson(x))),
        productRecommend: json['product_recomend'] != null
            ? List<ProductRecommend>.from(json['product_recomend']
                .map((x) => ProductRecommend.fromJson(x)))
            : [],
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
        'city_id': cityId,
        'user_fullname': userFullname,
        'user_file': userFile,
        'user_phone': userPhone,
        'brand_name': brandName,
        'variant_name': variantName,
        'body_type_name': bodyTypeName,
        'fuel_type_name': fuelTypeName,
        'transmission_name': transmissionName,
        'color_name': colorName,
        'file': List<dynamic>.from(file.map((x) => x.toJson())),
      };
}

class ProductFile {
  ProductFile({
    required this.id,
    required this.file,
  });

  final int id;
  final String file;

  factory ProductFile.fromJson(Map<String, dynamic> json) => ProductFile(
        id: json['id'],
        file: json['file'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'file': file,
      };
}
