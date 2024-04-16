import 'package:aimms/resources/colors/colors.dart';
import 'package:flutter/material.dart';

class ayurvedic_category extends StatelessWidget {
  const ayurvedic_category({
    Key? key,
    required this.title1,
    required this.title2,
  }) : super(key: key);

  final String title1;
  final String title2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title1,
                style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primaryTextColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                title2,
                style: TextStyle(
                    fontSize: 10,
                    color: AppColors.primaryTextColor,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
