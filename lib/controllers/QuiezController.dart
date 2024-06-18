import 'dart:convert';

import 'package:get/get.dart';
import 'package:kotlinproj/screens/Exercise.dart';
import 'package:http/http.dart' as http;

import '../classes/UserService.dart';
import 'TokenService.dart';
class Problem {
  final String questionText;
  final String answer; // This might be unused in Dart code, depends on your implementation.
  final List<String> correctAnswers;
  final int marks;

  Problem({
    required this.questionText,
    required this.answer,
    required this.correctAnswers,
    this.marks = 1, // Default value if not specified
  });
  Map<String, dynamic> toJson() {
    return {
      'questiontext': questionText,
      'answer': answer,
      'correctanswers': correctAnswers,
      'marks': marks,
    };
  }
  factory Problem.fromJson(Map<String, dynamic> json) {
    return Problem(
      questionText: json['questiontext'],
      answer: json['answer'], // Assuming this field holds a possible answer or explanation.
      correctAnswers: List<String>.from(json['correctanswers']),
      marks: json['marks'] ?? 1,
    );
  }
}

class Quiz {
  final String name;
  final String description;
  final List<Problem> problems;
  final int time; // This will store the quiz duration in minutes
  late int totalMarks; // Now this is not final and not required at construction time

  Quiz({
    required this.name,
    required this.description,
    required this.problems,
    required this.time,
  });

  // A method to update totalMarks when it's computed by the backend
  void setTotalMarks(int marks) {
    totalMarks = marks;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'problems': problems.map((p) => p.toJson()).toList(),
      'time': time,
    };
  }

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      name: json['name'],
      time: json['time'],
      description: json['description'],
      problems: List<Problem>.from(json['problems'].map((p) => Problem.fromJson(p))),
    );
  }
}

class QuizController extends GetxController {
  var currentProblemIndex = 0.obs;
  var selectedAnswers = <String?>[].obs;
  var totalScore = 0.obs;
  final TokenService _tokenService = TokenService();
  late Quiz quiz;
  final UserService userService = Get.find();


  void loadQuiz(Quiz newQuiz) {
    quiz = newQuiz;
    selectedAnswers.value = List.filled(quiz.problems.length, null);
    currentProblemIndex.value = 0;
    calculateTotalScore();
  }

  Future<void> fetchQuiz(String id) async {
    var url = Uri.http('192.168.1.109:3000', '/api/v1/Teacher/quiz/$id');
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body); // Decode the JSON response
      Quiz fetchedQuiz = Quiz.fromJson(decodedResponse); // Parse the JSON into a Quiz object
      loadQuiz(fetchedQuiz);
      Get.to(()=>Exercise());// Load the fetched quiz into the controller
      print("Quiz loaded successfully.");
    } else if (response.statusCode == 404) {
      print('Quiz not found');
    } else {
      print('Failed to fetch quiz');
    }
  }

  void selectAnswer(int problemIndex, String selectedAnswer) {
    selectedAnswers[problemIndex] = selectedAnswer;
    calculateTotalScore();
  }

  void calculateTotalScore() {
    int score = 0;
    for (int i = 0; i < quiz.problems.length; i++) {
      if (selectedAnswers[i] != null && quiz.problems[i].answer ==  selectedAnswers[i]) {
        score += quiz.problems[i].marks; // Add marks to score
      }
    }
    totalScore.value = score; // Update the total score
  }

  void nextProblem() {
    if (currentProblemIndex.value < quiz.problems.length - 1) {
      currentProblemIndex.value++;
    }
  }

  void prevProblem() {
    if (currentProblemIndex.value > 0) {
      currentProblemIndex.value--;
    }
  }
  void jumpToQuestion(int index) {
    if (index >= 0 && index < quiz.problems.length) {
      currentProblemIndex.value = index; // Update the current problem index to the new value
    }
  }
  void editPoints(int points) async
  {
    String? token = await _tokenService.getToken();


    var url = Uri.http('192.168.1.109:3000', '/api/v1/User/editPoints');


    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "token": "$token",
      },
      body: json.encode({'points':points}),
    );

    if (response.statusCode == 200) {
      print("here");
          userService.user.value!.points +=10;
    } else {
      print('Points not added');
    }
  }
  @override
  void onInit() {
    super.onInit();

  }
}
