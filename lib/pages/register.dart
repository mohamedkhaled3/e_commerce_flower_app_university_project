import 'package:e_commerce_flower_app_university_project/pages/login.dart';
import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:e_commerce_flower_app_university_project/shared/constants.dart';
import 'package:flutter/material.dart';


class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(22),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 64,
                  ),
                  TextField(
                      keyboardType:
                          TextInputType.emailAddress, // shape of keyboard
                      obscureText: false, // text not password ***
                      //copyWith(hintText: "Enter Your Passaword",) to add a new "ميزة"
                      decoration: decorationTextField.copyWith(
                          hintText: "Enter Your User Name :")),
                  SizedBox(
                    height: 33,
                  ),
                  TextField(
                      keyboardType:
                          TextInputType.emailAddress, // shape of keyboard
                      obscureText: false, // text not password ***
                      //copyWith(hintText: "Enter Your Passaword",) to add a new "ميزة"
                      decoration: decorationTextField.copyWith(
                          hintText: "Enter Your Email")),
                  SizedBox(
                    height: 33,
                  ),
                  TextField(
                      keyboardType: TextInputType.text, // shape of keyboard
                      obscureText: true, // text not password ***
                      decoration: decorationTextField.copyWith(
                        hintText: "Enter Your Passaword",
                      )),
                  SizedBox(
                    height: 33,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BTNgreen),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Do nor have an account?",
                          style: TextStyle(fontSize: 20)),
                      TextButton(
                        onPressed: () { //Navigate to a new screen and back "Login" without routes
                          Navigator.pushReplacement( // we dont use "push" we use pushReplacement to make pop "delete" for login stack automatically 
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        child: Text('Sign in',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}