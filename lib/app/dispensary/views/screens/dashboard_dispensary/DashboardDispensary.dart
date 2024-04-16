import 'dart:convert';

import 'package:aimms/resources/colors/colors.dart';
import 'package:aimms/resources/utils/drawer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../resources/utils/toasts.dart';
import '../../../../apis/allAPI.dart';
import '../../../../apis/baseUrl.dart';

class DashboardDispensary extends StatefulWidget {
  const DashboardDispensary({super.key});

  @override
  State<DashboardDispensary> createState() => _DashboardDispensaryState();
}

class _DashboardDispensaryState extends State<DashboardDispensary> {
  var getUserDetails;
  bool isVisibleMonthWise = true;
  bool isVisibleDayWise = false;
  String userToken = '';

  @override
  void initState() {
    // TODO: implement initState
    getUserToken();
    super.initState();
  }

  getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('token')!;
    getUserDetailsByToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        leadingWidth: 30,
        backgroundColor: AppColors.d1GradColor,
        title: Text("Dashboard",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: AppColors.whiteColor)),
        actions: [
          IconButton(
            icon: Image.asset(
              "assets/images/profile_pic.png",
              width: 60,
              height: 60,
            ),
            onPressed: () {
              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => userProfile()));
            },
          ),
        ],
      ),
      drawer: const drawer(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.l1GradColor,
              AppColors.l3GradColor,
              AppColors.l3GradColor,
              AppColors.l4GradColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 1,
              ),
              Container(
                height: 260,
                width: double.infinity,
                margin: EdgeInsets.only(top: 0),
                padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                child: GridView.count(
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 5,
                  childAspectRatio: .7,
                  crossAxisCount: 3,
                  children: [
                    itemDashboard('Medicine Available', '(500)',
                        'assets/images/ic_medicine1.png', Colors.transparent),
                    itemDashboard('Medicine In-short', '(50,000)',
                        'assets/images/ic_medicine2.png', Colors.transparent),
                    itemDashboard('Medicine Expire', '(4,50,000)',
                        'assets/images/ic_medicine3.png', Colors.transparent)
                  ],
                ),
              ),
              Visibility(
                visible: isVisibleMonthWise,
                child: Container(
                  height: 250,
                  width: double.infinity,
                  child: LineChart(LineChartData(lineBarsData: [
                    LineChartBarData(
                        spots: [
                          FlSpot(0, 0),
                          FlSpot(5, 10),
                          FlSpot(15, 20),
                          FlSpot(20, 25),
                          FlSpot(25, 4),
                          FlSpot(27, 45),
                          FlSpot(24, 100),
                        ],
                        isCurved: true,
                        dotData: FlDotData(show: true),
                        color: Colors.pinkAccent,
                        barWidth: 1)
                  ])),
                ),
              ),
              Visibility(
                visible: isVisibleDayWise,
                child: Container(
                  height: 250,
                  width: double.infinity,
                  child: LineChart(LineChartData(lineBarsData: [
                    LineChartBarData(
                        spots: [
                          FlSpot(1, 1),
                          FlSpot(2, 2),
                          FlSpot(3, 3),
                          FlSpot(4, 4),
                          FlSpot(5, 5),
                          FlSpot(6, 6),
                          FlSpot(7, 7),
                        ],
                        isCurved: true,
                        dotData: FlDotData(show: true),
                        color: Colors.pinkAccent,
                        barWidth: 1)
                  ])),
                ),
              ),
              InkWell(
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding:
                      EdgeInsets.only(left: 0, top: 0, right: 10, bottom: 0),
                  child: Column(
                    children: [
                      Text(
                        "Patient Visibility Status Day Wise",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Barlow',
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    isVisibleMonthWise = false;
                    isVisibleDayWise = true;
                  });
                  /*ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Sending Message"),
                  ));*/
                },
              ),
              InkWell(
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding:
                      EdgeInsets.only(left: 0, top: 5, right: 10, bottom: 10),
                  child: Text(
                    "Patient Visibility Status Month Wise",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor),
                  ),
                ),
                onTap: () {
                  setState(() {
                    isVisibleDayWise = false;
                    isVisibleMonthWise = true;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  itemDashboard(
          String title, String count_medicine, String img, Color background) =>
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 5),
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(1),
                decoration:
                    BoxDecoration(color: background, shape: BoxShape.circle),
                child: Image.asset(
                  img,
                  width: 60,
                  height: 40,
                )),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            Text(
              count_medicine,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );

  Future<void> getUserDetailsByToken() async {
    var headers = {'Authorization': 'Bearer $userToken'};
    var request = http.Request(
        'GET', Uri.parse(urls().base_url + allAPI().getUserDetailsByToken));
    request.headers.addAll(headers);
    var response = await request.send();
    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'GetUserDetailsByToken@@@@@@@-----${results['data']}');
      if (results['status'] == 'success') {
        getUserDetails = results['data'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('UserID', '${getUserDetails['UserID']}');
        prefs.setString('UserName', '${getUserDetails['UserName']}');
        prefs.setString('RoleID', '${getUserDetails['RoleID']}');
        prefs.setString('RoleName', '${getUserDetails['RoleName']}');
        prefs.setString('RoleDescription', '${getUserDetails['RoleDescription']}');
        prefs.setString('FirstName', '${getUserDetails['FirstName']}');
        prefs.setString('LastName', '${getUserDetails['LastName']}');
        prefs.setString('EmailAddress', '${getUserDetails['EmailAddress']}');
        prefs.setString('MobileNo', '${getUserDetails['MobileNo']}');
        prefs.setString('IsActive', '${getUserDetails['IsActive']}');
        prefs.setString('FullName', '${getUserDetails['FullName']}');
        prefs.setString('StreamID', '${getUserDetails['StreamID']}');
        prefs.setString('DivisionID', '${getUserDetails['DivisionID']}');
        prefs.setString('CMSOfficeID', '${getUserDetails['CMSOfficeID']}');
        prefs.setString('DistrictID', '${getUserDetails['DistrictID']}');
        prefs.setString('DistrictOfficeID', '${getUserDetails['DistrictOfficeID']}');
        prefs.setString('DispensaryTypeID', '${getUserDetails['DispensaryTypeID']}');
        prefs.setString('DispensaryID', '${getUserDetails['DispensaryID']}');
        prefs.setString('SupplierID', '${getUserDetails['SupplierID']}');
        prefs.setString('StreamName', '${getUserDetails['StreamName']}');
        prefs.setString('DivisionName', '${getUserDetails['DivisionName']}');
        prefs.setString('CMSOfficeName', '${getUserDetails['CMSOfficeName']}');
        prefs.setString('DistrictName', '${getUserDetails['DistrictName']}');
        prefs.setString('DistrictOfficeName', '${getUserDetails['DistrictOfficeName']}');
        prefs.setString('DispensaryTypeName', '${getUserDetails['DispensaryTypeName']}');
        prefs.setString('DispensaryName', '${getUserDetails['DispensaryName']}');
        prefs.setString('SupplierName', '${getUserDetails['SupplierName']}');
      } else {
        toasts().redToastLong(results['message']);
      }
    } else {
      toasts().redToastLong('Server Error');
    }
  }
}
