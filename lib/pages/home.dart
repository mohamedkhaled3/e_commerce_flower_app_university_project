import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: Text("Home"),
        actions: [     // the end of AppBar  & "leading is start of AppBar"
          Row(
            children: [
              Stack(
                children: [
                  Positioned( bottom: 22, 
                    child: Container(
                        child: Text(
                          "8",
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(211, 164, 255, 193),
                            shape: BoxShape.circle)),
                  ),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.add_shopping_cart)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text("\$ 128"),   //  \$ to make 128 not variable
              )
            ],
          )
        ],
      ),
    );
  }
}