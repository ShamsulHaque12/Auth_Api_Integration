import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/log_in_controller.dart';

class LogInScreen extends StatelessWidget {
  final LogInController logInController = Get.put(LogInController());
  LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 10,),
            Text("Enter email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
            TextField(
              controller: logInController.emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter email",
              ),
              maxLines: 1,
            ),
            SizedBox(height: 10,),
            Text("Enter password",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
            TextField(
              controller: logInController.passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter pass",
              ),
              maxLines: 1,
            ),
            SizedBox(height: 20,),
            Center(
              child: ElevatedButton(onPressed: (){
                logInController.logIn(logInController.emailController.text, logInController.passwordController.text);
              },
                  child: Text("Sign In")),
            )
          ],
        ),
      ),
    );
  }
}
