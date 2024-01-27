class Committee {
  final String id;
  final String name;
  final String? leaderID;
  final String? coLeaderID;
  final String? consultantID;
  final String? picture;
  final String? responsibleCommittee;
  Committee(
      {required this.id,
      required this.name,
      this.picture,
      this.leaderID,
      this.coLeaderID,
      this.consultantID,
      this.responsibleCommittee});

  factory Committee.anonymous() {
    return Committee(
      id: '',
      name: '',
    );
  }

  factory Committee.fromJson(Map<String, dynamic> map) {
    return Committee(
        id: map['committee_id'] ?? '',
        name: map['committee_name'] ?? '',
        leaderID: map['leader_id'],
        coLeaderID: map['co_leader_id'],
        consultantID: map['consultant_id'],
        picture: map['picture'],
        responsibleCommittee: map['responsible_committee']);
  }
}
