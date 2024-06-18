class User {
  final String id;
  final String userName;
  final String email;
  final int age;
  final String gender;
   int points;
  final int streakLength;
  final bool confirmEmail;
  final String createdAt;
  final String updatedAt;
  final String mainImage;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.age,
    required this.gender,
    required this.points,
    required this.streakLength,
    required this.confirmEmail,
    required this.mainImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      userName: json["userName"],
      email: json["email"],
      age: json["age"],
      gender: json["gender"],
      points: json["points"],
      streakLength: json["streakLength"],
      confirmEmail: json["confirmEmail"],
      mainImage: json["mainImage"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }
}