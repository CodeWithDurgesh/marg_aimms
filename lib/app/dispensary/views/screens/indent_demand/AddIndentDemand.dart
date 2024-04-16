import 'dart:convert';

import 'package:aimms/app/dispensary/views/screens/indent_demand/ViewIndentDemand.dart';
import 'package:aimms/resources/utils/normalButton.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../resources/colors/colors.dart';
import '../../../../../resources/utils/EditTextSimple.dart';
import '../../../../../resources/utils/indent_items.dart';
import '../../../../../resources/utils/row_add_indent_demand.dart';
import '../../../../../resources/utils/toasts.dart';
import '../../../../apis/allAPI.dart';
import '../../../../apis/baseUrl.dart';

class AddIndentDemand extends StatefulWidget {
  const AddIndentDemand({super.key});

  @override
  State<AddIndentDemand> createState() => _AddIndentDemandState();
}

class _AddIndentDemandState extends State<AddIndentDemand> {
  bool isVisibleCreateIndentButton = false;
  List newIntentList = [];
  bool scroll = false;
  String OpeningBalanceID = '0';
  String userToken = '';
  String streamID = '';
  String finYearID = '';
  String dispensaryID = '';
  String dispensaryTypeID = '';

  var financialYearList = ['2023-2024'];
  var categoryNameDropdownValue;

  TextEditingController demandController = TextEditingController();
  TextEditingController inStockController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController totalsgtController = TextEditingController();
  TextEditingController grandtotalController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  FocusNode dateFocusNode = FocusNode();

  FocusNode demandFocusNode = FocusNode();
  FocusNode inStockFocusNode = FocusNode();
  FocusNode rateFocusNode = FocusNode();
  FocusNode totalFocusNode = FocusNode();
  FocusNode gstFocusNode = FocusNode();
  FocusNode totalgstFocusNode = FocusNode();
  FocusNode grandtotalFocusNode = FocusNode();

  var medicineCategories = [];
  var categoryDropdownValue;

  var medicineNameByCategories = [];
  var medicineDropdownValue;

  String gender = 'Mission';

  void addIndent(
      int medicine_id,
      String medicine_name,
      int medicine_category_id,
      String medicine_category_name,
      int pack_size_id,
      int unit_id,
      int eld_rate_id,
      int demand_quantity,
      int total,
      int gst,
      int gst_total,
      int grand_total) {
    setState(() {
      newIntentList.add(Indent(
          medicine_id,
          medicine_name,
          medicine_category_id,
          medicine_category_name,
          pack_size_id,
          unit_id,
          eld_rate_id,
          demand_quantity,
          total,
          gst,
          gst_total,
          grand_total));
    });
  }

