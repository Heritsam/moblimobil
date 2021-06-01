class SubDistrictResponse {
  SubDistrictResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final List<Subdistrict> data;

  factory SubDistrictResponse.fromJson(Map<String, dynamic> json) =>
      SubDistrictResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data: List<Subdistrict>.from(
            json['data'].map((x) => Subdistrict.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Subdistrict {
  Subdistrict({
    required this.subdistrictId,
    required this.cityId,
    required this.subdistrictName,
  });

  final String subdistrictId;
  final String cityId;
  final String subdistrictName;

  factory Subdistrict.fromJson(Map<String, dynamic> json) => Subdistrict(
        subdistrictId: json['subdistrict_id'],
        cityId: json['city_id'],
        subdistrictName: json['subdistrict_name'],
      );

  Map<String, dynamic> toJson() => {
        'subdistrict_id': subdistrictId,
        'city_id': cityId,
        'subdistrict_name': subdistrictName,
      };
}
