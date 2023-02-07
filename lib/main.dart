
import 'package:e_commerce_flower_app_university_project/model/item.dart';
import 'package:e_commerce_flower_app_university_project/pages/checkout.dart';
import 'package:e_commerce_flower_app_university_project/pages/details_screen.dart';
import 'package:e_commerce_flower_app_university_project/pages/home.dart';
import 'package:e_commerce_flower_app_university_project/pages/login.dart';
import 'package:e_commerce_flower_app_university_project/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
        home: Home(priceItem:   Item(name:"product1" ,imgPath: "assets/img/1.webp", price: 12.99, location: "fayoum"),
),  /// product: items[index],
      ),
    );
  }
}