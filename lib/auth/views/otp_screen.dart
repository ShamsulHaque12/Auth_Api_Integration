import 'package:auth_page_api/auth/views/log_In_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/otp_controller.dart';
import '../controller/sign_in_controller.dart';
import 'custom_button.dart';
import 'sign_in_screen.dart';

class OtpScreen extends StatefulWidget {

  String? email ;


  OtpScreen({super.key, this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpController controller = Get.put(OtpController());

  final SignInController controller1 = Get.put(SignInController());

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("user email : ${widget.email.toString()}");
  }

  @override

  Widget build(BuildContext context) {
    // Retrieve email passed from SignInScreen


    return Scaffold(
      backgroundColor: Color(0xFF020819),
      appBar: AppBar(
        backgroundColor: Color(0xFF020819),
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Submit OTP!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Enter a 6 digit OTP sent to",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF848484),
                ),
              ),
              SizedBox(height: 4),
              Text(
                widget.email.toString(), // Display the email passed from SignInScreen
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(height: 15),
              Pinput(
                length: 6,
                onChanged: (value){
                  controller.getotp(value);
                },
                defaultPinTheme: PinTheme(
                  width: 53,
                  height: 62,
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFFFFFFF),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF848484)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 15),
              CustomButton(
                text: "Submit OTP",
                width: double.infinity,
                borderRadius: 4,
                onPressed: () async {
                  await controller.verifyOtp(widget.email.toString()); // Pass email to verifyOtp
                },
                textColor: Colors.white,
                backgroundColor: Color(0xFF8081F2),
              ),
              SizedBox(height: 10),
              Obx(
                    () => TextButton(
                  onPressed: controller.timer.value == 0
                      ? controller.resendCode
                      : null,
                  child: Text(
                    "Resend OTP : (00:${(controller.timer.value)})",
                    style: TextStyle(
                      color: controller.timer.value == 0
                          ? Colors.white
                          : Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      height: 1,
                      color: Colors.white,
                      thickness: 1,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "OR",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Divider(
                      height: 1,
                      color: Colors.white,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Center(
                child: Text(
                  "If you have any account please",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 5),
              InkWell(
                onTap: () {
                  Get.offAll(() => LogInScreen());
                },
                child: Center(
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF8081F2),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF8081F2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
