
import 'package:e_commerce_flower_app_university_project/screens/home.dart';
import 'package:e_commerce_flower_app_university_project/screens/SignIn.dart';
import 'package:e_commerce_flower_app_university_project/provider/google_SignIn.dart';
import 'package:e_commerce_flower_app_university_project/provider/cart.dart';
import 'package:e_commerce_flower_app_university_project/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // the last step of firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // see any change in providers
      providers: [
        ChangeNotifierProvider(create: (context) {
          //   // see any change in Cart_class  && // 😍😍 1 provider
          return Cart();
        }),
        ChangeNotifierProvider(create: (context) {
          return GoogleSignInProvider();
        }),
      ],
      child: MaterialApp(
          title: "myApp",
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            // to connect to firebase & to chick if user make login on this mobile go to "VerifyEmailPage" automatically else must make register
            stream: FirebaseAuth.instance
                .authStateChanges(), // to connect to firebase
            builder: (context, snapshot) {
              // to make chick   // snapshot like screenshot
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              } else if (snapshot.hasError) {
                // not go to home
                return showSnackBar(context, "Something went wrong");
              } else if (snapshot.hasData) {
                //  go to VerifyEmailPage
                // return VerifyEmailPage();
                return const Home(); // OR verify email
              } else {
                return const Login();
              }
            },
          )),
    );

    //           } else if (snapshot.hasError) {

    //             return showSnackBar(context, "Something went wrong");
    //           } else if (snapshot.hasData) {
    //
    //             return VerifyEmailPage();
    //           } else {
    //             return Login();
    //           }
    //         },
    //       ),
    //     ),
    //   ),
    // );
  }
}
