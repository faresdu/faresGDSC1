class SocialMedia {
  final String id;
  final String name;
  final String image;

  SocialMedia({
    required this.id,
    required this.name,
    required this.image,
  });
  factory SocialMedia.fromJson(Map<String, dynamic> map) {
    return SocialMedia(
      id: map['social_id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
