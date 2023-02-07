import 'package:e_commerce_flower_app_university_project/model/item.dart';
import 'package:e_commerce_flower_app_university_project/pages/checkout.dart';
import 'package:e_commerce_flower_app_university_project/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsAndPrice extends StatelessWidget {
  const ProductsAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
          final classInstancee = Provider.of<Cart>(context);  // Cart is 😍😍 2 provider
    return Row(
      children: [
        Stack(
          children: [
            Positioned(
              bottom: 22,
              child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(211, 164, 255, 193),
                      shape: BoxShape.circle),
                  child: Text(
                    "${classInstancee.selectedProduct.length}", // before const 0 but now change when click to "+"
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
                  )),
            ),
            IconButton(
                onPressed: () { // Navigate and pass data to the CheckOut screen                                 
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckOut(), // "CheckOut" is page that navigater for it &&                            
                    ),
                  );
                }, icon: const Icon(Icons.add_shopping_cart)),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Text("\$ ${classInstancee.price}  "),
        ),
      ],
    );
  }
}
