import 'package:auth_page_api/auth/controller/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  final SignInController signInController = Get.put(SignInController());
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter first name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
            TextField(
              controller: signInController.firstnameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter first name",
              ),
              maxLines: 1,
            ),
            SizedBox(height: 10,),
            Text("Enter last name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
            TextField(
              controller: signInController.lastnameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter last name",
              ),
              maxLines: 1,
            ),
            SizedBox(height: 10,),
            Text("Enter email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
            TextField(
              controller: signInController.emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter email",
              ),
              maxLines: 1,
            ),
            SizedBox(height: 10,),
            Text("Enter password",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
            TextField(
              controller: signInController.passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter pass",
              ),
              maxLines: 1,
            ),
            SizedBox(height: 20,),
            Center(
              child: ElevatedButton(onPressed: () async {
                await signInController.registerWithEmail();
              },
                  child: Text("Sign Up")),
            )
          ],
        ),
      ),
    );
  }
}
