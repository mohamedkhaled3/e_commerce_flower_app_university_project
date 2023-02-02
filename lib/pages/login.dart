
import 'package:e_commerce_flower_app_university_project/pages/register.dart';
import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:e_commerce_flower_app_university_project/shared/constants.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(  
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column( mainAxisAlignment:  MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 64,
                ),
                TextField(
                    keyboardType: TextInputType.emailAddress, // shape of keyboard
                    obscureText: false, // text not password ***
                    //copyWith(hintText: "Enter Your Passaword",) to add a new "ميزة"
                    decoration: decorationTextField.copyWith(
                        hintText: "Enter Your Email")),
                const SizedBox(
                  height: 33,
                ),
                TextField(
                    keyboardType: TextInputType.text, // shape of keyboard
                    obscureText: true, // text not password ***
                    decoration: decorationTextField.copyWith(
                      hintText: "Enter Your Passaword",
                    )),
                const SizedBox(
                  height: 33,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(BTNgreen),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: const Text(
                    "Sign in",
                    style: TextStyle(fontSize: 19),
                  ),
                ),
                            const SizedBox(
                  height: 33,
                ),
              
    Row( mainAxisAlignment: MainAxisAlignment.center,
      children: [
      const Text("Do nor have an account?",style: TextStyle(fontSize: 20)),
      TextButton(
       onPressed: (){
          Navigator.pushReplacement(   // pushReplacement to make pop "delete" for login stack automatically 
    context,                           ////Navigate to a new screen and back "Sign up" without routes
    MaterialPageRoute(builder: (context) => const Register()),
  );
       },
       child: const Text('Sign up', style: TextStyle(color: Colors.black ,fontSize: 20)),)
    
      ],
    )
    
              ],
            ),
          ),
        ),
      ),
    );
  }
}