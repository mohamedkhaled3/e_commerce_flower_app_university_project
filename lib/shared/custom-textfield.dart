import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  // const MyTextField({super.key}); // must remove this when make attributes
  final TextInputType keyboardTypeeee;
  final bool ispassward;
  final String hinttextttt;
  
 MyTextField({super.key, required this.keyboardTypeeee , required this.ispassward , required this.hinttextttt});

  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: keyboardTypeeee, // shape of keyboard
        obscureText: ispassward, // text not password ***
        decoration: InputDecoration(
          hintText: "$hinttextttt",
          // To delete borders "الحدود"
          enabledBorder: OutlineInputBorder(
            borderSide: Divider.createBorderSide(context),
          ),
          // borders "الحدود" when enter email
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          filled: true, // to make the color inside border "رمادي"
          // fillColor: Colors.red, // by using this we can change color of inside border
          contentPadding:
              const EdgeInsets.all(8), // to make padding inside textfield
        ));
  }
}
