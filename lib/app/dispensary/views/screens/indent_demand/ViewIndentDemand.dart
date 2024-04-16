import 'dart:convert';

import 'package:aimms/app/dispensary/views/screens/indent_demand/AddIndentDemand.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../resources/colors/colors.dart';
import '../../../../../resources/utils/row_indent_demand.dart';
import '../../../../../resources/utils/toasts.dart';
import '../../../../apis/allAPI.dart';
import '../../../../apis/baseUrl.dart';

class ViewIndentDemand extends StatefulWidget {
  const ViewIndentDemand({super.key});

  @override
  State<ViewIndentDemand> createState() => _ViewIndentDemandState();
}

class _ViewIndentDemandState extends State<ViewIndentDemand> {
  bool scroll = false;
  String userToken = '';
  String dispensaryID = '';
  var dispensaryWiseIndentHistory = [];

  @override
  void initState() {
    // TODO: implement initState
    getUserToken();
    super.initState();
  }

  getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('token')!;
    dispensaryID = prefs.getString('DispensaryID')!;
    getDispensaryWiseIndentHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/images/ic_back.png'),
          // Replace with your custom back button image
          onPressed: () {
            // Handle back button press
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        leadingWidth: 70,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.d1GradColor,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/ayurvedic_bowl_svgrepo.png",
              width: 160,
              height: 30,
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'All Indent/Demand',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              color: Colors.white,
              "assets/images/add_medicine_new.png",
              width: 60,
              height: 60,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddIndentDemand()));
            },
          ),
        ],
      ),
      body: scroll
          ? Center(child: CircularProgressIndicator())
          : Container(
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
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                child: ListView.builder(
                    itemCount: dispensaryWiseIndentHistory.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                InkWell(
                                  child: row_indent_demand(
                                    indentDate: convertDateFormat(
                                        '${dispensaryWiseIndentHistory[index]['IndentDate']}'),
                                    indentNo:
                                        '${dispensaryWiseIndentHistory[index]['IndentNo']}',
                                    demandQty:
                                        '${dispensaryWiseIndentHistory[index]['DemandQuantity']}',
                                    indentValue:
                                        '${dispensaryWiseIndentHistory[index]['GrandTotal']}',
                                    balanceLimit:
                                        '${dispensaryWiseIndentHistory[index]['Limit']}',
                                    under:
                                        '${dispensaryWiseIndentHistory[index]['MissionDirectorateName']}',
                                    status: "PENDING TO " +
                                        '${dispensaryWiseIndentHistory[index]['StatusName']}',
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
    );
  }

  Future<void> getDispensaryWiseIndentHistory() async {
    setState(() {
      scroll = true;
    });
    var headers = {'Authorization': 'Bearer $userToken'};
    var request = http.Request(
        'GET',
        Uri.parse(urls().base_url +
            allAPI().getDispensaryWiseIndentHistory +
            '?DispensaryID=$dispensaryID'));
    request.headers.addAll(headers);
    var response = await request.send();
    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'OpeningBalanceMedicineList@-----${results}');
      if (results['status'] == 'success') {
        dispensaryWiseIndentHistory = results['data'];
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

  String convertDateFormat(String inputDate) {
    // Parse the input date
    DateTime parsedDate = DateTime.parse(inputDate);

    // Format the date in the desired format
    String formattedDate =
        "${parsedDate.day.toString().padLeft(2, '0')}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.year}";

    return formattedDate;
  }

/*String convertDateFormat(String inputDate) {
    // Parse the input date
    DateTime dateTime = DateFormat("dd-MM-yyyy").parse(inputDate);

    // Format the date in the desired format
    String formattedDate = DateFormat("dd-MMM-yy").format(dateTime);

    return formattedDate;
  }*/
}
