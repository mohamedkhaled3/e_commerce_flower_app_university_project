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
    final classInstances =
        Provider.of<Cart>(context); // Cart is 😍😍 2 provider
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: const Text("CheckOut Screen"),
        actions: const [ProductsAndPrice()],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: 500,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: classInstances.selectedProduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              classInstances.selectedProduct[index].imgPath),
                        ),
                        title: Text(classInstances.selectedProduct[index].name),
                        subtitle: Text(
                            "  ${classInstances.selectedProduct[index].price} - ${classInstances.selectedProduct[index].location} "),
                        trailing: IconButton(
                            onPressed: () {
                              // classInstancee.selectedProduct.remove(index);
                              // classInstancee.notifyListeners();
                                 classInstances.remove(classInstances.selectedProduct[ index]); //when click to "-" we remove data in everywhere   
                            },
                            icon: const Icon(Icons.remove)),
                      ),
                    );
                  }),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(BTPink),
              padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
            ),
            child: Text(
              "Pay \$${classInstances.price}  ",
              style: const TextStyle(fontSize: 19),
            ),
          ),
        ],
      ), // is product that already in list of Cart_class
    );
  }
}
