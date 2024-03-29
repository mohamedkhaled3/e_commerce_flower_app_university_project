// cart is "عربه التسوق"
// 😍😍 2 provider
import 'package:e_commerce_flower_app_university_project/model/item.dart';
import 'package:e_commerce_flower_app_university_project/provider/cart.dart';
import 'package:e_commerce_flower_app_university_project/shared/appbar.dart';
import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart with ChangeNotifier {
  // ChangeNotifier is data in provider can access by any page

  List selectedProduct = [
    // contais data when button on "+" in home page
  ];
  double price = 0;

// to add product_details into list
  add(Item product) {
    selectedProduct.add(product);
    price += product.price.round() ; // .round() "علشان اقربه لاقرب رقم صحيح"
    notifyListeners(); //always use to to make setState Automatically  at the end of every method
  }
  // to remove product_details into list
  remove(Item product){
    selectedProduct.remove(product);
    price -= product.price.round() ; 
    notifyListeners();

  }
}
