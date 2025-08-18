import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../views/log_In_screen.dart';

class OtpController extends GetxController {
  var otpCode = ''.obs;
  var timer = 60.obs;
  Timer? countdown;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void getotp (var otp){
    otpCode.value = otp;
  }

  void startTimer() {
    timer.value = 60;
    countdown?.cancel();
    countdown = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timer.value > 0) {
        timer.value--;
      } else {
        t.cancel();
      }
    });
  }

  Future<void> verifyOtp(String email) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse("http://172.252.13.71:5101/api/v1/auth/verify-otp-signup");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var getemail = prefs.getString('email');
      int num = int.parse(otpCode.value);

      // Prepare the request body
      var body = {
        'email': getemail,
        'otp': num,
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
        Get.snackbar("Success", "OTP verified successfully");
        Get.offAll(() => LogInScreen());
      } else {
        // Error while verifying OTP
        final responseBody = jsonDecode(response.body);
        Get.snackbar("Error", responseBody['message'] ?? "Invalid OTP");
        print("Invalid OTP");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> resendCode(String email)async {

    try{
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse("http://172.252.13.71:5101/api/v1/auth/resend-otp-signup");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var getemail = prefs.getString('email');
      // Prepare the request body
      var body = {
        'email': getemail,
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
        // Call to resend OTP
        Get.snackbar("Resent", "New OTP sent to your email");
        startTimer();
      } else {
        // Error while verifying OTP
        final responseBody = jsonDecode(response.body);
        Get.snackbar("Error", responseBody['message'] ?? "Invalid OTP");
        print("Invalid OTP");
      }

    }catch(e){
      Get.snackbar("Error", e.toString());
    }

  }

  @override
  void onClose() {
    countdown?.cancel();
    super.onClose();
  }
}
