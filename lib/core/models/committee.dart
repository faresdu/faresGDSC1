class Committee {
  final String id;
  final String name;
  final String? leaderID;
  final String? coLeaderID;
  Committee(
      {required this.id, required this.name, this.leaderID, this.coLeaderID});

  factory Committee.anonymous() {
    return Committee(id: '', name: '');
  }
  factory Committee.fromJson(Map<String, dynamic> map) {
    return Committee(
        id: map['committee_id'] ?? '',
        name: map['committee_name'] ?? '',
        leaderID: map['leader_id'] ?? '',
        coLeaderID: map['co_leader_id'] ?? '');
  }
}
