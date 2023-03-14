import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_flower_app_university_project/provider/google_signin.dart';
import 'package:e_commerce_flower_app_university_project/screens/SignIn.dart';
import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:e_commerce_flower_app_university_project/shared/constants.dart';
import 'package:e_commerce_flower_app_university_project/shared/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:email_validator/email_validator.dart'; // 🥱🥱
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart'; // to can make use File as dataType
import 'dart:io'; // to can make use File as dataType
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' show basename; 
import "dart:math";

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool IsVisibility_password = false;
  final _formKey = GlobalKey<
      FormState>(); //😉😉 to make validation when data it wrong "not valid " dont send to firebase
  bool IsLoading = false;
  final emailController =
      TextEditingController(); // 1😍 Handle changes to a text field
  final passwordController =
      TextEditingController(); // 1😎 Handle changes to a text field
  final userNameController =
      TextEditingController(); // 1 Handle changes to a text field
  final ageController =
      TextEditingController(); // 1 Handle changes to a text field
  final titleController =
      TextEditingController(); // 1 Handle changes to a text field
  //Global variable
  File? imgPath;
  String? imgName;
  
  showDialog() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(22),
          color: Colors.amber[100],
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            await uploadImage2Screen(ImageSource.gallery);
                          },
                          child: const Text(
                            "From Gallery",
                            style: TextStyle(fontSize: 16),
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.photo)
                    ],
                  ),
                  SizedBox(
                    width: 22,
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            await uploadImage2Screen(ImageSource.camera);
                          },
                          child: Text(
                            "From Camera",
                            style: TextStyle(fontSize: 16),
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.camera)
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
    ;
  }

