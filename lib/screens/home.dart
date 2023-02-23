import 'package:e_commerce_flower_app_university_project/model/item.dart';
import 'package:e_commerce_flower_app_university_project/screens/checkout.dart';
import 'package:e_commerce_flower_app_university_project/screens/details_screen.dart';
import 'package:e_commerce_flower_app_university_project/provider/cart.dart';
import 'package:e_commerce_flower_app_university_project/shared/appbar.dart';
import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    final classInstance =
        Provider.of<Cart>(context); // Cart is 😍😍 2 provider
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 22),
        child: GridView.builder(
            //GridView.builder() like listView.builder  but for row not column and almost use GridTile with it
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of element in x-axis
                childAspectRatio:
                    3 / 2, // "النسبه " between element of length & weight
                crossAxisSpacing: 10, // space between elements in x_axix
                mainAxisSpacing: 50), // space between elements in y_axix

            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                // GestureDetector() to make GridTile like buttom

                onTap: () {
                  // Navigate and pass data to the detail screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details(
                        product: items[index],
                      ), // "Details" is page that navigater for it && "items" is data that is pass
                    ),
                  );
                },
                child: GridTile(
                  //    GridTile( ) will repeated the number of "itemCount"
                  footer: GridTileBar(
                    // see backgroundColor to understand it
                    // backgroundColor: Color.fromARGB(66, 73, 127, 110),  //// to see border of footer

                    trailing: IconButton(
                        // Right of "footer"
                        color: const Color.fromARGB(255, 62, 94, 70),
                        onPressed: () {
                          classInstance.add(items[
                              index]); //when click to "+" we add data of "items" to list of "Cart_class"
                        },
                        icon: const Icon(Icons.add)),
                    leading: // left of "footer"

                        const Text(
                            '\$12.99'), // we dont use widget. bec statelessWidget
                    title: const Text(
                      // Center of "footer" remark if we delete it + icon  palce in center
                      "",
                    ),
                  ),
                  //    GridTile( ) will repeated the number of "itemCount"
                  child: Stack(
                    children: [
                      Positioned(
                        top: -20,
                        bottom: -20,
                        right: 0,
                        left: 0,
                        child: ClipRRect(
                          // to make curve for image
                          borderRadius: BorderRadius.circular(
                              55), // to make curve for image
                          child: Image.asset(items[index].imgPath),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
      drawer: Drawer(
        // 📑📑 when we add leading the drawer : يختفي :
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // we always use UserAccountsDrawerHeader() in drawer // use it to show header of drawer

            Column(
              children: [
                const UserAccountsDrawerHeader(
                  // to make background image "flower image"
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img/backgroundImage.jpg"),
                        fit: BoxFit
                            .cover), //"fit: BoxFit.cover" -- to make max size can take
                  ),
                  // to make text of accountName
                  accountName: Text(
                    "mohamed khaled",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  // to make text of accountEmail
                  accountEmail: Text(
                    "mk1644@fayoum.edu.eg",
                  ),
                  //
                  currentAccountPictureSize: Size.square(72.0),
                  // to make  CircleAvatar "circular image " or " profile image "
                  currentAccountPicture: CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage("assets/img/do_it.jpeg"),
                  ),
                ),
                ListTile(
                    // ListTile is widget  we use it in past in "المشروع بتاع " WORLD TIME APP Title in center
                    title: const Text("Home"), // Title in center
                    leading: const Icon(Icons.home), // leading in left
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ),
                      );
                    }),
                ListTile(
                    title: const Text("My products"),
                    leading: const Icon(Icons.add_shopping_cart),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CheckOut(), // "CheckOut" is page that navigater for it &&
                        ),
                      );
                    }),
                ListTile(
                    title: const Text("About"),
                    leading: const Icon(Icons.help_center),
                    onTap: () {}),
                ListTile(
                    title: const Text("Logout"),
                    leading: const Icon(Icons.exit_to_app),
                    onTap: () async {
                      // لتسجيل خروج مستخدم
                      await FirebaseAuth.instance.signOut();
                    }),
              ],
            ),

            Container(
                margin: const EdgeInsets.only(bottom: 22),
                child: const Text("developee by mohamed khaled ")),
          ],
        ),
      ),
      appBar: AppBar(
        // leading: Text("rfff"), //////////////// remove icon of Drawer
        backgroundColor: appbarGreen,
        title: const Text("Home"),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          // the end of AppBar  & "leading is start of AppBar"
           const ProductsAndPrice(),
        ],
      ),
    );
  }
}
