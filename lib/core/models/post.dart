import 'dart:convert';

import 'package:gdsc_app/core/utils/string_extensions.dart';

class Post {
  final String id;
  final String posterId;
  final String posterName;
  final String? posterProfilePicture;
  final String content;
  final List<String>? likerIds;
  int likes;
  final DateTime createdAt;

  Post(
      {required this.id,
      required this.posterId,
      required this.posterName,
      this.posterProfilePicture,
      required this.content,
      this.likerIds,
      required this.likes,
      required this.createdAt});

  factory Post.fromJson(Map<String, dynamic> map) {
    return Post(
        id: map['id'] ?? '',
        posterId: map['poster_id'] ?? '',
        posterName: map['poster_name'],
        posterProfilePicture: map['poster_profile_picture'],
        content: map['content'] ?? '',
        likerIds: (map['likers'] as List).map((e) => e.toString()).toList(),
        likes: map['likes'].toString().parseInt,
        createdAt: DateTime.tryParse(map['created_at']) ?? DateTime.utc(1900));
  }
}
