import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_flower_app_university_project/shared/ReadDataFromFireStore.dart';
import 'package:e_commerce_flower_app_university_project/shared/colors.dart';
import 'package:e_commerce_flower_app_university_project/shared/user_img_from_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' show basename;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final credential =
      FirebaseAuth.instance.currentUser; //credential is "currentUser"
  // Store img url in firestore[database]
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  File? imgPath;
  String? imgName;

  showDialog() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(22),
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
                                        if( imgPath != null){
                                                                      // Upload image to firebase storage
                            final storageRef = FirebaseStorage.instance
                                .ref("/user-imgs/$imgName");
                            await storageRef.putFile(imgPath!);
                            // Get img url
                            String url = await storageRef.getDownloadURL();
                            // Store img url in firestore[database]
                            users.doc(credential!.uid).update({
                              "imageLink": url,
                            });
                                        }
                          },
                          child: const Text(
                            "From Gallery",
                            style: TextStyle(fontSize: 16),
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(Icons.photo)
                    ],
                  ),
                  const SizedBox(
                    width: 22,
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            await uploadImage2Screen(ImageSource.camera);
                            if( imgPath != null){ 
                            // Upload image to firebase storage
                            final storageRef =
                                FirebaseStorage.instance.ref(imgName);
                            await storageRef.putFile(imgPath!);
                            // Get img url
                            String url = await storageRef.getDownloadURL();
                            // Store img url in firestore[database]
                            users.doc(credential!.uid).update({
                              "imageLink": url,
                            });
                            }
                          },
                          child: const Text(
                            "From Camera",
                            style: TextStyle(fontSize: 16),
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(Icons.camera)
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
    final pickedImg = await ImagePicker().pickImage(source: typeOfLoadingPhoto);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
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
            label: const Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: appbarGreen,
        title: const Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(125, 78, 91, 110),
                  ),
                  child: Stack(
                    children: [
                      imgPath == null
                          ? const ImageUser()
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
                          color: const Color.fromARGB(255, 94, 115, 128),
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
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 131, 177, 255),
                    borderRadius: BorderRadius.circular(11)),
                child: const Text(
                  "Info from firebase Auth",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Email: ${credential!.email}     ",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Created date: ${DateFormat("MMMM d, y").format(credential!.metadata.creationTime!)}", // to give first data of login
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Created date: ${DateFormat("MMMM d, y").format(credential!.metadata.lastSignInTime!)}", // to give last data of login
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              const SizedBox(
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
                  child: const Text(
                    'Delete User',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 131, 177, 255),
                      borderRadius: BorderRadius.circular(11)),
                  child: const Text(
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
