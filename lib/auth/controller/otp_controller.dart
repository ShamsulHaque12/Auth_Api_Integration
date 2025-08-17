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
      var url = Uri.parse("https://fzjn9pz1-5000.inc1.devtunnels.ms/api/v1/auth/verify-otp-signup");

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

  void resendCode() {
    // Call to resend OTP
    Get.snackbar("Resent", "New OTP sent to your email");
    startTimer(); // Restart the timer
  }

  @override
  void onClose() {
    countdown?.cancel();
    super.onClose();
  }
}
