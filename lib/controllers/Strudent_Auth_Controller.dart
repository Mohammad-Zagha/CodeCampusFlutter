import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'Auth_Controller.dart';

class StudentAuthController extends GetxController {
  RxBool doneStudentReg = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final SignInController signInController = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();




  Future<void> signUp(Uint8List Image,String mainImageData) async {
    // Printing the text from each controller
    String mainImageBase64 = base64Encode(Image);
    // print({
    //   'email': emailController.text,
    //   'password': passwordController.text,
    //   'username': usernameController.text,
    //   'confirmPassword': confirmPasswordController.text,
    //   'age': ageController.text,
    //   'gender': genderController.text,
    //   'phoneNumber': phoneNumberController.text,
    //   'mainImage':mainImageBase64
    // });
    try {

      var response = await http.post(
        Uri.parse('http://192.168.1.109:3000/api/v1/User/signUp'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
          'name': usernameController.text,
          'age': ageController.text,
          'gender': genderController.text,
          'mainImage':mainImageBase64,
          'mainMimeType':mainImageData

        }),
      );

      if (response.statusCode == 201) {
        doneStudentReg = RxBool(true);
        var jsonResponse = jsonDecode(response.body);
      } else {
        print(jsonDecode(response.body));
        Get.snackbar('Error', 'Failed to signUp', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred', snackPosition: SnackPosition.BOTTOM);
    }

  }

  }
