import 'package:aimms/resources/colors/colors.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

class bottomNavigationBar extends StatefulWidget {
  int? position;

  bottomNavigationBar(this.position);

  @override
  State<bottomNavigationBar> createState() =>
      _bottomNavigationBarState(position);
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  _bottomNavigationBarState(position);

  int currentIndex = 0;
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return CustomNavigationBar(
      iconSize: 25.0,
      selectedColor: AppColors.primaryTextColor,
      strokeColor: Colors.transparent,
      unSelectedColor: AppColors.shimmerbkColor,
      backgroundColor: Colors.white,
      items: [
        CustomNavigationBarItem(
          icon: Image.asset(
            'assets/images/ic_home.png',
            color: widget.position == 0
                ? AppColors.primaryTextColor
                : AppColors.shimmerbkColor,
          ),
          title: Text(
            'Home',
            style: TextStyle(
                fontSize: 10,
                color: widget.position == 0
                    ? AppColors.primaryTextColor
                    : AppColors.shimmerbkColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        CustomNavigationBarItem(
          icon: Image.asset(
            'assets/images/ic_inbox.png',
            color: widget.position == 1
                ? AppColors.primaryTextColor
                : AppColors.shimmerbkColor,
          ),
          title: Text(
            'Inbox',
            style: TextStyle(
                fontSize: 8,
                color: widget.position == 1
                    ? AppColors.primaryTextColor
                    : AppColors.shimmerbkColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        CustomNavigationBarItem(
          icon: Image.asset(
            'assets/images/ic_tools.png',
            color: widget.position == 2
                ? AppColors.primaryTextColor
                : AppColors.shimmerbkColor,
          ),
          title: Text(
            'Tools',
            style: TextStyle(
                fontSize: 10,
                color: widget.position == 2
                    ? AppColors.primaryTextColor
                    : AppColors.shimmerbkColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        CustomNavigationBarItem(
          icon: Image.asset(
            'assets/images/ic_profile.png',
            color: widget.position == 3
                ? AppColors.primaryTextColor
                : AppColors.shimmerbkColor,
          ),
          title: Text(
            'Profile',
            style: TextStyle(
                fontSize: 10,
                color: widget.position == 3
                    ? AppColors.primaryTextColor
                    : AppColors.shimmerbkColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
      currentIndex: widget.position!,
      onTap: (index) {
        setState(() {
          currentIndex = index;
          print('iiiiiii->$index');
          if (currentIndex == 0) {
            //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => viewLocations()), (Route<dynamic> route) => false);
          }
          if (currentIndex == 1) {
            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => viewLocations()));
          }
          if (currentIndex == 2) {
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => userProfile()));
          }
          if (currentIndex == 3) {
            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => userProfile()));
          }
        });
      },
    );
  }
}
