import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  String textHint;
  bool isPassword;
  TextEditingController myController;
  CustomInputField({this.textHint, this.myController, this.isPassword});

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: TextFormField(
        obscureText: widget.isPassword,
        controller: widget.myController,
        decoration: new InputDecoration(
          hintText: widget.textHint,
          isDense: true,
          contentPadding: EdgeInsets.all(6),
          filled: true,
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
