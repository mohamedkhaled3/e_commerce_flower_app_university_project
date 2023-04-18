
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ImageUser extends StatefulWidget {

  const ImageUser({super.key});

  @override
  State<ImageUser> createState() =>
      _ImageUserState();
}

class _ImageUserState extends State<ImageUser> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance
        .collection('users'); // 1 Handle changes to a text field
    CollectionReference userss = FirebaseFirestore.instance
        .collection('users'); // 3 to Update data in firestore that chnged
    final credential = FirebaseAuth.instance.currentUser;

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(credential!.uid).get(),
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
          return CircleAvatar(
            backgroundColor: Color.fromARGB(255, 225, 225, 225),
            radius: 71,
            // backgroundImage: AssetImage("assets/img/avatar.png"),
            backgroundImage: NetworkImage(data["imageLink"]),
          );
        }

        return const Text("loading");
      },
    );
  }
}
