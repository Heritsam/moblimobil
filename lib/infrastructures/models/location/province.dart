class ProvinceResponse {
  ProvinceResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final List<Province> data;

  factory ProvinceResponse.fromJson(Map<String, dynamic> json) =>
      ProvinceResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data:
            List<Province>.from(json['data'].map((x) => Province.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Province {
  Province({
    required this.provinceId,
    required this.provinceName,
  });

  final String provinceId;
  final String provinceName;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        provinceId: json['province_id'],
        provinceName: json['province_name'],
      );

  Map<String, dynamic> toJson() => {
        'province_id': provinceId,
        'province_name': provinceName,
      };
}
