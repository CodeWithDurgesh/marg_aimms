import 'package:flutter/material.dart';

class IndentItems extends StatelessWidget {
  const IndentItems({
    Key? key,
    required this.medicine_id,
    required this.medicine_name,
    required this.medicine_category_id,
    required this.medicine_category_name,
    required this.pack_size_id,
    required this.unit_id,
    required this.eld_rate_id,
    required this.demand_quantity,
    required this.total,
    required this.gst,
    required this.gst_total,
    required this.grand_total,
  }) : super(key: key);

  final String medicine_id;
  final String medicine_name;
  final String medicine_category_id;
  final String medicine_category_name;
  final String pack_size_id;
  final String unit_id;
  final String eld_rate_id;
  final String demand_quantity;
  final String total;
  final String gst;
  final String gst_total;
  final String grand_total;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
