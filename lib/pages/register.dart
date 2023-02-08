import 'package:e_commerce_flower_app_university_project/pages/login.dart';
import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:e_commerce_flower_app_university_project/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool IsLoading = false;
  final emailController =
      TextEditingController(); // 1😍 Handle changes to a text field
  final PasswordController =
      TextEditingController(); // 1😎 Handle changes to a text field

// لإنشاء حساب مستخدم جديد بكلمة مرور  by connection to firebase
  register() async {
    setState(() {
      IsLoading = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, // 3😍 Handle changes to a text field
        password: PasswordController.text, // 3😎 Handle changes to a text field
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      IsLoading = false;
    });
  }

// 4 😍😎 Handle changes to a text field
//stop listening when the widget is deleted."increase preformance"
  @override
  void dispose() {
    emailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 64,
                  ),
                  TextField(
                      keyboardType:
                          TextInputType.emailAddress, // shape of keyboard
                      obscureText: false, // text not password ***
                      //copyWith(hintText: "Enter Your Passaword",) to add a new "ميزة"
                      decoration: decorationTextField.copyWith(
                          hintText: "Enter Your User Name :")),
                  const SizedBox(
                    height: 33,
                  ),
                  TextField(
                      controller:
                          emailController, // 2😍 Handle changes to a text field
                      keyboardType:
                          TextInputType.emailAddress, // shape of keyboard
                      obscureText: false, // text not password ***
                      //copyWith(hintText: "Enter Your Passaword",) to add a new "ميزة"
                      decoration: decorationTextField.copyWith(
                          hintText: "Enter Your Email")),
                  const SizedBox(
                    height: 33,
                  ),
                  TextField(
                      controller:
                          PasswordController, // 2😎 Handle changes to a text field
                      keyboardType: TextInputType.text, // shape of keyboard
                      obscureText: true, // text not password ***
                      decoration: decorationTextField.copyWith(
                        hintText: "Enter Your Passaword",
                      )),
                  const SizedBox(
                    height: 33,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      register();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BTNgreen),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    // child: const Text("Register",style: TextStyle(fontSize: 19),  ), // false
                    // child: CircularProgressIndicator(color: Colors.white,), // to make ⏱ Loadin_shape // true 
                    child: IsLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Register",
                            style: TextStyle(fontSize: 19),
                          ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Do nor have an account?",
                          style: TextStyle(fontSize: 20)),
                      TextButton(
                        onPressed: () {
                          //Navigate to a new screen and back "Login" without routes
                          Navigator.pushReplacement(
                            // we dont use "push" we use pushReplacement to make pop "delete" for login stack automatically
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        child: const Text('Sign in',
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
