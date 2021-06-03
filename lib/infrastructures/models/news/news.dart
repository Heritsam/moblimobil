class News {
  News({
    required this.id,
    required this.categoryId,
    required this.type,
    required this.typeFile,
    required this.title,
    required this.description,
    required this.file,
    this.linkYoutube,
    required this.view,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String categoryId;
  final String type;
  final String typeFile;
  final String title;
  final String description;
  final String file;
  final String? linkYoutube;
  final String view;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json['id'],
        categoryId: json['category_id'],
        type: json['type'],
        typeFile: json['type_file'],
        title: json['title'],
        description: json['description'],
        file: json['file'],
        linkYoutube: json['link_youtube'] == null ? null : json['link_youtube'],
        view: json['view'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'category_id': categoryId,
        'type': type,
        'type_file': typeFile,
        'title': title,
        'description': description,
        'file': file,
        'link_youtube': linkYoutube == null ? null : linkYoutube,
        'view': view,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}
