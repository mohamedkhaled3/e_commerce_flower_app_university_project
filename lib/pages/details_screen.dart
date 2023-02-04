import 'package:e_commerce_flower_app_university_project/model/item.dart';
import 'package:e_commerce_flower_app_university_project/provider/cart.dart';
import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  Item product;
  Details({required this.product});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isShowMore = true;
  bool isShowAll_Or_ShowLess = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: Text("rfff"), //////////////// remove icon of Drawer
          backgroundColor: appbarGreen,
          title:   Consumer<Cart>( //💧💧💧  of Cart_class && // 😍😍 3 provider // rather than // Text("Home"),
  builder: ((context, classInstancee, child) {
  return Text("${classInstancee.details_Screen}");
})),  // Text("Details Screen"),
          actions: [
            // the end of AppBar  & "leading is start of AppBar"
            Row(
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
                          child: const Text(
                            "8",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15),
                          )),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_shopping_cart)),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Text("\$ 128"), //  \$ to make 128 not variable
                ),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(widget.product.imgPath  , // we add widget. bec we use statefullWidget bec there exist 2 class && "product" is data of class that link between (Details_class && Items_class)
                                                    // "widget.product.imgPath" is image of class "Item" 
                width: double.infinity,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "\$  ${widget.product.price}",  // is price of class "Item"
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "new",
                        style: TextStyle(fontSize: 15),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(255, 255, 129, 129),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 255, 191, 0),
                          size: 25.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 255, 191, 0),
                          size: 25.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 255, 191, 0),
                          size: 25.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 255, 191, 0),
                          size: 25.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 255, 191, 0),
                          size: 25.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Row(
                      children: [
                        Icon(Icons.edit_location),
                        SizedBox(
                          width: 5,
                        ),
                        Text( widget.product.location),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(9.0),
                width: double.infinity,
                child: Text(
                  "Details :",
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(2.0),
                  child: Text(
                    "A flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). The biological function of a flower is to facilitate reproduction, usually by providing a mechanism for the union of sperm with eggs. Flowers may facilitate outcrossing (fusion of sperm and eggs from different individuals in a population) resulting from cross-pollination or allow selfing (fusion of sperm and egg from the same flower) when self-pollination occurs",
                    style: TextStyle(fontSize: 15),
                    maxLines: isShowMore ? 3 : null,
                    overflow: TextOverflow.fade,
                  )),
              TextButton(
                onPressed: () {
                  setState(() {
                    isShowMore = !isShowMore;
                    isShowAll_Or_ShowLess = !isShowAll_Or_ShowLess;
                  });
                },
                child: Text(
                  isShowAll_Or_ShowLess ? 'showe more ' : "show less",
                  style: TextStyle(
                      color: Color.fromARGB(255, 14, 140, 171), fontSize: 18),
                ),
                clipBehavior: Clip.none,
              ),
            ],
          ),
        ));
  }
}
