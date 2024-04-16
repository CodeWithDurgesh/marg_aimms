import 'package:flutter/material.dart';

class moduleview extends StatelessWidget {
  const moduleview({
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
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
