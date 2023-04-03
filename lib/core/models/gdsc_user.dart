import 'package:gdsc_app/core/models/committee.dart';

class GDSCUser {
  final String id;
  final String name;
  final String email;
  // final Committee committee;
  final String mStatus;
  final bool isAdmin;

  GDSCUser(
      {required this.id,
      required this.name,
      required this.email,
      // required this.committee,
      required this.mStatus,
      this.isAdmin = false});

  factory GDSCUser.anonymous() {
    return GDSCUser(
        id: '',
        name: '',
        email: '',
        // committee: Committee.anonymous(),
        mStatus: '');
  }

  factory GDSCUser.fromJson(Map<String, dynamic> map) {
    return GDSCUser(
        id: map['user_id'] ?? '',
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        // committee: map['committee'] ?? '',
        mStatus: map['mStatus'] ?? '',
        isAdmin: map['isAdmin'] ?? false);
  }
}
