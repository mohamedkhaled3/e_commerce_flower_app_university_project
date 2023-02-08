
import 'package:e_commerce_flower_app_university_project/model/item.dart';
import 'package:e_commerce_flower_app_university_project/pages/checkout.dart';
import 'package:e_commerce_flower_app_university_project/pages/details_screen.dart';
import 'package:e_commerce_flower_app_university_project/pages/home.dart';
import 'package:e_commerce_flower_app_university_project/pages/login.dart';
import 'package:e_commerce_flower_app_university_project/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
 Future<void> main() async {  // the last step of firebase
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
 }
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return   ChangeNotifierProvider( // see any change in Cart_class  && // 😍😍 1 provider 
        create: (context) {return Cart();},
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}