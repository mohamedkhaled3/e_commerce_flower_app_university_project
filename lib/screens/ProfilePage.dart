
import 'package:e_commerce_flower_app_university_project/shared/ReadDataFromFireStore.dart';
import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final credential = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pop(context);
            },
            label: Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: appbarGreen,
        title: Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Container(
              padding: EdgeInsets.all(11),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 131, 177, 255),
                  borderRadius: BorderRadius.circular(11)),
              child: Text(
                "Info from firebase Auth",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 11,
                ),
                Text(
                  "Email: ${credential!.email}     ",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                Text(
                  "Created date: ${DateFormat("MMMM d, y").format(credential!.metadata.creationTime!)}",  // to give first data of login
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                Text(
                  "Created date: ${DateFormat("MMMM d, y").format(credential!.metadata.lastSignInTime!)}", // to give last data of login
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 55,
            ),
            Center(
                child: Container(
                    padding: EdgeInsets.all(11),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 131, 177, 255),
                        borderRadius: BorderRadius.circular(11)),
                    child: Text(
                      "Info from firebase firestore",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),    
                    ),
                    ),
                    ReadDataFromFireStore(documentId: credential!.uid,), // documentId:'user_Id(token)'
          ],
        ),
      ),
    );
  }
}