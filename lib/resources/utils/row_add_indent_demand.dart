import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class row_add_indent_demand extends StatelessWidget {
  row_add_indent_demand({
    Key? key,
    required this.medicineName,
    required this.rate,
    required this.demandQty,
    required this.total,
    required this.gst,
    required this.gstTotal,
    required this.netTotal,
  }) : super(key: key);

  final String medicineName;
  final String rate;
  final String demandQty;
  final String total;
  final String gst;
  final String gstTotal;
  final String netTotal;

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.all(1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              //padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Text('Medicine Name'),
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
                          child: Text(medicineName),
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
                          child: Text('Rate'),
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
                          child: Text(rate),
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
                          child: Text('Total (₹)'),
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
                          child: Text(total),
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
                          child: Text('GST (%)'),
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
                          child: Text(gst),
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
                          child: Text('GST Total (₹)'),
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
                          child: Text(gstTotal),
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
                          child: Text('Net Total (₹)'),
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
                          child: Text(netTotal),
                        ),
                      ),
                    ],
                  ),
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
                                    style: TextStyle(
                                        color: Colors.white))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
          content: Text('Are you sure you want to delete ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                //Navigator.of(context).pop(); // Close the dialog
                //deleteDispensaryIndent();
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
}
