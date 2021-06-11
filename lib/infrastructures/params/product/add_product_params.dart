import '../../models/product_master/body_type.dart';
import '../../models/product_master/brand.dart';
import '../../models/product_master/car_color.dart';
import '../../models/product_master/fuel_type.dart';
import '../../models/product_master/transmission.dart';
import '../../models/product_master/variant.dart';

class AddProductParams {
  final String title;
  final String price;
  final String type;
  final Brand brand;
  final Variant variant;
  final CarColor color;
  final BodyType bodyType;
  final FuelType fuelType;
  final Transmission transmission;
  final String year;
  final String kilometers;
  final String descriptionTitle;
  final String description;

  AddProductParams({
    required this.title,
    required this.price,
    required this.type,
    required this.brand,
    required this.variant,
    required this.color,
    required this.bodyType,
    required this.fuelType,
    required this.transmission,
    required this.year,
    required this.kilometers,
    required this.descriptionTitle,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'type': type,
      'brand_id': brand.id,
      'variant_id': variant.id,
      'color_id': color.id,
      'body_type_id': bodyType.id,
      'fuel_type_id': fuelType.id,
      'transmission_id': transmission.id,
      'year_product': year,
      'kilometer': kilometers,
      'description_title': descriptionTitle,
      'description': description,
    };
  }
}
