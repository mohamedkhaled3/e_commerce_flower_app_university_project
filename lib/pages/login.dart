
import 'package:e_commerce_flower_app_university_project/shared/custom-textfield.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(22),
          child: Column(
            children: [
              Text("data"),
              SizedBox(
                height: 94,
              ),
              MyTextField(hinttextttt: 'Enter Your Email', ispassward: false, keyboardTypeeee:TextInputType.emailAddress ,),
              SizedBox(
                height: 33,
              ),
              MyTextField(hinttextttt: 'Enter Your Passward', ispassward: true, keyboardTypeeee: TextInputType.text,),
           
            ],
          ),
        ),
      ),
    );
  }
}