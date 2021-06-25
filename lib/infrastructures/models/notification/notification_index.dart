import 'notification.dart';

class NotificationIndexResponse {
  const NotificationIndexResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.totalNotification,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.data,
  });

  final int code;
  final bool success;
  final String message;
  final int totalNotification;
  final int currentPage;
  final int lastPage;
  final int total;
  final List<MobliNotif> data;

  factory NotificationIndexResponse.fromJson(Map<String, dynamic> json) =>
      NotificationIndexResponse(
        code: json['code'],
        success: json['success'],
        message: json['message'],
        totalNotification: json['total_notif'],
        currentPage: json['current_page'],
        lastPage: json['last_page'],
        total: json['total'],
        data: List<MobliNotif>.from(
            json['data'].map((x) => MobliNotif.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'success': success,
        'message': message,
        'total_notif': totalNotification,
        'current_page': currentPage,
        'last_page': lastPage,
        'total': total,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
