class Teacher {
  final String id;
  final String teacherName;
  final String email;
  final String password; // Assuming that this field should be included
  final int experience;
  final String nationality;
  final int age;
  final String gender;
  final String phone;
  final bool confirmEmail;
  final String mainImage;
  // `sendcode` field is omitted since it's null and its type is unclear
  final String createdAt;
  final String updatedAt;
  // __v is typically a version key used by MongoDB, it's often omitted in model classes

  Teacher({
    required this.id,
    required this.teacherName,
    required this.email,
    required this.password,
    required this.experience,
    required this.nationality,
    required this.age,
    required this.gender,
    required this.phone,
    required this.confirmEmail,
    required this.mainImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json["_id"],
      teacherName: json["teacherName"],
      email: json["email"],
      password: json["password"],
      experience: int.tryParse(json["Experience"]) ?? 0, // Parses string to int
      nationality: json["nationality"],
      age: json["age"],
      gender: json["gender"],
      mainImage: json['mainImage'],
      phone: json["phone"],
      confirmEmail: json["confirmEmail"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }
}
