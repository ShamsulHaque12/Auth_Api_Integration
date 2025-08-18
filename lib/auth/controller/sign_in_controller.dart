import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../views/otp_screen.dart';

class SignInController extends GetxController {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Function to register with email and send OTP
  Future<void> registerWithEmail() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
        "http://172.252.13.71:5101/api/v1/users/register",
      );

      var body = {
        "firstName": firstnameController.text.trim(),
        "lastName": lastnameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      debugPrint(
        "${firstnameController.text} ${lastnameController.text} ${emailController.text} ${passwordController.text}",
      );

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      // Check if the response body is not empty
      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);

        print("status code ${response.statusCode}");
        print("api data: $data");

        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonResponse = jsonDecode(response.body);
          print(jsonResponse.toString());

          print("OTP sent successfully");

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', emailController.text);

          Get.to(OtpScreen(
            email: emailController.text,
          ));

          await prefs.setString('otp', jsonResponse['success']);
        } else {
          // Handle the error response
          final jsonResponse = jsonDecode(response.body);
          Get.snackbar("Error", jsonResponse['message'] ?? 'An error occurred');
        }
      } else {
        // Handle empty response body
        print("Empty response body");
        Get.snackbar("Error", "Received empty response from the server.");
      }
    } catch (e) {
      // General error handling
      Get.snackbar("Errors", e.toString());
      print("Error: ${e.toString()}");
    }
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
