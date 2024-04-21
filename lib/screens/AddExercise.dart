import 'dart:convert';

import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:material_text_fields/labeled_text_field.dart';
import 'package:material_text_fields/material_text_fields.dart';
import '../controllers/TokenService.dart';
import '../controllers/QuiezController.dart';
import 'package:http/http.dart' as http;
class AddExercise extends StatefulWidget {
  const AddExercise({super.key});

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  final TextEditingController quizNameController = TextEditingController();
  final TextEditingController  quizDescriptionController = TextEditingController();
  final TextEditingController  daysController = TextEditingController();
  final TextEditingController  hoursController = TextEditingController();
  final TextEditingController  minsController = TextEditingController();
  final TextEditingController questionTextController = TextEditingController();
  final TextEditingController answearsController = TextEditingController();
  final TextEditingController realAnswearsController = TextEditingController();
  final TextEditingController marksController = TextEditingController();
  final TokenService _tokenService = TokenService();
  int currentStep = 0;
  int currentAnswear = 1;
  List<Problem> Problems =[];
  List<String> Answears =[];
  String answear = "";

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with "00"
    daysController.text = "00";
    hoursController.text = "00";
    minsController.text = "00";
    // Any other initializations can be done here if necessary
  }
Future<void> uploadQuiz()async{
  String? token = await _tokenService.getToken();
  // Determine the URI based on the selected role, without query parameters
  int days = int.tryParse(daysController.text) ?? 0;
  int hours = int.tryParse(hoursController.text) ?? 0;
  int minutes = int.tryParse(minsController.text) ?? 0;

  int totalTimeInSeconds = (days * 24 * 60 + hours * 60 + minutes) * 60; // Total time in seconds

// Now create the Quiz object with the total time
  Quiz quiz = Quiz(
    name: quizNameController.text,
    description: quizDescriptionController.text,
    problems: Problems,
    time: totalTimeInSeconds, // Pass the calculated time in seconds here
  );
  String quizJson = json.encode(quiz.toJson());
  print(quizJson);
  Uri uri = Uri.http('192.168.1.102:3000', '/api/v1/teacher/addQuiz');

  try {
    // Make a POST request with the JSON body
    var response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "token": "$token"
      },
      body:quizJson
    );
    
    if (response.statusCode == 201) {
      Get.snackbar('Success', 'Quiz uploaded successfully',
          snackPosition: SnackPosition.BOTTOM);
      Get.offNamed('/home');
    } else {
    
      Get.snackbar('Error', 'Failed to upload quiz: }',
          snackPosition: SnackPosition.BOTTOM);
    }
  } catch (e) {
    // Show an error if something goes wrong
    Get.snackbar('Error', 'An error occurred',
        snackPosition: SnackPosition.BOTTOM);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(
          // Update color scheme to affect the stepper's appearance
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.greenAccent[700], // Active step color
            secondary: Colors.greenAccent[700], // Circle outline color
          ),
          iconTheme: IconThemeData(
            size: 20, // Choose a suitable size
            color: Colors.white, // Optional: set icon color
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  "Create a quiz",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      fontSize: 46),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Here you can Create and test your students with test",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                    color: Colors.grey[500]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Stepper(
                type: StepperType.vertical,
                steps: getSteps(),
                currentStep: currentStep,
                onStepContinue: () {
                  if (currentStep == getSteps().length - 1) {
                    // This is the last step, trigger the uploadQuiz function
                    uploadQuiz();
                  } else {
                    // Not the last step, just move to the next step
                    setState(() => currentStep += 1);
                  }
                },
                onStepCancel: () => {setState(() => currentStep -= 1)},
                controlsBuilder: (BuildContext context, ControlsDetails details) {
                  return Row(
                    children: <Widget>[
                      TextButton(
                        onPressed: details.onStepContinue,
                        child: Text('NEXT'),
                      ),
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: Text('CANCEL'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          title: Text(
            "Information",
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 1),
          ),
          content: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                child: LabeledTextField(
                  title: 'Name',
                  labelSpacing: 8,
                  titleStyling: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  textField: MaterialTextField(
                    controller: quizNameController,
                    keyboardType: TextInputType.text,
                    hint: 'Quiz Name',
                    textInputAction: TextInputAction.next,
                    prefixIcon: const Icon(Icons.abc),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: LabeledTextField(
                  title: 'Description',
                  labelSpacing: 8,
                  titleStyling: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  textField: MaterialTextField(
                    controller: quizDescriptionController,
                    keyboardType: TextInputType.text,
                    hint: 'Quiz Description',
                    textInputAction: TextInputAction.next,
                    prefixIcon: const Icon(Icons.description_outlined),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20,left: 20),
                    child: Text("Quiz Time",style:  TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 80,
                        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: TextField(
                          controller: daysController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'days',
                            // Adjust the alignment of hint text as well
                          ),
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          ":",
                          style: TextStyle(
                              fontFamily: 'Helvetica-rounded', fontSize: 30),
                        ),
                      ),
                      Container(
                        width: 80,
                        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: TextField(
                          controller: hoursController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Hours',
                            // Adjust the alignment of hint text as well
                          ),
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          ":",
                          style: TextStyle(
                              fontFamily: 'Helvetica-rounded', fontSize: 30),
                        ),
                      ),
                      Container(
                        width: 80,
                        margin: EdgeInsets.only(top: 5, left: 10, right: 0),
                        child: TextField(
                          controller: minsController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'mins',
                            // Adjust the alignment of hint text as well
                          ),
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
        ),
        Step(
          title: Text(
            "Questions",
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 1),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 30,top: 0,bottom: 5),
                child: Problems.length > 0 ? Row(
                  children: List<Widget>.generate(Problems.length, (index) => Container(
                    width: 10, // Set the size of the dot
                    height: 10, // Set the size of the dot
                    margin: EdgeInsets.symmetric(horizontal: 2), // Space between dots
                    decoration: BoxDecoration(
                      color: Colors.red[400], // Color of the dot
                      shape: BoxShape.circle, // Makes the container circular
                    ),
                  )),
                ) : Container(),
              ),
              Container(
                margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                child: LabeledTextField(
                  title: 'Question text',
                  labelSpacing: 8,
                  titleStyling: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  textField: MaterialTextField(
                    controller: questionTextController,
                    keyboardType: TextInputType.text,
                    hint: 'Text',
                    textInputAction: TextInputAction.next,
                    prefixIcon: const Icon(Icons.description_outlined),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Container(
                    margin: EdgeInsets.only(top: 5, left: 20, right: 10),
                    width: 250,
                    child: LabeledTextField(
                      title: 'Add answears',
                      labelSpacing: 8,
                      titleStyling: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      textField: MaterialTextField(
                        controller: answearsController,
                        keyboardType: TextInputType.text,
                        hint: 'Answear ${currentAnswear}',
                        textInputAction: TextInputAction.next,
                        prefixIcon: const Icon(Icons.description_outlined),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent[700], // Set the background color to white
                      shape: BoxShape.circle, // Optional: Makes the container circular

                    ),
                    child: IconButton(
                      onPressed: (){
                        Answears.add(answearsController.text);
                        answearsController.text = "";
                        setState(() {
                          currentAnswear+=1;
                        });
                      },
                      icon: Icon(Icons.add),
                      color: Colors.white, // Optional: Change the icon color if needed
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 30,top: 5,bottom: 5),
                child: Answears.length > 0 ? Row(
                  children: List<Widget>.generate(Answears.length, (index) => Container(
                    width: 10, // Set the size of the dot
                    height: 10, // Set the size of the dot
                    margin: EdgeInsets.symmetric(horizontal: 2), // Space between dots
                    decoration: BoxDecoration(
                      color: Colors.greenAccent[700], // Color of the dot
                      shape: BoxShape.circle, // Makes the container circular
                    ),
                  )),
                ) : Container(),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                child: LabeledTextField(
                  title: 'Answear',
                  labelSpacing: 8,
                  titleStyling: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  textField: MaterialTextField(
                    controller: realAnswearsController,
                    keyboardType: TextInputType.text,
                    hint: 'Answear',
                    textInputAction: TextInputAction.next,
                    prefixIcon: const Icon(Icons.description_outlined),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                    child: LabeledTextField(
                      title: 'Marks',
                      labelSpacing: 8,
                      titleStyling: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      textField: MaterialTextField(
                        controller: marksController,
                        keyboardType: TextInputType.text,
                        hint: 'Marks',
                        textInputAction: TextInputAction.next,
                        prefixIcon: const Icon(Icons.description_outlined),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 7, top: 28),
                    child: GFButton(
                      onPressed: () {
                        if (questionTextController.text.isNotEmpty && realAnswearsController.text.isNotEmpty && marksController.text.isNotEmpty) {
                          // Creating a new Problem object
                          Problem newProblem = Problem(
                            questionText: questionTextController.text,
                            answer: realAnswearsController.text,
                            correctAnswers: List<String>.from(Answears), // Make sure to capture the current state of Answears
                            marks: int.tryParse(marksController.text) ?? 1, // Safely parse marks, defaulting to 1 if parsing fails
                          );

                          // Adding the new Problem to the Problems list
                          setState(() {
                            Problems.add(newProblem);
                            // Reset fields for the next question
                            questionTextController.clear();
                            realAnswearsController.clear();
                            marksController.clear();
                            Answears.clear();
                            currentAnswear = 1;
                          });

                          print("Problem added. Total problems: ${Problems.length}"); // Optional: log the current state
                        } else {
                          // Optional: Display an error message if fields are missing
                          print("Please fill all fields before adding a new question.");
                        }
                      },
                      size: 28,
                      shape: GFButtonShape.pills,
                      color: const Color(0xff00E676),
                      child: Text(
                        "Next Question",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                ],
              ),

            ],


          ),
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
        ),
        Step(
          title: Text(
            "Complete",
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 1),
          ),
          content: Container(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Quiz Name : ${quizNameController.text}",style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold,fontSize: 18),),
                Text("Quiz Description : ${quizDescriptionController.text}",style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold,fontSize: 18),),
                Text("Time : ${daysController.text} : ${hoursController.text} :${minsController.text}",style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold,fontSize: 18),),
                Text("Number of question : ${Problems.length}",style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold,fontSize: 18),),
              ],
            )
          ),
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
        ),
      ];
}
