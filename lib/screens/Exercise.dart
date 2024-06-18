import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';

import '../controllers/QuiezController.dart';

 // Make sure this path is correct

class Exercise extends StatefulWidget {
  Exercise({Key? key}) : super(key: key);

  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  // Initialize your controller
  final quizController = Get.put(QuizController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.greenAccent[700]),
          onPressed: () => Navigator.pop(context),
        ),
        title: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'RobotoMono',
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            children: <TextSpan>[
              TextSpan(text: 'CODE', style: TextStyle(color: Color(0xff00E676))),
              TextSpan(text: ' CAMPUS', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 7),
            child: GFButton(
              onPressed: showResultsDialog,
              size: 28,
              shape: GFButtonShape.pills,
              color: const Color(0xff00E676),
              child: const Text("Done", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircularCountDownTimer(
                key: Key("countdown"),
                duration: quizController.quiz.time,
                initialDuration: 0,
                controller: CountDownController(),
                width: 100,
                height: 150,
                ringColor: Colors.grey[300]!,
                fillColor: Colors.greenAccent[700]!,
                backgroundColor: Colors.grey[500],
                strokeWidth: 20.0,
                strokeCap: StrokeCap.round,
                textStyle: TextStyle(fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.bold),
                // Use HH:mm:ss instead of S and manually format the countdown time.
                textFormat: CountdownTextFormat.HH_MM_SS,
                isReverse: true,
                isReverseAnimation: false,
                isTimerTextShown: true,
                autoStart: true,
                onStart: () => debugPrint('Countdown Started'),
                onComplete: showResultsDialog,
              )

            ),
            Obx(() {
              final currentProblem = quizController.quiz.problems[quizController.currentProblemIndex.value];
              return Column(
                children: [
                  Text(
                    currentProblem.questionText,
                    style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    'Points: ${currentProblem.marks.toString()}',
                    style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey),
                  ),
                  ...List.generate(currentProblem.correctAnswers.length, (index) {
                    String answer = currentProblem.correctAnswers[index];
                    return ListTile(
                      title: Text(answer),
                      leading: Radio<String>(
                        activeColor: Color(0xff00E676),
                        value: answer,
                        groupValue: quizController.selectedAnswers[quizController.currentProblemIndex.value],
                        onChanged: (String? value) {
                          quizController.selectAnswer(quizController.currentProblemIndex.value, value!);
                          print(value);
                        },
                      ),
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GFButton(
                        color: Color(0xff00E676),
                        onPressed: quizController.prevProblem,
                        child: Text('Previous'),
                      ),
                      GFButton(
                        color: Color(0xff00E676),
                        onPressed: quizController.nextProblem,
                        child: Text('Next'),
                      ),
                    ],
                  ),
                  Obx(() => Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4.0,
                    runSpacing: 4.0,
                    children: List.generate(quizController.quiz.problems.length, (index) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: GestureDetector(
                        onTap: () => quizController.jumpToQuestion(index),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: quizController.currentProblemIndex.value == index ? Colors.green : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    )),
                  )),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  void showResultsDialog() {
    quizController.calculateTotalScore(); // Ensure the score is updated

    // Function to fire after the dialog is dismissed
    void onDialogClosed() {
      fireYourRequest(); // Replace this with your actual request function
    }

    showDialog(
      context: context,
      barrierDismissible: true, // This ensures the dialog can be dismissed by clicking outside
      builder: (BuildContext context) {
        final totalMarks = quizController.quiz.problems.fold<int>(
            0, (sum, item) => sum + item.marks);
        return AlertDialog(
          title: const Text('Exercise Done'),
          content: Text(
              'Your final grade is ${quizController.totalScore.value} out of $totalMarks.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // This will close the dialog
              },
            ),
          ],
        );
      },
    ).then((val) {
      onDialogClosed(); // This will be called when the dialog is dismissed
    });
  }
  void fireYourRequest() async{
    quizController.editPoints(10);

  }
}
