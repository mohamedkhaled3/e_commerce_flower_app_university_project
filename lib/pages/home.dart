import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ // we always use UserAccountsDrawerHeader() in drawer // use it to show header of drawer
   
   Column(children: [     
UserAccountsDrawerHeader(  
                // to make background image "flower image"
              decoration : BoxDecoration(
                  image:  DecorationImage(image: AssetImage("assets/images/backgroundImage.jpg"),
                  fit: BoxFit.cover), //"fit: BoxFit.cover" -- to make max size can take 
              ),
              // to make text of accountName
              accountName: Text("mohamed khaled",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
             // to make text of accountEmail
              accountEmail: Text("mk1644@fayoum.edu.eg",),
            //      
              currentAccountPictureSize : const Size.square(72.0),
            // to make  CircleAvatar "circular image " or " profile image "     
              currentAccountPicture: CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage("assets/images/do_it.jpeg"),
              ),      
           ),
           
 ListTile(   // ListTile is widget  we use it in past in "المشروع بتاع " WORLD TIME APP Title in center 
   title: Text("Home"),  // Title in center 
   leading: Icon(Icons.home), // leading in left 
   onTap: () { }
 ),
  
 ListTile(
   title: Text("My products"),
   leading: Icon(Icons.add_shopping_cart),
   onTap: () { }
 ),

 ListTile(
   title: Text("About"),
   leading: Icon(Icons.help_center),
   onTap: () { }
 ),

 ListTile(
   title: Text("Logout"),
   leading: Icon(Icons.exit_to_app),
   onTap: () { }
 ),
  
          ], ) ,
       
           Container(
            margin: EdgeInsets.only(bottom: 22),
            child: Text("developee by mohamed khaled ")),          
            ],
          ),
      
        ),
        appBar: AppBar(
          // leading: Text("rfff"), //////////////// remove icon of Drawer
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
                            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 15 ),
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
                ),
                
              ],
            ),
            
          ],
           
        ),  
      ),
    );
  }
}