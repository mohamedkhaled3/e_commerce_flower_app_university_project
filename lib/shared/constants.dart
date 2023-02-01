import 'package:flutter/material.dart';

const decorationTextField = InputDecoration(
  // To delete borders "الحدود"
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide.none, // we must delete widget of context bec. not in stl widget  // means delete  Divider.createBorderSide(context),
  ),
  // borders "الحدود" when enter email
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  ),
  filled: true, // to make the color inside border "رمادي"
  // fillColor: Colors.red, // by using this we can change color of inside border
  contentPadding: EdgeInsets.all(8), // to make padding inside textfield
);