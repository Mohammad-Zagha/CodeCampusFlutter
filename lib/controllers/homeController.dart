import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../classes/UserClass.dart';
import 'TokenService.dart';

class HomeController extends GetxController {
  final TokenService _tokenService = TokenService();
  final user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() async {
    try {
      String? token = await _tokenService.getToken();
      var response = await http.get(
        Uri.parse('http://192.168.1.109:3000/api/v1/User/getuser'),
        headers: {
          "Content-Type": "application/json",
          "token": "$token",
        },
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        print(jsonData);
        user.value = User.fromJson(jsonData);
      } else {
        print('Failed to load user data');
        // Handle HTTP errors here
      }
    } catch (e) {
      print('Error fetching user data: $e');
      // Handle exceptions
    }
  }
}