import 'dart:convert';
import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kotlinproj/screens/paymentScreen.dart';
import '../controllers/TokenService.dart';
import 'CourseClass.dart';
import 'QuizViewModel.dart';
import 'TeacherClass.dart';
import 'UserClass.dart';

class UserService extends GetxService {
  var user = Rxn<User>(); // Replace `User` with your user class
  var teacher = Rxn<Teacher>(); // Replace `Teacher` with your teacher class
  RxList<Course> courses = <Course>[].obs;

  RxList<QuizViewModel> quizes = <QuizViewModel>[].obs;
  final TokenService _tokenService = TokenService();
  // Function to initialize user data
  void setUser(User userData) {
    user.value = userData;
  }

  // Function to initialize teacher data
  void setTeacher(Teacher teacherData) {
    teacher.value = teacherData;
  }

  void addCourses(List<Course> coursesList) {
    courses.addAll(coursesList);
  }

  List<Course> getCourses() {
    return courses.toList();
  }

  List<QuizViewModel> getQuizes() {
    return quizes.toList();
  }

  Future<void> fetchQuizzes() async {
    var url = Uri.http('192.168.1.109:3000', '/api/v1/Teacher/quizzes');
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      quizes.value = List<QuizViewModel>.from(
          jsonResponse.map((model) => QuizViewModel.fromJson(model)));
    } else if (response.statusCode == 404) {
      print('Quizzes not found');
    } else {
      print('Failed to fetch quizzes');
    }
  }
  Future<List<Course>> fetchSubedCourses() async {
    List<Course> filteredCourses = [];

    String? token = await _tokenService.getToken();
    var url = Uri.http('192.168.1.109:3000', '/api/v1/User/viewSubscribedCourses');
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "token": "$token"
      },
    );

    if (response.statusCode == 200) {
      // Parse the response body
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Extract subscribed course IDs
      List<String> subscribedCourseIds = (responseBody['subscribedCourses'] as List)
          .map((course) => course['courseId'].toString())
          .toList();

      // Filter courses based on subscribed course IDs
      filteredCourses = courses.where((course) => subscribedCourseIds.contains(course.id)).toList();
    } else if (response.statusCode == 404) {
      print('No subscriptions found for the user');
    } else {
      print('Failed to fetch subscribed courses');
    }

    return filteredCourses;
  }
  Future<void> fetchCourses() async {
    var url = Uri.http('192.168.1.109:3000', '/api/v1/Teacher/courses');
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      String responseBody = response.body;

      // Parse the JSON string into a Dart object
      Map<String, dynamic> jsonResponse = json.decode(responseBody);
      // Access the 'courses' array from the response
      List<dynamic> coursesJson = jsonResponse['courses'];

      // Create a list to store Course objects
      List<Course> fetchedCourses = [];

      // Iterate over the 'courses' array and convert each item to a Course object
      coursesJson.forEach((courseJson) {
        // Create a Course object from the JSON data and add it to the list
        fetchedCourses.add(Course.fromJson(courseJson));
      });

      // Update the courses list with the fetched courses
      courses.assignAll(fetchedCourses);
    } else if (response.statusCode == 404) {
      courses.clear();
      print(response.body);
    } else {
      print('Failed to Fetch courses');
    }
  }

  dynamic createPaymentIntent(String amount, String currency) async {
    String body = json.encode({
      'amount': amount,
      'currency':currency,
    });
    try {

      final response = await http.post(
        Uri.parse('http://192.168.1.109:3000/api/v1/User/payment'),
        body: body,
        headers: {
          "Content-Type": "application/json",
        },
      );
      return jsonDecode(response.body);
    } catch (err) {
       print(err);
    }
  }

  Future<void> makePayment(BuildContext context,int ammount ,String Id) async {
    int Ammount = ammount*100;
    try
        {
          final paymentIntentData = await createPaymentIntent(Ammount.toString(), "USD") ?? {};
          print(paymentIntentData);
          await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData['client_secret'],
            style: ThemeMode.light,
            customFlow: false,
            merchantDisplayName: 'Haris',
          ),
          ).then((value) {

            displayPaymentSheet(context,Id);
          });

        }catch(err)
    {
      print(err);
    }
  }
  void displayPaymentSheet(BuildContext context,String Id)async
  {
    try
        {
          await Stripe.instance.presentPaymentSheet().then((value) async {
            String? token = await _tokenService.getToken();
            var url = Uri.http('192.168.1.109:3000', '/api/v1/User/subscribeToCourse');
            String jsonData = json.encode({
              'courseId':Id ,
              'flag':1,
            });
            var response = await http.post(
                url,
                headers: {
                  "Content-Type": "application/json",
                  "token": "$token"
                },
                body: jsonData
            );
            var decodedResponse = json.decode(response.body);
            print(decodedResponse);
            if (decodedResponse['message'] == 'Subscription successful' )
            {
              Get.to(PaymentScreen());
            }



          }).onError((error, stackTrace) {

            throw  Exception(error);
          });
        }  catch (e)
    {
      print('error Stripe --> $e');
    }
  }
}
