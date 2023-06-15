class SocialMedia {
  final String id;
  final String name;
  final String image;
  final String username;
  final String? link;

  SocialMedia({
    required this.id,
    required this.name,
    required this.image,
    required this.username,
    this.link,
  });

  factory SocialMedia.anonymous() {
    return SocialMedia(
      id: '',
      name: '',
      image: '',
      username: '',
      link: '',
    );
  }

  factory SocialMedia.fromJson(Map<String, dynamic> map) {
    return SocialMedia(
      id: map['social_id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      username: map['username'] ?? '',
      link: map['link'],
    );
  }
}
