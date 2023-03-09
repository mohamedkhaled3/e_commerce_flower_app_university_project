import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ReadDataFromFireStore extends StatelessWidget {
  final String documentId;

  const ReadDataFromFireStore({super.key, 
    required this.documentId
    
    });

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 22,),
              Text( "Username: ${data['userName']}",style: TextStyle(fontSize: 17),),                     
              SizedBox(height: 22,),
              Text( "age: ${data['age']} years old",style: TextStyle(fontSize: 17),), 
              SizedBox(height: 22,),
              Text( "email: ${data['email']}",style: TextStyle(fontSize: 17),), 
              SizedBox(height: 22,),
              Text( "password: ${data['password']}",style: TextStyle(fontSize: 17),), 
              SizedBox(height: 22,),
              Text( "title: ${data['title']}",style: TextStyle(fontSize: 17),), 
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}