import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Uihelper{
  static CustomTextField(TextEditingController controller,
      String text,
      IconData icondata){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 25),
      child: TextField(

        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          suffixIcon: Icon(icondata),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24)
          )

        ),
      ),
    );

  }
}