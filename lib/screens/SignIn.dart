import 'package:e_commerce_flower_app_university_project/provider/google_signin.dart';
import 'package:e_commerce_flower_app_university_project/screens/forgot_password.dart';
import 'package:e_commerce_flower_app_university_project/screens/home.dart';
import 'package:e_commerce_flower_app_university_project/screens/register(SignUp).dart';
import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:e_commerce_flower_app_university_project/shared/constants.dart';
import 'package:e_commerce_flower_app_university_project/shared/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisibilityPassword = false;
  bool isLoading = false;
  final emailController = TextEditingController();
  // 1😍 Handle changes to a text field
  final passwordController = TextEditingController();
  // 1😎 Handle changes to a text field

  signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      // showSnackBar(context, 'Done ...');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, 'ERROR ..... : ${e.code}');
    }
    setState(() {
      isLoading = false;
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
      final googleSignInProvider =
      Provider.of<GoogleSignInProvider>(context); // Cart is 😍😍 2 provider
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarGreen,
        title: const Text("Sign in"),
      ),
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
                    controller:
                        emailController, // 2😎 Handle changes to a text field
                    keyboardType:
                        TextInputType.emailAddress, // shape of keyboard
                    obscureText: false,
                    //copyWith(hintText: "Enter Your Passaword",) to add a new "ميزة"
                    decoration: decorationTextField.copyWith(
                      hintText: "Enter Your Email",
                      suffixIcon: const Icon(
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
                    obscureText: isVisibilityPassword 
                        ? false
                        : true, // text not password ***, // text not password ***
                    decoration: decorationTextField.copyWith(
                      hintText: "Enter Your Passaword",
                      suffixIcon: IconButton(
                        icon: isVisibilityPassword 
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isVisibilityPassword = !isVisibilityPassword ;
                          });
                        },
                      ),
                    )),
                const SizedBox(
                  height: 33,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await signIn(); // await to wait finish it first then showSnackBa
                    // // we use it in main to make user go to Home_page automatically when login
                    if (!mounted)return; // this good for performance  //  "https://dart-lang.github.io/linter/lints/use_build_context_synchronously.html"
                    // //Navigate to a new screen and back "Login" without routes
                    Navigator.pushReplacement(
                    //   // we dont use "push" we use pushReplacement to make pop "delete" for login stack automatically
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(bTNgreen),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Sign in",
                          style: TextStyle(fontSize: 19),
                        ),
                ),
                const SizedBox(
                  height: 7,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        // pushReplacement to make pop "delete" for login stack automatically but push to let user can back again
                        context, ////Navigate to a new screen and back "Sign up" without routes
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassword()),
                      );
                    },
                    child: const Text(
                      "Forgot password ?",
                      style: TextStyle(
                          fontSize: 18, decoration: TextDecoration.underline),
                    )),
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
                      child: const Text('Sign up',
                          style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 17,
                ),
                SizedBox(
                  width: 299,
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.6,
                        color: Colors.purple[900],
                      )),
                      Text(
                        "OR",
                        style: TextStyle(
                          color: Colors.purple[900],
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.6,
                        color: Colors.purple[900],
                      )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 27),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.purple, width: 1)),
                          child: SvgPicture.asset(
                            "assets/icons/facebook.svg",
                            color: Colors.purple[400],
                            height: 27,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                      GestureDetector(
                        onTap: () {
                          googleSignInProvider.googlelogin();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.purple, width: 1)),
                          child: SvgPicture.asset(
                            "assets/icons/google-plus.svg",
                            color: Colors.purple[400],
                            height: 27,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.purple, width: 1)),
                          child: SvgPicture.asset(
                            "assets/icons/twitter.svg",
                            color: Colors.purple[400],
                            height: 27,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