  void removeTask(int index) {
    setState(() {
      newIntentList.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserToken();
    todayDate();
    super.initState();
  }

  todayDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    print(formattedTime);
    print(formattedDate);
    dateController = TextEditingController(text: formattedDate);
  }

  getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString('token')!;
    streamID = prefs.getString('StreamID')!;
    finYearID = prefs.getString('finYearID')!;
    dispensaryID = prefs.getString('DispensaryID')!;
    dispensaryTypeID = prefs.getString('DispensaryTypeID')!;
    getMedicineCategories();
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
              'Add New Indent/Demand',
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
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
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
                  child: Column(
                    children: [
                      Container(),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.grey[200],
                            width: double.infinity,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Central Budget Per Unit',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    padding: const EdgeInsets.all(20.0),
                                    color: AppColors.whiteColor,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Sanctioned      ₹ 300000.00',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: AppColors.primaryColor),
                                        ),
                                        Text(
                                          'Consumed       ₹ 162641.86',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: AppColors.greenTextColor),
                                        ),
                                        Text(
                                          'Balance            ₹ 137358.14',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: AppColors.d1GradColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Divider(
                                    thickness: 0.5,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'Create Indent',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Financial Year',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: const Color(0xffC5C5C5),
                                        width: 0.5,
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: const Text(
                                          '2023-2024',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 16),
                                            child:
                                                Icon(Icons.keyboard_arrow_down),
                                          ),
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          elevation: 1,
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.grey[50],
                                          ),
                                        ),
                                        buttonStyleData: ButtonStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                        ),
                                        items: financialYearList.map((item3) {
                                          return DropdownMenuItem(
                                            value: item3,
                                            child: Container(
                                                child: Text(
                                              item3,
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                          );
                                        }).toList(),
                                        value: categoryNameDropdownValue,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Stream',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: const Color(0xffC5C5C5),
                                        width: 0.5,
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: const Text(
                                          'Homoeopathic',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 16),
                                            child:
                                                Icon(Icons.keyboard_arrow_down),
                                          ),
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          elevation: 1,
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.grey[50],
                                          ),
                                        ),
                                        buttonStyleData: ButtonStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                        ),
                                        items: financialYearList.map((item3) {
                                          return DropdownMenuItem(
                                            value: item3,
                                            child: Container(
                                                child: Text(
                                              item3,
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                          );
                                        }).toList(),
                                        value: categoryNameDropdownValue,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Health Care Facility/Institution',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: const Color(0xffC5C5C5),
                                        width: 0.5,
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: const Text(
                                          'SHD Rajajipuram, Lucknow',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 16),
                                            child:
                                                Icon(Icons.keyboard_arrow_down),
                                          ),
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          elevation: 1,
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.grey[50],
                                          ),
                                        ),
                                        buttonStyleData: ButtonStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                        ),
                                        items: financialYearList.map((item3) {
                                          return DropdownMenuItem(
                                            value: item3,
                                            child: Container(
                                                child: Text(
                                              item3,
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                          );
                                        }).toList(),
                                        value: categoryNameDropdownValue,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Date',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: EditTextSimple(
                                    controllers: dateController,
                                    focusNode: dateFocusNode,
                                    hint: 'Date',
                                    readOnly: true,
                                    keyboardTypes: TextInputType.number,
                                    maxlength: 5,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Select Option',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Radio(
                                        value: 'Mission',
                                        groupValue: gender,
                                        onChanged: (value) {
                                          setState(() {
                                            gender = value!;
                                          });
                                        },
                                      ),
                                      Text('Mission'),
                                      SizedBox(width: 20),
                                      Radio(
                                        value: 'Directorate',
                                        groupValue: gender,
                                        onChanged: (value) {
                                          setState(() {
                                            gender = value!;
                                          });
                                        },
                                      ),
                                      Text('Directorate'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.grey[200],
                            width: double.infinity,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Add Medicine for Indent',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: const Color(0xffC5C5C5),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: const Text(
                                        'Select Category',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 16),
                                          child:
                                              Icon(Icons.keyboard_arrow_down),
                                        ),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        elevation: 1,
                                        maxHeight:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.grey[50],
                                        ),
                                      ),
                                      buttonStyleData: ButtonStyleData(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                      ),
                                      items: medicineCategories.map((item2) {
                                        return DropdownMenuItem(
                                          value: item2['MCategoryID'],
                                          child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                item2['MCategoryName'],
                                                style: const TextStyle(
                                                    fontSize: 12),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                        );
                                      }).toList(),
                                      onChanged: (ctegoryValue2) {
                                        setState(() {
                                          categoryDropdownValue = ctegoryValue2;
                                          print(
                                              'Category Value @@@@@@@@$categoryDropdownValue');

                                          medicineNameByCategories.isEmpty;
                                          medicineDropdownValue = null;
                                          getMedicineCategoriesByStreamCategoryFinYearId();
                                        });
                                      },
                                      value: categoryDropdownValue,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: const Color(0xffC5C5C5),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: const Text(
                                        'Select Medicine',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 16),
                                          child:
                                              Icon(Icons.keyboard_arrow_down),
                                        ),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        elevation: 1,
                                        maxHeight:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.grey[50],
                                        ),
                                      ),
                                      buttonStyleData: ButtonStyleData(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                      ),
                                      items:
                                          medicineNameByCategories.map((item3) {
                                        return DropdownMenuItem(
                                          value: item3['HMedicineID'],
                                          child: Container(
                                              child: Text(
                                            item3['MedicineName'],
                                            style:
                                                const TextStyle(fontSize: 12),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                        );
                                      }).toList(),
                                      onChanged: (ctegoryValue3) {
                                        setState(() {
                                          medicineDropdownValue = ctegoryValue3;
                                          print(
                                              'Category Value @@@@@@@@$medicineDropdownValue');

                                          /// getOpeningBalanceMedicineQuantity();
                                        });
                                      },
                                      value: medicineDropdownValue,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: EditTextSimple(
                                    controllers: inStockController,
                                    focusNode: inStockFocusNode,
                                    hint: 'In Stock',
                                    keyboardTypes: TextInputType.number,
                                    maxlength: 5,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: EditTextSimple(
                                    controllers: rateController,
                                    focusNode: rateFocusNode,
                                    hint: 'Rate',
                                    keyboardTypes: TextInputType.number,
                                    maxlength: 5,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: EditTextSimple(
                                    controllers: demandController,
                                    focusNode: demandFocusNode,
                                    hint: 'Demand Quantity',
                                    keyboardTypes: TextInputType.number,
                                    maxlength: 5,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: EditTextSimple(
                                    controllers: totalController,
                                    focusNode: totalFocusNode,
                                    hint: 'Total (₹)',
                                    keyboardTypes: TextInputType.number,
                                    maxlength: 5,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: EditTextSimple(
                                    controllers: gstController,
                                    focusNode: gstFocusNode,
                                    hint: 'GST (%)',
                                    keyboardTypes: TextInputType.number,
                                    maxlength: 5,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: EditTextSimple(
                                    controllers: totalsgtController,
                                    focusNode: totalgstFocusNode,
                                    hint: 'GST Total (₹)',
                                    keyboardTypes: TextInputType.number,
                                    maxlength: 5,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: EditTextSimple(
                                    controllers: grandtotalController,
                                    focusNode: grandtotalFocusNode,
                                    hint: 'Grand Total (₹)',
                                    keyboardTypes: TextInputType.number,
                                    maxlength: 5,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: InkWell(
                                      onTap: () async {
                                        setState(() {
                                          addIndent(
                                              0,
                                              '',
                                              0,
                                              '${medicineDropdownValue}',
                                              0,
                                              0,
                                              0,
                                              int.parse(demandController.text
                                                  .toString()),
                                              int.parse(totalController.text
                                                  .toString()),
                                              int.parse(gstController.text
                                                  .toString()),
                                              int.parse(totalsgtController.text
                                                  .toString()),
                                              int.parse(grandtotalController
                                                  .text
                                                  .toString()));

                                        });
                                      },
                                      child: normalButton(name: ' + Add')),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: newIntentList.isEmpty
                            ? Center(
                                child: Text(
                                  "No Item Added",
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: newIntentList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        color: AppColors.whiteColor,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [

                                        row_add_indent_demand(
                                        medicineName:
                                        '${medicineDropdownValue}',
                                          rate: '${rateController.text}',
                                          demandQty:
                                          '${demandController.text}',
                                          total:
                                          '${totalController.text}',
                                          gst: '${gstController.text}',
                                          gstTotal:
                                          '${totalsgtController.text}',
                                          netTotal:
                                          '${grandtotalController.text}',
                                        ),


                                            // InkWell(
                                            //   child:
                                            //   onTap: () {},
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: isVisibleCreateIndentButton
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
                  postCreateDispensaryIndent();
                },
              ),
            ),
    );
  }




  void _addNewIndent(String medicine_category, String rate, String demand,
      String total, String gst, String totalGst, String grandTotal) {
    setState(() {
      newIntentList.add(IndentItems(
        medicine_id: "",
        medicine_name: "",
        medicine_category_id: "",
        medicine_category_name: medicine_category,
        pack_size_id: "",
        unit_id: "",
        eld_rate_id: rate,
        demand_quantity: demand,
        total: total,
        gst: gst,
        gst_total: totalGst,
        grand_total: grandTotal,
      ));
      print("Indent List" + newIntentList.toString());
    });
  }

  Future<void> postCreateDispensaryIndent() async {
    setState(() {
      scroll = true;
    });

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    };

    var request = http.Request(
        'POST', Uri.parse(urls().base_url + allAPI().createDispensaryIndent));
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);

    request.body = json.encode({
      "Limit": 141979.9,
      "IsPost": false,
      "StreamID": streamID,
      "FinYearID": finYearID,
      "IndentDate": formattedDate,
      "DispensaryID": dispensaryID,
      "MissionDirectorate": 1,
      "IndentDetails": [
        {
          "MedicineID": 1,
          "MCategoryID": 2,
          "PackSizeID": 14,
          "UnitID": 9,
          "EDLRateID": 69,
          "DemandQuantity": 100,
          "Total": 2000,
          "GST": 2060,
          "GrandTotal": 9
        },
        {
          "MedicineID": 4,
          "MCategoryID": 1,
          "PackSizeID": 8,
          "UnitID": 11,
          "EDLRateID": 82,
          "DemandQuantity": 500,
          "Total": 22500,
          "GST": 0,
          "GrandTotal": 23400
        }
      ]
    });
    request.headers.addAll(headers);
    var response = await request.send();
    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      if (results['status'] == 'success') {
        setState(() {
          scroll = false;
        });
        toasts().redToastLong(results['message']);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ViewIndentDemand()));
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

  Future<void> getMedicineCategories() async {
    setState(() {
      scroll = true;
    });
    var headers = {'Authorization': 'Bearer $userToken'};
    var request = http.Request(
        'GET',
        Uri.parse(urls().base_url +
            allAPI().getMedicineCategoriesByStreamId +
            '?StreamID=$streamID'));
    request.headers.addAll(headers);
    var response = await request.send();
    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'MedicineCategoriesByStreamId@@@@@@@@@@@-----${results}');
      if (results['status'] == 'success') {
        print(
            await 'MedicineCategoriesByStreamId@@@@@@@@@@@-----Print Successfully');
        medicineCategories = results['data'];
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

  Future<void> getMedicineCategoriesByStreamCategoryFinYearId() async {
    setState(() {
      scroll = true;
    });
    var headers = {'Authorization': 'Bearer $userToken'};
    var request = http.Request(
        'GET',
        Uri.parse(urls().base_url +
            allAPI().getMedicineCategoriesByStreamCategoryFinYearId +
            '?StreamID=$streamID&MCategoryID=$categoryDropdownValue&FinYearID=$finYearID'));
    request.headers.addAll(headers);
    var response = await request.send();
    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(
          await 'MedicineCategoriesByStreamID_MedicineCategoryId_FinYearID@@@@@@@@@@@-----${results}');
      if (results['status'] == 'success') {
        print(
            await 'MedicineCategoriesByStreamId@@@@@@@@@@@-----Print Successfully');
        medicineNameByCategories = results['data'];
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

class Indent {
  int medicine_id;
  String medicine_name;
  int medicine_category_id;
  String medicine_category_name;
  int pack_size_id;
  int unit_id;
  int eld_rate_id;
  int demand_quantity;
  int total;
  int gst;
  int gst_total;
  int grand_total;

  Indent(
      this.medicine_id,
      this.medicine_name,
      this.medicine_category_id,
      this.medicine_category_name,
      this.pack_size_id,
      this.unit_id,
      this.eld_rate_id,
      this.demand_quantity,
      this.total,
      this.gst,
      this.gst_total,
      this.grand_total);
}
