import 'package:e_commerce_flower_app_university_project/model/item.dart';
import 'package:e_commerce_flower_app_university_project/shared/appbar.dart';
import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  Item product;
  Details({required this.product});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isShowMore = true;
  // ignore: non_constant_identifier_names
  bool isShowAll_Or_ShowLess = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: Text("rfff"), //////////////// remove icon of Drawer
          backgroundColor: appbarGreen,
          title: const Text("Details Screen"),
          actions: const [   // the end of AppBar  & "leading is start of AppBar"
          
            ProductsAndPrice(),

          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(widget.product.imgPath  , // we add widget. bec we use statefullWidget bec there exist 2 class && "product" is data of class that link between (Details_class && Items_class)
                                                    // "widget.product.imgPath" is image of class "Item" 
                width: double.infinity,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "\$  ${widget.product.price}",  // is price of class "Item"
                style: const TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      // ignore: sort_child_properties_last
                      child: const Text(
                        'new',
                        style: TextStyle(fontSize: 15),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 255, 129, 129),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 255, 191, 0),
                          size: 25.0,
                        ),
                        const Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 255, 191, 0),
                          size: 25.0,
                        ),
                        const Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 255, 191, 0),
                          size: 25.0,
                        ),
                        const Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 255, 191, 0),
                          size: 25.0,
                        ),
                        const Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 255, 191, 0),
                          size: 25.0,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.edit_location),
                        const SizedBox(
                          width: 5,
                        ),
                        Text( widget.product.location),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(9.0),
                width: double.infinity,
                child: const Text(
                  "Details :",
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    "A flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). The biological function of a flower is to facilitate reproduction, usually by providing a mechanism for the union of sperm with eggs. Flowers may facilitate outcrossing (fusion of sperm and eggs from different individuals in a population) resulting from cross-pollination or allow selfing (fusion of sperm and egg from the same flower) when self-pollination occurs",
                    style: const TextStyle(fontSize: 15),
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
                clipBehavior: Clip.none,
                child: Text(
                  isShowAll_Or_ShowLess ? 'showe more ' : "show less",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 14, 140, 171), fontSize: 18),
                ),
              ),
            ],
          ),
        ));
  }
}
