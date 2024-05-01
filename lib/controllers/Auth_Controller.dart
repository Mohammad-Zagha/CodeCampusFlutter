import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kotlinproj/classes/TeacherClass.dart';
import 'package:http/http.dart' as http;

import '../classes/UserClass.dart';
import '../classes/UserService.dart';
import 'TokenService.dart';

class SignInController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TokenService _tokenService = TokenService();
  final UserService userService = Get.find();
  var confirmEmailFirst = false.obs;
  var accountNotFound = false.obs;
  var resendFlag = false.obs;
  var selectedRole = ''.obs; // Using RxString to make it reactive

  void setSelectedRole(String role) {
    selectedRole.value = role;
  }

  @override
  void onClose() {
    // Dispose controllers when not needed anymore to avoid memory leaks
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Method to sign in
  Future<void> signIn() async {
    accountNotFound.value = false;
    // Log the data being sent for debug purposes
    print({
      'email': emailController.text,
      'password': passwordController.text,
    });

    // Determine the URI based on the selected role, without query parameters
    Uri uri;
    if (selectedRole.value == 'Student') {
      uri = Uri.http('192.168.1.109:3000', '/api/v1/user/signin');
    } else {
      uri = Uri.http('192.168.1.109:3000', '/api/v1/teacher/signin');
    }

    // Encode the data to JSON
    String jsonData = json.encode({
      'email': emailController.text,
      'password': passwordController.text,
    });

    try {
      // Make a POST request with the JSON body
      var response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonData,
      );
      var decodedResponse = json.decode(response.body);
      // Log the response body

      if (decodedResponse['message'] ==
              'Please confirm your email first as a user' ||
          decodedResponse['message'] ==
              'Please confirm your email first as a teacher') {
        print(decodedResponse['message']);
        confirmEmailFirst.value = true;
      } else if (decodedResponse['message'] == 'Invalid account for user' ||
          decodedResponse['message'] == 'Invalid account for teacher' ||
          decodedResponse['message'] == 'Invalid password for teacher' ||
          decodedResponse['message'] == 'Invalid password for user') {
        print(decodedResponse['message']);
        accountNotFound.value = true;
      }
      // This should be replaced with the actual token received

      else if(response.statusCode == 200){
        String token = 'codecamps__' + decodedResponse['token'];

        await _tokenService.saveToken(token);
         await fetchData();

        _firestore.collection('users').doc(decodedResponse['id']).set({
          'uid':decodedResponse['id'],
          'name':decodedResponse['name'],
          'image': userService.user.value == null ? userService.teacher.value!.mainImage:userService.user.value!.mainImage

        });
        Get.toNamed('/home');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> reSendOTP() async {
    print({
      'email': emailController.text,
    });

    // Determine the URI based on the selected role, without query parameters
    Uri uri;
    if (selectedRole.value == 'Student') {
      uri = Uri.http('192.168.1.109:3000', '/api/v1/user/sendcode');
    } else {
      uri = Uri.http('192.168.1.109:3000', '/api/v1/teacher/sendcode');
    }

    // Encode the data to JSON
    String jsonData = json.encode({
      'email': emailController.text,
    });

    try {
      // Make a POST request with the JSON body
      var response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonData,
      );
      var decodedResponse = json.decode(response.body);
      // Log the response body
      print(decodedResponse['message'] + selectedRole.value);
    } catch (e) {
      // Show an error if something goes wrong
      Get.snackbar('Error', 'An error occurred',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> confirmEmailByCode() async {

    Uri uri;
    if (selectedRole.value == 'Student') {
      uri = Uri.http('192.168.1.109:3000', '/api/v1/user/userconfirmEmailbycode');
    } else {
      uri = Uri.http('192.168.1.109:3000', '/api/v1/teacher/teacherconfirmEmailbycode');
    }

    String jsonData = json.encode({
      'code': otpController.text,
    });

    try {
      // Make a POST request with the JSON body
      var response = await http.patch(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonData,
      );
      var decodedResponse = json.decode(response.body);
      // Log the response body
      print(decodedResponse['message']);
    } catch (e) {
      // Show an error if something goes wrong
      Get.snackbar('Error', 'An error occurred',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
  Future<void> fetchData() async {
    String? token = await _tokenService.getToken();
    // Determine the URI based on the selected role, without query parameters
    Uri uri;
    if (selectedRole.value == 'Student') {
      uri = Uri.http('192.168.1.109:3000', '/api/v1/user/getuser');
    } else {
      uri = Uri.http('192.168.1.109:3000', '/api/v1/teacher/getteacher');
    }
    try {
      // Make a POST request with the JSON body
      var response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "token": "$token"
        },
      );
      print(response.body);
      var decodedResponse = json.decode(response.body);

      if (selectedRole.value == 'Student') {
        var userInfo = User.fromJson(decodedResponse); // Assuming a fromJson constructor
        Get.find<UserService>().setUser(userInfo);
      } else {

        var teacherInfo = Teacher.fromJson(decodedResponse); // Assuming a fromJson constructor
        Get.find<UserService>().setTeacher(teacherInfo);

      }
    } catch (e) {
      // Show an error if something goes wrong
      Get.snackbar('Error', 'An error occurred',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
