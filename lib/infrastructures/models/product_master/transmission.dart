class TransmissionResponse {
  TransmissionResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final List<Transmission> data;

  factory TransmissionResponse.fromJson(Map<String, dynamic> json) =>
      TransmissionResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        data: List<Transmission>.from(
            json['data'].map((x) => Transmission.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Transmission {
  Transmission({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  factory Transmission.fromJson(Map<String, dynamic> json) => Transmission(
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
