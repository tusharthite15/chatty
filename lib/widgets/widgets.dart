import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.5)),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xfff5553c), width: 1.5)),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xfff5553c), width: 1.5)));

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showSnackBar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(message,
            style: const TextStyle(
              fontSize: 14,
            )),
        backgroundColor: color,
        duration: Duration(seconds: 2),
        action: SnackBarAction(
            label: 'OK', onPressed: () {}, textColor: Colors.white)),
  );
}
