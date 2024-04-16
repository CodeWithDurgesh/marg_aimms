import 'package:aimms/app/dispensary/views/screens/available_stock/ViewAvailableStock.dart';
import 'package:aimms/app/dispensary/views/screens/opening_stock/ViewOpeningStock.dart';
import 'package:aimms/app/dispensary/views/screens/patient/DailyPatientVisitListView.dart';
import 'package:flutter/material.dart';

import '../../app/dispensary/views/screens/indent_demand/ViewIndentDemand.dart';
import '../../app/dispensary/views/screens/medicine/ViewMedicine.dart';
import '../colors/colors.dart';

class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  String userName = "XXXXXXXXXX";
  String _version = '1.0';
  String loginType = 'user';

  @override
  void initState() {
    //getUserName();
    //_getVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Drawer(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
        ),
        width: MediaQuery.of(context).size.width / 1.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Image.asset(
                    'assets/images/profile_pic.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 20),
                  child: Text(
                    "Durgesh Prajapati",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 20),
                  child: Text(
                    "durgesh11mca029@gmail.com",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Divider(
                    thickness: 2,
                    color: Colors.grey[300],
                  ),
                ),
                InkWell(
                  child: ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: 0),
                    title: Text('Opening Stock',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        )),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewOpeningStock()));
                  },
                ),
                InkWell(
                  child: ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: 0),
                    title: Text('Available Stock',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        )),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewAvailableStock()));
                  },
                ),
                InkWell(
                  child: ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: 0),
                    title: Text('Medicine',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        )),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewMedicine()));
                  },
                ),
                InkWell(
                  child: ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: 0),
                    title: Text('Patient',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        )),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DailyPatientVisitListView()));
                  },
                ),
                InkWell(
                  child: ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: 0),
                    title: Text('Indent',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        )),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewIndentDemand()));
                  },
                ),
                InkWell(
                  child: ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: 0),
                    title: Text('Logout',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: AppColors.primaryColor,
                        )),
                  ),
                  onTap: () {},
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Text(
                    "version: $_version",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.primaryColor,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
