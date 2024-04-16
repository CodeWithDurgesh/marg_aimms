import 'package:aimms/resources/colors/colors.dart';
import 'package:flutter/material.dart';

class normalButton extends StatelessWidget {
  normalButton({
    Key? key,
    required this.name,
    this.bckColor = AppColors.primaryColor,
    this.textColor = AppColors.whiteColor,
    this.height = 50,
    this.width = double.infinity,
    this.fontSize = 14,
    this.bordeRadious = 5,
    this.scroll = false,
  }) : super(key: key);

  bool scroll = false;
  String name;
  Color bckColor;
  Color textColor;
  double width;
  double height;
  double fontSize;
  double bordeRadious;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: bckColor,
          borderRadius: BorderRadius.circular(bordeRadious),
        ),
        child: scroll
            ? Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Text(name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize,
                        color: textColor))));
  }
}
