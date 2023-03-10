import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReadDataFromFireStore extends StatefulWidget {
  final String documentId;

  const ReadDataFromFireStore({super.key, required this.documentId});

  @override
  State<ReadDataFromFireStore> createState() => _ReadDataFromFireStoreState();
}

class _ReadDataFromFireStoreState extends State<ReadDataFromFireStore> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance
        .collection('users'); // 1 Handle changes to a text field
    final dialogUserNameController =
        TextEditingController(); // 1 Handle changes to a text field
    // 3 to Update data in firestore that chnged
    CollectionReference userss = FirebaseFirestore.instance.collection('users');
    final credential = FirebaseAuth.instance.currentUser;

// function that to make showDialog relation to firebase
    myshowDialog(Map data, dynamic myKey) { // myKey = when click to edit_icon and in hintText   & data is map make relation to firebase
      return showDialog(                    
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
            child: Container(
              padding: EdgeInsets.all(22),
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                      controller:
                          dialogUserNameController, // 2 Handle changes to a text field
                      maxLength: 20,
                      decoration:
                          InputDecoration(hintText: "${data['$myKey']}") 
                          ), 

                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            users.doc(credential!.uid).update({
                              "$myKey": dialogUserNameController.text
                            }); // 4 to Update data in firestore that chnged
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(fontSize: 22),
                          )),
                      SizedBox(
                        width: 12,
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 22),
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Username: ${data["userName"]}",
                    style: const TextStyle(fontSize: 17),
                  ),
                  IconButton(
                    iconSize: 17,
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      myshowDialog(data, 'userName');
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "age: ${data['age']} years old",
                    style: const TextStyle(fontSize: 17),
                  ),
                  IconButton(
                    iconSize: 17,
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      myshowDialog(data, 'age');
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "email: ${data['email']}",
                    style: const TextStyle(fontSize: 17),
                  ),
                  IconButton(
                    iconSize: 17,
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      myshowDialog(data, 'email');
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "password: ${data['password']}",
                    style: const TextStyle(fontSize: 17),
                  ),
                  IconButton(
                    iconSize: 17,
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      myshowDialog(data, 'password');
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "title: ${data['title']}",
                    style: const TextStyle(fontSize: 17),
                  ),
                  IconButton(
                    iconSize: 17,
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      myshowDialog(data, 'title');
                    },
                  ),
                ],
              ),
            ],
          );
        }

        return const Text("loading");
      },
    );
  }
}