// لرفع الصوره للشاشه تابعنا   Function to get img path
  uploadImage2Screen(ImageSource typeOfLoadingPhoto) async {
    final pickedImg = await ImagePicker().pickImage(source: typeOfLoadingPhoto);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
  int random = Random().nextInt(9999999);
  imgName = "$random$imgName";
      print("ــــــــــــــــــــــــــــــــــ");
      print(imgPath);
      print(imgName);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  // لإنشاء حساب مستخدم جديد بكلمة مرور  by connection to firebase// 🥱🥱
  register() async {
    setState(() {
      IsLoading = true;
    });
    try {
      // createUserWithEmailAndPassword
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, // 3😍 Handle changes to a text field
        password: passwordController.text, // 3😎 Handle changes to a text field
      );
      // Upload image to firebase storage
  final storageRef = FirebaseStorage.instance.ref(imgName);
  await storageRef.putFile(imgPath!);  

// to store data in firestore  to dds the new document to your collection "users"
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users
          .doc(credential.user!.uid) // to make document = id(token) ..
          .set({
            'userName':
                userNameController.text, // 3 Handle changes to a text field
            'age': ageController.text, // 3 Handle changes to a text field
            'title': titleController.text, // 3 Handle changes to a text field
            'email': emailController.text, // 3😍 Handle changes to a text field
            'password':
                passwordController.text, // 3😎 Handle changes to a text field
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error")); // error
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        showSnackBar(context, "email-already-in-use");
      } else {
        showSnackBar(context, "ERROR - please Done again later"); // ex offline
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    setState(() {
      IsLoading = false;
    });
  }

  // 4😍 Handle changes to a text field
//stop listening when the widget is deleted."increase preformance" &&  use only StatefulWidget
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    ageController.dispose();
    titleController.dispose();
    super.dispose();
  }

  bool hasUppercase = false;
  bool hasDigits = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;
  bool isPassword8Char = false;

  onPasswordChanged(password) {
    hasUppercase = false;
    hasDigits = false;
    hasLowercase = false;
    hasSpecialCharacters = false;
    isPassword8Char = false;

    setState(() {
      if (password.contains(RegExp(r'[A-Z]'))) {
        hasUppercase = true;
      }
      if (password.contains(RegExp(r'[0-9]'))) {
        hasDigits = true;
      }
      if (password.contains(RegExp(r'[a-z]'))) {
        hasLowercase = true;
      }
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialCharacters = true;
      }
      if (password.contains(RegExp(r'.{8,}'))) {
        isPassword8Char = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider =
        Provider.of<GoogleSignInProvider>(context); // Cart is 😍😍 2 provider
    return Scaffold(
      appBar: AppBar(
        title: Text("Register (Sign Up) "),
        elevation: 0,
        backgroundColor: appbarGreen,
      ),
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Form(
              //😉😉 to make validation when data it wrong "not valid " dont send to firebase
              key:
                  _formKey, //😉😉 to make validation when data it wrong "not valid " dont send to firebase
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(125, 78, 91, 110),
                    ),
                    child: Stack(
                      children: [
                        imgPath == null
                            ? CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 225, 225, 225),
                                radius: 71,
                                // backgroundImage: AssetImage("assets/img/avatar.png"),
                                backgroundImage:
                                    AssetImage("assets/img/60111.jpg"),
                              )
                            : ClipOval(
                                child: Image.file(
                                  imgPath!,
                                  width: 145,
                                  height: 145,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        Positioned(
                          left: 105,
                          bottom: -10,
                          child: IconButton(
                            onPressed: () {
                              showDialog();
                            },
                            icon: const Icon(Icons.add_a_photo),
                            color: Color.fromARGB(255, 94, 115, 128),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  TextField(
                      controller:
                          userNameController, // 2 Handle changes to a text field
                      keyboardType:
                          TextInputType.emailAddress, // shape of keyboard
                      obscureText: false, // text not password ***
                      //copyWith(hintText: "Enter Your Passaword",) to add a new "ميزة"
                      decoration: decorationTextField.copyWith(
                        hintText: "Enter Your User Name :",
                        suffixIcon: Icon(
                          Icons.person,
                        ), // "suffixIcon" in right of texstfield
                      )),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                      controller:
                          ageController, // 2 Handle changes to a text field
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: decorationTextField.copyWith(
                          hintText: "Enter Your age : ",
                          suffixIcon: Icon(Icons.pest_control_rodent))),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                      controller:
                          titleController, // 2😘 Handle changes to a text field
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: decorationTextField.copyWith(
                          hintText: "Enter Your title : ",
                          suffixIcon: Icon(Icons.person_outline))),
                  const SizedBox(
                    height: 22,
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
                        suffixIcon: Icon(
                          Icons.email,
                        ), // "suffixIcon" in right of texstfield
                      )),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                      onChanged: (password) {
                        onPasswordChanged(password);
                      },
                      // we use it rather than textField bec. contains validator:..
                      validator: (password) {
                        // "value" is value of textField
                        // we return "null" when value > 8  && null mean that 👍
                        return password!.length < 8
                            ? "Enter at least 8 character"
                            : null;
                      }, // we see it below the textfield if it not validate
                      autovalidateMode: AutovalidateMode
                          .onUserInteraction, // to see that email vailed automatically or not when user write it
                      controller:
                          passwordController, // 2😎 Handle changes to a text field
                      keyboardType: TextInputType.text, // shape of keyboard
                      obscureText: IsVisibility_password
                          ? false
                          : true, // text password ***
                      decoration: decorationTextField.copyWith(
                        hintText: "Enter Your Password",
                        suffixIcon: IconButton(
                          icon: IsVisibility_password
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              IsVisibility_password = !IsVisibility_password;
                            });
                          },
                        ), // "suffixIcon" in right of texstfield
                      )),
                  const SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isPassword8Char ? Colors.green : Colors.white,
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Icon(
                          Icons.check,
                          color: isPassword8Char ? Colors.green : Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      const Text("At least 8 characters"),
                    ],
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: hasDigits ? Colors.green : Colors.white,
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Icon(
                          Icons.check,
                          color: hasDigits ? Colors.green : Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      const Text("At least 1 number"),
                    ],
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: hasUppercase ? Colors.green : Colors.white,
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Icon(
                          Icons.check,
                          color: hasUppercase ? Colors.green : Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      const Text("Has Uppercase"),
                    ],
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: hasLowercase ? Colors.green : Colors.white,
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Icon(
                          Icons.check,
                          color: hasLowercase ? Colors.green : Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      const Text("Has Lowercase"),
                    ],
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: hasSpecialCharacters
                              ? Colors.green
                              : Colors.white,
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Icon(
                          Icons.check,
                          color: hasSpecialCharacters
                              ? Colors.green
                              : Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      const Text("Has Special Characters"),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() && imgName != null && imgPath   != null) {
                        await register(); // await to wait finish it first then showSnackBar()
                        if (!mounted)
                          return; // this good for performance "https://dart-lang.github.io/linter/lints/use_build_context_synchronously.html"
                        //Navigate to a new screen and back "Login" without routes
                        Navigator.pushReplacement(
                          // we dont use "push" we use pushReplacement to make pop "delete" for login stack automatically
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      } else {
                        showSnackBar(context, "ERROR");
                      } //😉😉 to make validation when data it wrong "not valid " dont send to firebase && and give us "showSnackBar (ERROR)"
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
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Register",
                            style: TextStyle(fontSize: 19),
                          ),
                  ),
                  const SizedBox(
                    height: 22,
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
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: const Text('Sign in',
                            style: TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.underline)),
                      ),
                    ],
                  ),
                  SizedBox(
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
                    margin: EdgeInsets.symmetric(vertical: 27),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(13),
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
                        SizedBox(
                          width: 22,
                        ),
                        GestureDetector(
                          onTap: () {
                            googleSignInProvider.googlelogin();
                          },
                          child: Container(
                            padding: EdgeInsets.all(13),
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
                        SizedBox(
                          width: 22,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(13),
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
      ),
    );
  }
}
