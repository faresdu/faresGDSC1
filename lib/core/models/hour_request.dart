class HourRequest {
  final String id;
  final String committeeId;
  final String userId;
  final String? userAvatar;
  final String userName;
  final int hours;
  final String reasoning;
  final bool? approved;
  final String? createdAt;

  HourRequest(
      {required this.id,
      required this.committeeId,
      required this.userId,
      required this.userName,
      required this.hours,
      required this.reasoning,
      this.userAvatar,
      this.approved,
      this.createdAt});

  factory HourRequest.anonymous() {
    return HourRequest(
      id: '',
      committeeId: '',
      userId: '',
      userName: '',
      hours: 0,
      reasoning: '',
    );
  }
}
