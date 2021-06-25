class MobliNotif {
  MobliNotif({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.isRead,
  });

  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final bool? isRead;

  factory MobliNotif.fromJson(Map<String, dynamic> json) => MobliNotif(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        createdAt: DateTime.parse(json['created_at']),
        isRead: json['is_read'] != null ? json['is_read'] : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'created_at': createdAt.toIso8601String(),
        'is_read': isRead,
      };
}
