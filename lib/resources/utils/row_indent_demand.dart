import 'dart:convert';

import 'package:aimms/app/dispensary/views/screens/indent_demand/DetailsIndentDemand.dart';
import 'package:aimms/resources/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/apis/allAPI.dart';
import '../../app/apis/baseUrl.dart';

class row_indent_demand extends StatelessWidget {
  row_indent_demand({
    Key? key,
    required this.indentDate,
    required this.indentNo,
    required this.demandQty,
    required this.indentValue,
    required this.balanceLimit,
    required this.under,
    required this.status,
  }) : super(key: key);

  final String indentDate;
  final String indentNo;
  final String demandQty;
  final String indentValue;
  final String balanceLimit;
  final String under;
  final String status;
  String userToken = '';
  String indentDemandID = '2';



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(5, 30, 5, 5),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Text('Indent Date'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Center(child: Text(':')),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Text(indentDate),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Text('Indent No.'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Center(child: Text(':')),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Text(indentNo),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Text('Demand Qty'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Center(child: Text(':')),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Text(demandQty),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Text('Indent Value (₹)'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Center(child: Text(':')),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Text(indentValue),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        color: Colors.white,
                        height: 25,
                        child: Text('Balance Limit (₹)'),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Center(child: Text(':')),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Text(balanceLimit),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Text('Under'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Center(child: Text(':')),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Text(under),
                        ),
                      ),
                    ],
                  ),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.white,
                        height: 25,
                        child: Text('Status'),
                      ),
                      Row(
                        children: [
                          Container(
                            color: Colors.white,
                            height: 25,
                            child: Text(status),
                          ),
                        ],
                      )
                    ],
                  ),*/
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _showConfirmationDialog(context);
                          },
                          child: Container(
                            color: Colors.red,
                            height: 50,
                            child: Center(
                                child: Text('Delete',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const DetailsIndentDemand()));
                          },
                          child: Container(
                            color: Colors.blue,
                            height: 50,
                            child: Center(
                              child: Text(
                                '+ View & Post',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                  color: Colors.green[200],
                  child: Text(
                    'PENDING TO DISTRICT',
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  )),
            ))
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to perform this action?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                deleteDispensaryIndent();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteDispensaryIndent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('token')!;
    var headers = {'Authorization': 'Bearer $userToken'};

    var request = http.Request(
        'POST',
        Uri.parse(urls().base_url +
            allAPI().deleteDispensaryIndent +
            '?IndentDemandID=$indentDemandID'));
    request.headers.addAll(headers);
    var response = await request.send();
    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'deleteDispensaryIndent@-----${results}');
      if (results['status'] == 'success') {
        toasts().redToastLong(results['message']);
      } else {
        toasts().redToastLong(results['message']);
      }
    } else {
      toasts().redToastLong('Server Error');
    }
  }
}
