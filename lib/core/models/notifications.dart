class Notifications {
  final String title;
  final String name;
  final String? picture;

  Notifications({
    required this.title,
    required this.name,
    this.picture,
  });

  factory Notifications.fromJson(Map<String, dynamic> map) {
    return Notifications(
      title: map['title'],
      name: map['name'],
      picture: map['picture'],
    );
  }
  Map<String, dynamic> toJson(String id) {
    return {
      'title': title,
      'user_id': id,
    };
  }
}
