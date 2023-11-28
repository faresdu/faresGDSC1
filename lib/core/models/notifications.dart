class Notifications {
  final String? id;
  final String userId;
  final String title;
  final String name;
  final String? picture;
  final DateTime? createdAt;
  Notifications(
      {this.id,
      required this.userId,
      required this.title,
      required this.name,
      this.picture,
      this.createdAt});

  factory Notifications.fromJson(Map<String, dynamic> map) {
    return Notifications(
      id: map['notification_id'],
      userId: map['user_id'],
      title: map['title'],
      name: map['name'],
      picture: map['picture'],
      createdAt:
          DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.utc(1900),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'title': title,
    };
  }
}
