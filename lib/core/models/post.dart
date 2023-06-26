import 'package:gdsc_app/core/models/committee.dart';
import 'package:gdsc_app/core/utils/string_extensions.dart';

class Post {
  final String id;
  final String posterId;
  final String posterName;
  final String? posterProfilePicture;
  final String content;
  final Committee? committee;
  final List<String>? likerIds;
  int likes;
  final DateTime createdAt;

  Post({
    this.committee,
    required this.id,
    required this.posterId,
    required this.posterName,
    this.posterProfilePicture,
    required this.content,
    this.likerIds,
    required this.likes,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> map) {
    List<String> likers = [];
    if (map["likers"] != null && (map['likers'] as List).isNotEmpty) {
      likers = (map["likers"] as List).map((e) {
        return e.toString();
      }).toList();
    }
    return Post(
        id: map['id'] ?? '',
        posterId: map['poster_id'] ?? '',
        posterName: map['poster_name'] ?? '',
        posterProfilePicture: map['poster_profile_picture'] ?? '',
        content: map['content'] ?? '',
        likerIds: likers,
        likes: map['likes'] != null ? map['likes'].toString().parseInt : 0,
        committee: map['Committees'] == null
            ? null
            : Committee.fromJson(map['Committees']),
        createdAt:
            DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.utc(1900));
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "poster_id": posterId,
      "poster_name": posterName,
      "poster_profile_picture": posterProfilePicture,
      "content": content,
      "likers": likerIds,
      "likes": likes,
      "created_at": createdAt
    };
  }
}
