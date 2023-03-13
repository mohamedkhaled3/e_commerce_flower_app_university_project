import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_flower_app_university_project/shared/ReadDataFromFireStore.dart';
import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final credential =
      FirebaseAuth.instance.currentUser; //credential is "currentUser"
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  File? imgPath;

  showDialog() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(22),
          color: Colors.amber[100],
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            await uploadImage2Screen(ImageSource.gallery);
                          },
                          child: const Text(
                            "From Gallery",
                            style: TextStyle(fontSize: 16),
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.photo)
                    ],
                  ),
                  SizedBox(
                    width: 22,
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            await uploadImage2Screen(ImageSource.camera);
                          },
                          child: Text(
                            "From Camera",
                            style: TextStyle(fontSize: 16),
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.camera)
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

// لرفع الصوره للشاشه تابعنا   Function to get img path
  uploadImage2Screen(ImageSource typeOfLoadingPhoto) async {
    final pickedImg =
        await ImagePicker().pickImage(source: typeOfLoadingPhoto);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(125, 78, 91, 110),
                  ),
                  child: Stack(
                    children: [
                      imgPath == null
                          ? CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 225, 225, 225),
                              radius: 71,
                              // backgroundImage: AssetImage("assets/img/avatar.png"),
                              backgroundImage:
                                  AssetImage("assets/img/60111.jpg"),
                            )
                          : ClipOval(
                              child: Image.file(
                                imgPath!,
                                width: 145,
                                height: 145,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                        left: 105,
                        bottom: -10,
                        child: IconButton(
                          onPressed: () {
                            showDialog();
                          },
                          icon: const Icon(Icons.add_a_photo),
                          color: Color.fromARGB(255, 94, 115, 128),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 33,
              ),

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
                    "Created date: ${DateFormat("MMMM d, y").format(credential!.metadata.creationTime!)}", // to give first data of login
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
                height: 15,
              ),
              Center(
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    setState(() {
                      credential!.delete(); //Delete user [firebase auth]
                      users
                          .doc(credential!.uid)
                          .delete(); //Delete a document [firestore]
                      Navigator.pop(context); // to go to signin_screen
                    });
                  },
                  child: Text(
                    'Delete User',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
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
              ReadDataFromFireStore(
                documentId: credential!.uid,
              ), // documentId:'user_Id(token)'
            ],
          ),
        ),
      ),
    );
  }
}
