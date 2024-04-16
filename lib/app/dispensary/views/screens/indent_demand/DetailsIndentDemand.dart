import 'dart:convert';

import 'package:aimms/app/dispensary/views/screens/indent_demand/ViewIndentDemand.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../resources/colors/colors.dart';
import '../../../../../resources/utils/row_details_indent_demand.dart';
import '../../../../../resources/utils/toasts.dart';
import '../../../../apis/allAPI.dart';
import '../../../../apis/baseUrl.dart';

class DetailsIndentDemand extends StatefulWidget {
  const DetailsIndentDemand({super.key});

  @override
  State<DetailsIndentDemand> createState() => _DetailsIndentDemandState();
}

class _DetailsIndentDemandState extends State<DetailsIndentDemand> {
  bool scroll = false;
  bool scrollNav = false;
  String userToken = '';
  String indentDemandID = '1';
  var demandWiseIndent = [];

  @override
  void initState() {
    // TODO: implement initState
    getUserToken();
    super.initState();
  }

  getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('token')!;
    getDispensaryIndentDetailView();
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
            const Text(
              'View Indent/Demand',
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
      ),
      body: scroll
          ? Center(child: CircularProgressIndicator())
          : Container(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/dashboard_upper.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: double.infinity,
                              color: Colors.transparent,
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Indent Date : N/A",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Indent No. : N/A",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Indent Value (₹) : N/A",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Balance Limit (₹) : N/A",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Under : N/A",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Status : N/A",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: demandWiseIndent.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(5),
                                child: InkWell(
                                  child: row_details_indent_demand(
                                    medicineName:
                                        '${demandWiseIndent[index]['MedicineName']}',
                                    category:
                                        '${demandWiseIndent[index]['MCategoryName']}',
                                    rate: '${demandWiseIndent[index]['Rates']}',
                                    demandQty:
                                        '${demandWiseIndent[index]['DemandQuantity']}',
                                    total:
                                        '${demandWiseIndent[index]['Total']}',
                                    gst:
                                        '${demandWiseIndent[index]['GSTInPerc']}',
                                    gstTotal:
                                        '${demandWiseIndent[index]['GSTotal']}',
                                    grandTotal:
                                        '${demandWiseIndent[index]['GrandTotal']}',
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: scrollNav
          ? null
          : Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.normal),
                ),
                onPressed: () {
                  createDispensaryIndent();
                },
              ),
            ),
    );
  }

  Future<void> createDispensaryIndent() async {
    setState(() {
      scroll = true;
    });
    var headers = {'Authorization': 'Bearer $userToken'};
    var request = http.Request(
        'POST',
        Uri.parse(urls().base_url +
            allAPI().postDispensaryIndent +
            '?IndentDemandID=$indentDemandID'));
    request.headers.addAll(headers);
    var response = await request.send();
    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print('results@-----${results}');
      print('results status@-----${results['status']}');
      print('results message@-----${results['message']}');
      if (results['status'] == 'success') {
        setState(() {
          scroll = false;
        });
        toasts().redToastLong(results['message']);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ViewIndentDemand()));
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

  Future<void> getDispensaryIndentDetailView() async {
    setState(() {
      scroll = true;
    });
    var headers = {'Authorization': 'Bearer $userToken'};
    var request = http.Request(
        'GET',
        Uri.parse(urls().base_url +
            allAPI().getDispensaryIndentDetailView +
            '?IndentDemandID=$indentDemandID'));
    request.headers.addAll(headers);
    var response = await request.send();
    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print('getDispensaryIndentDetailView@-----${results}');
      if (results['status'] == 'success') {
        demandWiseIndent = results['data'];
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
