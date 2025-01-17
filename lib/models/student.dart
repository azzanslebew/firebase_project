class Student {
  String? id;
  String name;
  String grade;
  int age;

  Student({
    this.id,
    required this.name,
    required this.grade,
    required this.age,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'grade': grade,
      'age': age,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json, String id) {
    return Student(
      id: id,
      name: json['name'] ?? '',
      grade: json['grade'] ?? '',
      age: json['age'] ?? 0,
    );
  }
}