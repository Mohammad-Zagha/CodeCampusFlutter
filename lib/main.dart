
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:kotlinproj/firebase_options.dart';
import 'package:kotlinproj/screens/EditProfile.dart';
import 'package:kotlinproj/screens/Exercise.dart';
import 'package:kotlinproj/screens/NewSignupStudent.dart';
import 'package:kotlinproj/screens/Settings.dart';
import 'package:kotlinproj/screens/aboutYou.dart';
import 'package:kotlinproj/screens/addCourse.dart';
import 'package:kotlinproj/screens/newHome.dart';
import 'package:kotlinproj/screens/newLoginScreen.dart';
import 'package:kotlinproj/screens/newSignup.dart';
import 'package:kotlinproj/screens/otp.dart';
import 'package:kotlinproj/screens/preSigninScreen.dart';
import 'package:kotlinproj/screens/splashScreen.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:firebase_core/firebase_core.dart';

import 'classes/UserService.dart';
import 'controllers/Auth_Controller.dart';
import 'controllers/addCourseController.dart';

 // Still needed if you're using Provider for state management

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = 'pk_test_51P6zO6BCyb69GFpbwUBrHsZpJqQqYX3dwfZOAQXlcnmGmjjgUWJ0y6pnZMGXoUr1ywfomfEQvKC8KinvRzuggI5Z00wKM1RGmO';
  Get.put(UserService());
  Get.put(AddCourseController());
  Get.put(SignInController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          inputDecorationTheme: FilledOrOutlinedTextTheme(
              radius: 40,
              contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              errorStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              fillColor: Colors.grey.withAlpha(60),
              suffixIconColor: Colors.green,
              prefixIconColor: Color(0xff00E676),
              enabledColor: Colors.transparent,
              focusedColor: Colors.green
          ),
        ),
        initialRoute: '/splash',
        getPages: [
          GetPage(name: '/login', page: () => NewLogin()),
          GetPage(name: '/addcourse', page: () => AddCourse()),
          GetPage(name: '/editprofile', page: () => EditProfile()),
          GetPage(name: '/profile', page: () => ProfileSettings()),
          GetPage(name: '/exercise', page: () => Exercise()),
          GetPage(name: '/presingin', page: () => PreSingin()),
          GetPage(name: '/splash', page: () => Splash()),
          GetPage(name: '/signupTeacher', page: () => newSignupScreen()),
          GetPage(name: '/signupStudent', page: () => NewSignupStudent()),
          GetPage(name: '/home', page: () => Home()),
          GetPage(name: '/about', page: () => Aboutyou()),
          GetPage(name: '/OTP', page: () => OTP()),
          // Add more routes for other screens if needed
        ],
    );
  }
}
