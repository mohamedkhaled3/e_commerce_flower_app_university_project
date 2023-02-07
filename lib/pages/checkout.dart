// الشراء
import 'package:e_commerce_flower_app_university_project/model/item.dart';
import 'package:e_commerce_flower_app_university_project/provider/cart.dart';
import 'package:e_commerce_flower_app_university_project/shared/appbar.dart';
import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final classInstancee =
        Provider.of<Cart>(context); // Cart is 😍😍 2 provider
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: Text("CheckOut Screen"),
        actions: [ProductsAndPrice()],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: 500,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: classInstancee.selectedProduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              classInstancee.selectedProduct[index].imgPath),
                        ),
                        title: Text(classInstancee.selectedProduct[index].name),
                        subtitle: Text(
                            "  ${classInstancee.selectedProduct[index].price} - ${classInstancee.selectedProduct[index].location} "),
                        trailing: IconButton(
                            onPressed: () {
                              // classInstancee.selectedProduct.remove(index);
                              // classInstancee.notifyListeners();
                                 classInstancee.remove(classInstancee.selectedProduct[ index]); //when click to "-" we remove data in everywhere   
                            },
                            icon: Icon(Icons.remove)),
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(BTNpink),
              padding: MaterialStateProperty.all(EdgeInsets.all(12)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
            ),
            child: Text(
              "Pay \$${classInstancee.price}  ",
              style: TextStyle(fontSize: 19),
            ),
          ),
        ],
      ), // is product that already in list of Cart_class
    );
  }
}
