
import 'package:e_commerce_flower_app_university_project/pages/home.dart';
import 'package:e_commerce_flower_app_university_project/pages/login.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}