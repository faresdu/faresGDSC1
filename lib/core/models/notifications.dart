class Notifications {
  final String title;
  final String name;
  final String? picture;
  final DateTime? createdAt;
  Notifications(
      {required this.title, required this.name, this.picture, this.createdAt});

  factory Notifications.fromJson(Map<String, dynamic> map) {
    return Notifications(
        title: map['title'],
        name: map['name'],
        picture: map['picture'],
        createdAt:
            DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.utc(1900));
  }
  Map<String, dynamic> toJson(String id) {
    return {
      'title': title,
      'user_id': id,
    };
  }
}
