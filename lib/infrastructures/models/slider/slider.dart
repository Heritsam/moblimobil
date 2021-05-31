class SliderBannerResponse {
  SliderBannerResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final List<SliderBanner> data;

  factory SliderBannerResponse.fromJson(Map<String, dynamic> json) =>
      SliderBannerResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data: List<SliderBanner>.from(
            json['data'].map((x) => SliderBanner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SliderBanner {
  SliderBanner({
    required this.id,
    required this.judul,
    required this.file,
    required this.urutan,
  });

  final int id;
  final String judul;
  final String file;
  final String urutan;

  factory SliderBanner.fromJson(Map<String, dynamic> json) => SliderBanner(
        id: json['id'],
        judul: json['judul'],
        file: json['file'],
        urutan: json['urutan'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'judul': judul,
        'file': file,
        'urutan': urutan,
      };
}
