import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  String rowText;
  String textHint;
  bool isPassword;
  bool onlyText;
  String initialString;
  TextEditingController myController;
  CustomInputField({
    this.textHint,
    this.myController,
    this.isPassword,
    this.initialString,
    this.rowText,
    this.onlyText,
  });

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: <Widget>[
          Container(
              width: 90,
              child: Text(
                widget.rowText,
              )),
          Expanded(
            child: getTextOrTextField(widget.onlyText),
          ),
        ],
      ),
    );
  }

  getTextOrTextField(bool onlyText) {
    if (onlyText) {
      return Text(
        widget.initialString,
      );
    } else {
      return new TextFormField(
        initialValue: widget.initialString,
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
      );
    }
  }
}
