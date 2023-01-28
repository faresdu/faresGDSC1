class SocialMedia {
  final String id;
  final String name;
  final String image;

  SocialMedia({required this.id, required this.name, required this.image});

  factory SocialMedia.anonymous() {
    return SocialMedia(id: '', name: '', image: '');
  }

  factory SocialMedia.fromJson(Map<String, dynamic> map) {
    return SocialMedia(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        image: map['image'] ?? '');
  }
}
