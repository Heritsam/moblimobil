class CityResponse {
  CityResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final List<City> data;

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data: List<City>.from(json['data'].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class City {
  City({
    required this.cityId,
    required this.provinceId,
    required this.cityName,
    required this.postalCode,
  });

  final int cityId;
  final String provinceId;
  final String cityName;
  final String postalCode;

  factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: int.parse(json['city_id']),
        provinceId: json['province_id'],
        cityName: json['city_name'],
        postalCode: json['postal_code'],
      );

  Map<String, dynamic> toJson() => {
        'city_id': cityId,
        'province_id': provinceId,
        'city_name': cityName,
        'postal_code': postalCode,
      };
}
