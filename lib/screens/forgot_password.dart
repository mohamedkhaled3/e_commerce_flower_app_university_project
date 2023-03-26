import 'package:e_commerce_flower_app_university_project/screens/SignIn.dart';
import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:e_commerce_flower_app_university_project/shared/constants.dart';
import 'package:e_commerce_flower_app_university_project/shared/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//most data in register_class not login_class bec validation

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<
      FormState>(); //😉😉 to make validation when data it wrong "not valid " dont send to fireba
  bool isLoading = false;
  final emailController =
      TextEditingController(); // 1😍 Handle changes to a text field

// إرسال بريد إلكتروني لإعادة تعيين كلمة المرور
  sendPasswordResetEmail() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      if (!mounted) return; // increase performance
      showSnackBar(context, 'Done - Please check ur email');
      //Navigate to a new screen and back "Login" without routes
      Navigator.pushReplacement(
        // we dont use "push" we use pushReplacement to make pop "delete" for login stack automatically
        context, MaterialPageRoute(builder: (context) => const Login()),
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, 'ERROR ..... : ${e.code}');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        elevation: 0,
        backgroundColor: appBarGreen,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: Form(
            //😉😉 to make validation when data it wrong "not valid " dont send to firebase
            key:
                _formKey, //😉😉 to make validation when data it wrong "not valid " dont send to firebase
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Enter your email to reset your password.",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 33,
                ),
                TextFormField(
                    // we use it rather than textField bec. contains validator:..
                    validator: (email) {
                      // "value" is value of textField
                      // we return "null" when something is valid && null mean that 👍

                      // return value != null && !EmailValidator.validate(email)? "Enter a valid email": null; // 🥱🥱 we use regular ex rather than it
                      // .contain() "is true OR false"
                      return email!.contains(RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                          ? null
                          : "Enter a valid email"; // 🥱🥱
                    },
                    //copyWith(hintText: "Enter Your Passaword",) to add a new "ميزة"
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller:
                        emailController, //2😍 Handle changes to a text field
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: decorationTextField.copyWith(
                      hintText: "Enter Your Email : ",
                      suffixIcon: const Icon(
                        Icons.email,
                      ), // "suffixIcon" in right of texstfield
                    )),
                const SizedBox(
                  height: 33,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      sendPasswordResetEmail();
                      //  await register();  // await to wait finish it first then showSnackBar()
                      //   if (!mounted) return;   // this good for performance "https://dart-lang.github.io/linter/lints/use_build_context_synchronously.html"
                      //      //Navigate to a new screen and back "Login" without routes
                      //     Navigator.pushReplacement(
                      //       // we dont use "push" we use pushReplacement to make pop "delete" for login stack automatically
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) =>  Login()),
                      //     );
                    } else {
                      showSnackBar(context, "ERROR");
                    } //😉😉 to make validation when data it wrong "not valid " dont send to firebase && and give us "showSnackBar (ERROR)"
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(bTNgreen),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  // child: const Text("Register",style: TextStyle(fontSize: 19),  ), // false
                  // child: CircularProgressIndicator(color: Colors.white,), // to make ⏱ Loadin_shape // true
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Reset Password",
                          style: TextStyle(fontSize: 19),
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
