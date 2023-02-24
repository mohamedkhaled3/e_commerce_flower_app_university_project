import 'package:e_commerce_flower_app_university_project/screens/forgot_password.dart';
import 'package:e_commerce_flower_app_university_project/screens/home.dart';
import 'package:e_commerce_flower_app_university_project/screens/register.dart';
import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:e_commerce_flower_app_university_project/shared/constants.dart';
import 'package:e_commerce_flower_app_university_project/shared/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool IsVisibility_password = false;
  bool IsLoading = false;
  final emailController = TextEditingController();
  // 1😍 Handle changes to a text field
  final passwordController = TextEditingController();
  // 1😎 Handle changes to a text field
  signIn() async {
    setState(() {
      IsLoading = true;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, // 3😍 Handle changes to a text field
        password: passwordController.text, // 3😎 Handle changes to a text field
      );
      // showSnackBar(context, 'Done ...');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, 'ERROR ..... : ${e.code}');
    }
    setState(() {
      IsLoading = false;
    });
  }

  // 4😎 Handle changes to a text field
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: Text("Sign in"),
      ),
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 64,
              ),
              TextField(
                  controller:
                      emailController, // 2😎 Handle changes to a text field
                  keyboardType:
                      TextInputType.emailAddress, // shape of keyboard
                  obscureText:false ,
                  //copyWith(hintText: "Enter Your Passaword",) to add a new "ميزة"
                  decoration: decorationTextField.copyWith(
                      hintText: "Enter Your Email" ,
                      suffixIcon: Icon(
                      Icons.email,
                        ),
                      )),
              const SizedBox(
                height: 33,
              ),
              TextField(
                  controller:
                      passwordController, // 2😎 Handle changes to a text field
                  keyboardType: TextInputType.text, // shape of keyboard
                  obscureText:  IsVisibility_password
                          ? false
                          : true, // text not password ***, // text not password ***
                  decoration: decorationTextField.copyWith(
                    hintText: "Enter Your Passaword",
                    suffixIcon: IconButton(
                    icon: IsVisibility_password
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              IsVisibility_password = !IsVisibility_password;
                            });
                          },
                        ),
                  )),
              const SizedBox(
                height: 33,
              ),
              ElevatedButton(
                onPressed: () async {
                  await signIn(); // await to wait finish it first then showSnackBar()

// we use it in main to make user go to Home_page automatically when login
                  // if (!mounted) return; // this good for performance  //  "https://dart-lang.github.io/linter/lints/use_build_context_synchronously.html"
                  // //Navigate to a new screen and back "Login" without routes
                  // Navigator.pushReplacement(
                  //   // we dont use "push" we use pushReplacement to make pop "delete" for login stack automatically
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Home()),
                  // );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(BTNgreen),
                  padding:
                      MaterialStateProperty.all(const EdgeInsets.all(12)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                ),
                child: const Text(
                  "Sign in",
                  style: TextStyle(fontSize: 19),
                ),
              ),
                const SizedBox(
                height: 7,
              ),
              TextButton(onPressed: (){
                          Navigator.push(
                        // pushReplacement to make pop "delete" for login stack automatically but push to let user can back again
                        context, ////Navigate to a new screen and back "Sign up" without routes
                        MaterialPageRoute(builder: (context) => ForgotPassword()),
                      );
              }
              , child: Text("Forgot password ?" , style: TextStyle(fontSize: 18,decoration: TextDecoration.underline),)
              
              ),  

              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Do nor have an account?",
                      style: TextStyle(fontSize: 20)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        // pushReplacement to make pop "delete" for login stack automatically
                        context, ////Navigate to a new screen and back "Sign up" without routes
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: IsLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Sign up',
                            style:
                                TextStyle( fontSize: 20,decoration: TextDecoration.underline)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
