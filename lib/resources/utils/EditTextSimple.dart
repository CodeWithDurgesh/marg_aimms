import 'package:flutter/material.dart';

class EditTextSimple extends StatelessWidget {
  EditTextSimple({
    Key? key,
    required this.controllers,
    required this.focusNode,
    required this.keyboardTypes,
    required this.maxlength,
    this.cHeight = 50,
    this.cWidth = double.infinity,
    this.fontSize = 16,
    this.counterTexts = '',
    this.hint = '',
    this.label = '',
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  TextEditingController controllers;
  FocusNode focusNode = FocusNode();
  var keyboardTypes;
  String label;
  String hint;
  String counterTexts;
  int maxlength;
  double fontSize;
  double cHeight;
  double cWidth;
  bool readOnly;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cHeight,
      width: cWidth,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(5.0), // Adjust the radius as needed
        ),
        child: TextFormField(
          onTap: onTap,
          readOnly: readOnly,
          maxLength: maxlength,
          keyboardType: keyboardTypes,
          controller: controllers,
          focusNode: focusNode,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Color(0xffC5C5C5), // Border color
                width: 0.5, // Border width
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            counterText: counterTexts,
            labelText: label,
            hintText: hint,
            hintStyle: TextStyle(fontSize: 14),
          ),
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
