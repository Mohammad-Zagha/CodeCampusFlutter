import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kotlinproj/classes/UserService.dart';
import 'package:kotlinproj/controllers/QuiezController.dart';

class QuizCard extends StatelessWidget {
  final String quizName;
  final String disc;
  final String totalMarks;
  final int totalTime; // Total time in seconds
  final String id;

  const QuizCard({
    super.key,
    required this.quizName,
    required this.disc,
    required this.totalMarks,
    required this.totalTime,
    required this.id,
  });

  String formatDuration(int seconds) {
    int days = seconds ~/ 86400;
    int hours = (seconds % 86400) ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String daysStr = days > 0 ? '${twoDigits(days)}:' : '';
    return "$daysStr${twoDigits(hours)}:${twoDigits(minutes)}";
  }
  List<Color> getRandomGradient() {
    final Random random = Random();
    List<Color> colors = [
      Colors.green.shade300,
      Colors.blue.shade700,
      Colors.cyan,
      Colors.purple.shade500,
      Colors.teal,
    ];

    // Shuffle colors and take two
    colors.shuffle();
    return [colors[random.nextInt(colors.length)], colors[random.nextInt(colors.length)]];
  }


  @override
  Widget build(BuildContext context) {
    String formattedTime = formatDuration(totalTime);
    List<Color> gradientColors = getRandomGradient();
    final QuizController quizController = Get.put(QuizController());
    return GestureDetector(
      onTap: (){
        quizController.fetchQuiz(id);
      },
      child: Container(
        width: 320,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quizName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          fontFamily: 'Helvetica-rounded',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        disc,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Total Marks: $totalMarks',
                        style: TextStyle(
                          fontFamily: 'Helvetica-rounded',
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Duration: $formattedTime',
                        style: TextStyle(
                          fontFamily: 'Helvetica-rounded',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.library_books, color: Colors.blue.shade800, size: 30),
                ),
                Icon(Icons.navigate_next, color: Colors.white70, size: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

