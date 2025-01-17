class Grade {
  String? id;
  String name;

  Grade({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  factory Grade.fromJson(Map<String, dynamic> json, String id) {
    return Grade(
      id: id,
      name: json['name'] ?? '',
    );
  }
}