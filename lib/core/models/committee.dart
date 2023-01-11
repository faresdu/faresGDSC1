class Committee {
  final String id;
  final String name;
  Committee({required this.id, required this.name});

  factory Committee.anonymous(){
    return Committee(id: '', name: '');
  }
  factory Committee.fromJson(Map<String, dynamic> map) {
    return Committee(id: map['id'] ?? '', name: map['name'] ?? '');
  }
}
