import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class row_details_indent_demand extends StatelessWidget {
  const row_details_indent_demand({
    Key? key,
    required this.medicineName,
    required this.category,
    required this.rate,
    required this.demandQty,
    required this.total,
    required this.gst,
    required this.gstTotal,
    required this.grandTotal,
  }) : super(key: key);

  final String medicineName;
  final String category;
  final String rate;
  final String demandQty;
  final String total;
  final String gst;
  final String gstTotal;
  final String grandTotal;

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
              padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          child: Text('Medicine Name',style: TextStyle(fontWeight: FontWeight.normal),),
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
                          child: Text('Category',style: TextStyle(fontWeight: FontWeight.normal),),
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
                          child: Text(category),
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
                          child: Text('Rate',style: TextStyle(fontWeight: FontWeight.normal),),
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
                          child: Text('Demand Qty',style: TextStyle(fontWeight: FontWeight.normal),),
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
                          child: Text('Total (₹)',style: TextStyle(fontWeight: FontWeight.normal),),
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
                          child: Text('GST (%)',style: TextStyle(fontWeight: FontWeight.normal),),
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
                          child: Text('GST Total (₹)',style: TextStyle(fontWeight: FontWeight.normal),),
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
                          child: Text('Grand Total (₹)',style: TextStyle(fontWeight: FontWeight.normal),),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
