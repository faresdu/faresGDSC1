class UserSocialMedia {
  final String? id;
  String? userId;
  final String name;
  final String image;
  final String username;
  final String? link;

  UserSocialMedia({
    this.id,
    required this.name,
    required this.image,
    required this.username,
    this.userId,
    this.link,
  });

  factory UserSocialMedia.anonymous() {
    return UserSocialMedia(
      id: '',
      name: '',
      image: '',
      username: '',
      link: '',
    );
  }

  factory UserSocialMedia.fromJson(Map<String, dynamic> map) {
    return UserSocialMedia(
      id: map['social_id'] ?? '',
      userId: map['user_id'],
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      username: map['username'] ?? '',
      link: map['link'],
    );
  }
  Map<String, dynamic> toJson({toUserSocials = false}) {
    if (toUserSocials) {
      return {
        'social_id': id,
        'user_id': userId,
        'username': username,
        'link': link
      };
    }
    return {
      'social_id': id,
      'user_id': userId,
      'name': name,
      'image': image,
      'username': username,
      'link': link
    };
  }
}
