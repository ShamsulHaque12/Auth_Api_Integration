import 'dart:convert';

import 'package:auth_page_api/auth/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LogInController extends GetxController{
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> logIn(String email, String password) async {
    try{
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse("http://172.252.13.71:5101/api/v1/auth/login");
      // Prepare the request body
      var body = {
        'email': email,
        'password': password,
      };
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      var data = jsonDecode(response.body) ;
      print("status code ${response.statusCode}");
      print("api data : ${data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successfully verified OTP
        Get.snackbar("Success", "LogIn successfully");
        Get.offAll(() => HomeScreen());
      } else {
        // Error while verifying OTP
        final responseBody = jsonDecode(response.body);
        Get.snackbar("Error", responseBody['message'] ?? "Invalid password");
        print("Invalid password");
      }

    }catch(e){
      print("Error : ${e.toString()}");
    }
  }



  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

}