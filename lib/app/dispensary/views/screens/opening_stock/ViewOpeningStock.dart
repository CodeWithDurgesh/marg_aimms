import 'dart:convert';

import 'package:aimms/app/dispensary/views/screens/opening_stock/AddOpeningStock.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../resources/colors/colors.dart';
import '../../../../../resources/utils/toasts.dart';
import '../../../../apis/allAPI.dart';
import '../../../../apis/baseUrl.dart';

class ViewOpeningStock extends StatefulWidget {
  const ViewOpeningStock({super.key});

  @override
  State<ViewOpeningStock> createState() => _ViewOpeningStockState();
}

class _ViewOpeningStockState extends State<ViewOpeningStock> {
  bool scroll = false;
  String userToken = '';
  String streamID = '';
  String finYearID = '';
  String dispensaryID = '';
  String dispensaryTypeID = '';
  var OpeningBalanceMedicineList = [];

  @override
  void initState() {
    // TODO: implement initState
    getUserToken();
    super.initState();
  }

  getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('token')!;
    streamID = prefs.getString('StreamID')!;
    finYearID = prefs.getString('finYearID')!;
    dispensaryID = prefs.getString('DispensaryID')!;
    dispensaryTypeID = prefs.getString('DispensaryTypeID')!;
    dispensaryOpeningBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        leadingWidth: 30,
        backgroundColor: AppColors.d1GradColor,
        title: Text("Opening Stock",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: AppColors.whiteColor)),
        actions: [
          IconButton(
            icon: Image.asset(
              color: Colors.white,
              "assets/images/add_medicine_new.png",
              width: 80,
              height: 80,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddOpeningStock()));
            },
          ),
        ],
      ),
      body: scroll
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.l1GradColor,
                    AppColors.l2GradColor,
                    AppColors.l3GradColor,
                    AppColors.l4GradColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ListView.builder(
                  itemCount: OpeningBalanceMedicineList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                left: 5, top: 5, right: 5, bottom: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    //width: MediaQuery.of(context).size.width * 0.8,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Name - ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Barlow',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: AppColors
                                                        .primaryColor)),
                                            Text(
                                                "${OpeningBalanceMedicineList[index]['MedicineName']} "
                                                "${OpeningBalanceMedicineList[index]['PotencyName'] == "N/A" ? "" : "${OpeningBalanceMedicineList[index]['PotencyName']} "}"
                                                "${OpeningBalanceMedicineList[index]['PackSizeName']}"
                                                "${OpeningBalanceMedicineList[index]['UnitShortName']}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: AppColors
                                                        .primaryColor)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Category - ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Barlow',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: AppColors
                                                        .primaryColor)),
                                            Text(
                                                "${OpeningBalanceMedicineList[index]['MCategoryName']}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: AppColors
                                                        .primaryColor)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Quantity - ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Barlow',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: AppColors
                                                        .primaryColor)),
                                            Text(
                                                "${OpeningBalanceMedicineList[index]['Quantity']}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: AppColors
                                                        .primaryColor)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        /* Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              child: normalButton(
                                name:
                                    'Qty - ${OpeningBalanceMedicineList[index]['Quantity']}',
                                width: 100,
                                height: 35,
                                fontSize: 10,
                                bordeRadious: 20,
                                textColor: Colors.white,
                                bckColor: AppColors.d1GradColor,
                              ),
                            ),
                          ],
                        ),*/
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    );
                  }),
            ),
    );
  }

  Future<void> dispensaryOpeningBalance() async {
    setState(() {
      scroll = true;
    });
    var headers = {'Authorization': 'Bearer $userToken'};
    var request = http.Request(
        'GET',
        Uri.parse(urls().base_url +
            allAPI()
                .getMedicineListByStreamMissionDirectorateDispendaryAndTypeId +
            '?StreamID=$streamID&FinYearID=$finYearID&MissionDirectorate=1&DispensaryID=$dispensaryID&DispensaryTypeID=$dispensaryTypeID'));
    request.headers.addAll(headers);
    var response = await request.send();
    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'OpeningBalanceMedicineList@-----${results}');
      if (results['status'] == 'success') {
        OpeningBalanceMedicineList = results['data'];
        setState(() {
          scroll = false;
        });
      } else {
        setState(() {
          scroll = false;
        });
        toasts().redToastLong(results['message']);
      }
    } else {
      toasts().redToastLong('Server Error');
      setState(() {
        scroll = false;
      });
    }
  }
}
