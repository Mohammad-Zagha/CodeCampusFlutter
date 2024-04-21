class QuizViewModel {
  final String id;
  final int time;
  final String name;
  final String description;
  final int totalMarks;

  QuizViewModel({
    required this.id,
    required this.time,
    required this.name,
    required this.description,
    required this.totalMarks,
  });

  factory QuizViewModel.fromJson(Map<String, dynamic> json) {
    return QuizViewModel(
      id: json['id'],
      time:json['time'],
      name: json['name'],
      description: json['description'],
      totalMarks: json['totalMarks'],
    );
  }
}
