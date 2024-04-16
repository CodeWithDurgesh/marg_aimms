import 'package:aimms/resources/colors/colors.dart';
import 'package:flutter/material.dart';

class moduleview_category extends StatelessWidget {
  const moduleview_category({
    Key? key,
    required this.title,
    required this.path,
  }) : super(key: key);

  final String path;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Image.asset(
                  path,
                  height: 50,
                  width: 50,
                ),
              ),
              SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.primaryTextColor,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
