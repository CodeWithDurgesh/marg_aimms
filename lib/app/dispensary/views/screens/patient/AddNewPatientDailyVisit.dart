import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../resources/colors/colors.dart';
import '../../../../../resources/utils/EditTextSimple.dart';
import '../../../../../resources/utils/toasts.dart';
import '../../../../apis/allAPI.dart';
import '../../../../apis/baseUrl.dart';

class AddNewPatientDailyVisit extends StatefulWidget {
  const AddNewPatientDailyVisit({super.key});

  @override
  State<AddNewPatientDailyVisit> createState() =>
      _AddNewPatientDailyVisitState();
}

class _AddNewPatientDailyVisitState extends State<AddNewPatientDailyVisit> {
  bool isGenderVisible = false;
  bool isOldAndNewPatientVisible = false;
  bool isAgeGroupVisible = false;
  bool isAdhaarVisible = false;

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
  TextEditingController totalNumberOfPatientsController =
      TextEditingController();
  FocusNode totalNumberOfPatientsFocusNode = FocusNode();

  TextEditingController totalMalePatientsController = TextEditingController();
  FocusNode totalMalePatientsFocusNode = FocusNode();

  TextEditingController totalFemalePatientsController = TextEditingController();
  FocusNode totalFemalePatientsFocusNode = FocusNode();

  TextEditingController totalOtherPatientsController = TextEditingController();
  FocusNode totalOtherPatientsFocusNode = FocusNode();

  TextEditingController totalOldPatientsController = TextEditingController();
  FocusNode totalOldPatientsFocusNode = FocusNode();

  TextEditingController totalNewPatientsController = TextEditingController();
  FocusNode totalNewPatientsFocusNode = FocusNode();

  TextEditingController totalPatientAged_0_to10_yearsController =
      TextEditingController();
  FocusNode totalPatientAged_0_to10_FocusNode = FocusNode();

  TextEditingController totalPatientAged_11_to20_Controller =
      TextEditingController();
  FocusNode totalPatientAged_11_to20_FocusNode = FocusNode();

  TextEditingController totalPatientAged_21_to30_Controller =
      TextEditingController();
  FocusNode totalPatientAged_21_to30_FocusNode = FocusNode();

  TextEditingController totalPatientAged_31_to45_Controller =
      TextEditingController();
  FocusNode totalPatientAged_31_to45_FocusNode = FocusNode();

  TextEditingController totalPatientAged_46_to60_Controller =
      TextEditingController();
  FocusNode totalPatientAged_46_to60_FocusNode = FocusNode();

  TextEditingController totalPatientAgedAbove_60_Controller =
      TextEditingController();
  FocusNode totalPatientAgedAbove_60_FocusNode = FocusNode();

  TextEditingController totalAdharSeededPatientsController =
      TextEditingController();
  FocusNode totalAdharSeededPatientsFocusNode = FocusNode();

  TextEditingController totalMobileSeededPatientsController =
      TextEditingController();
  FocusNode totalMobileSeededPatientsFocusNode = FocusNode();

  TextEditingController totalOtherIdSeededPatientsController =
      TextEditingController();
  FocusNode totalOtherIdSeededPatientsFocusNode = FocusNode();

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
              'Add Daily Patient Visit',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 10,
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
                            color: Colors.white,
                            width: double.infinity,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Daily Patient Visit',
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
                                    'District',
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
                                          'Lucknow',
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
                                    'Total Number Of Patients',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: EditTextSimple(
                                    controllers:
                                        totalNumberOfPatientsController,
                                    focusNode: totalNumberOfPatientsFocusNode,
                                    hint: '0',
                                    readOnly: false,
                                    keyboardTypes: TextInputType.number,
                                    maxlength: 5,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          //_showConfirmationDialog(context);
                                        },
                                        child: Container(
                                          color: Colors.red,
                                          height: 50,
                                          child: Center(
                                              child: Text('Reset',
                                                  style: TextStyle(
                                                      color: Colors.white))),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isGenderVisible = true;
                                          });
                                          // Navigator.of(context).push(MaterialPageRoute(
                                          //     builder: (context) =>
                                          //     const DetailsIndentDemand()));
                                        },
                                        child: Container(
                                          color: Colors.blue,
                                          height: 50,
                                          child: Center(
                                            child: Text(
                                              'Proceed',
                                              style: TextStyle(
                                                  color: Colors.white),
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
                        ),
                      ),
                      Visibility(
                        visible: isGenderVisible,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.white,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Gender',
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
                                      'Male',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: EditTextSimple(
                                      controllers: totalMalePatientsController,
                                      focusNode: totalMalePatientsFocusNode,
                                      hint: '0',
                                      readOnly: false,
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
                                      'Female',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: EditTextSimple(
                                      controllers:
                                          totalFemalePatientsController,
                                      focusNode: totalFemalePatientsFocusNode,
                                      hint: '0',
                                      readOnly: false,
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
                                      'Other',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: EditTextSimple(
                                      controllers: totalOtherPatientsController,
                                      focusNode: totalOtherPatientsFocusNode,
                                      hint: '0',
                                      readOnly: false,
                                      keyboardTypes: TextInputType.number,
                                      maxlength: 5,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            //_showConfirmationDialog(context);
                                          },
                                          child: Container(
                                            color: Colors.red,
                                            height: 50,
                                            child: Center(
                                                child: Text('Reset',
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              isOldAndNewPatientVisible = true;
                                            });
                                            // Navigator.of(context).push(MaterialPageRoute(
                                            //     builder: (context) =>
                                            //     const DetailsIndentDemand()));
                                          },
                                          child: Container(
                                            color: Colors.blue,
                                            height: 50,
                                            child: Center(
                                              child: Text(
                                                'Proceed',
                                                style: TextStyle(
                                                    color: Colors.white),
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
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isOldAndNewPatientVisible,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.white,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Old And New Patients',
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
                                      'Old Patient',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: EditTextSimple(
                                      controllers: totalOldPatientsController,
                                      focusNode: totalOldPatientsFocusNode,
                                      hint: '0',
                                      readOnly: false,
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
                                      'New Patient',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: EditTextSimple(
                                      controllers: totalNewPatientsController,
                                      focusNode: totalNewPatientsFocusNode,
                                      hint: '0',
                                      readOnly: false,
                                      keyboardTypes: TextInputType.number,
                                      maxlength: 5,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            //_showConfirmationDialog(context);
                                          },
                                          child: Container(
                                            color: Colors.red,
                                            height: 50,
                                            child: Center(
                                                child: Text('Reset',
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              isAgeGroupVisible = true;
                                            });
                                            // Navigator.of(context).push(MaterialPageRoute(
                                            //     builder: (context) =>
                                            //     const DetailsIndentDemand()));
                                          },
                                          child: Container(
                                            color: Colors.blue,
                                            height: 50,
                                            child: Center(
                                              child: Text(
                                                'Proceed',
                                                style: TextStyle(
                                                    color: Colors.white),
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
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isAgeGroupVisible,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.white,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Age Group',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Patient aged 0 to 10 years',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: EditTextSimple(
                                      controllers:
                                          totalPatientAged_0_to10_yearsController,
                                      focusNode:
                                          totalPatientAged_0_to10_FocusNode,
                                      hint: '0',
                                      readOnly: false,
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
                                      'Patient aged 11 to 20 years',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: EditTextSimple(
                                      controllers:
                                          totalPatientAged_11_to20_Controller,
                                      focusNode:
                                          totalPatientAged_11_to20_FocusNode,
                                      hint: '0',
                                      readOnly: false,
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
                                      'Patient aged 21 to 30 years',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: EditTextSimple(
                                      controllers:
                                          totalPatientAged_21_to30_Controller,
                                      focusNode:
                                          totalPatientAged_21_to30_FocusNode,
                                      hint: '0',
                                      readOnly: false,
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
                                      'Patient aged 31 to 45 years',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: EditTextSimple(
                                      controllers:
                                          totalPatientAged_31_to45_Controller,
                                      focusNode:
                                          totalPatientAged_31_to45_FocusNode,
                                      hint: '0',
                                      readOnly: false,
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
                                      'Patient aged 46 to 60 years',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: EditTextSimple(
                                      controllers:
                                          totalPatientAged_46_to60_Controller,
                                      focusNode:
                                          totalPatientAged_46_to60_FocusNode,
                                      hint: '0',
                                      readOnly: false,
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
                                      'Patient aged above 60 years',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: EditTextSimple(
                                      controllers:
                                          totalPatientAgedAbove_60_Controller,
                                      focusNode:
                                          totalPatientAgedAbove_60_FocusNode,
                                      hint: '0',
                                      readOnly: false,
                                      keyboardTypes: TextInputType.number,
                                      maxlength: 5,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            //_showConfirmationDialog(context);
                                          },
                                          child: Container(
                                            color: Colors.red,
                                            height: 50,
                                            child: Center(
                                                child: Text('Reset',
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              isAdhaarVisible = true;
                                            });
                                            // Navigator.of(context).push(MaterialPageRoute(
                                            //     builder: (context) =>
                                            //     const DetailsIndentDemand()));
                                          },
                                          child: Container(
                                            color: Colors.blue,
                                            height: 50,
                                            child: Center(
                                              child: Text(
                                                'Proceed',
                                                style: TextStyle(
                                                    color: Colors.white),
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
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isAdhaarVisible,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.white,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Adhaar/Mobile No Patient',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Adhaar',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: EditTextSimple(
                                      controllers:
                                          totalAdharSeededPatientsController,
                                      focusNode:
                                          totalAdharSeededPatientsFocusNode,
                                      hint: '0',
                                      readOnly: false,
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
                                      'Mobile No',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: EditTextSimple(
                                      controllers:
                                          totalMobileSeededPatientsController,
                                      focusNode:
                                          totalMobileSeededPatientsFocusNode,
                                      hint: '0',
                                      readOnly: false,
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
                                      'Other Id (Voter Id/Ration Card)',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: EditTextSimple(
                                      controllers:
                                          totalOtherIdSeededPatientsController,
                                      focusNode:
                                          totalOtherIdSeededPatientsFocusNode,
                                      hint: '0',
                                      readOnly: false,
                                      keyboardTypes: TextInputType.number,
                                      maxlength: 5,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            //_showConfirmationDialog(context);
                                          },
                                          child: Container(
                                            color: Colors.red,
                                            height: 50,
                                            child: Center(
                                                child: Text('Reset',
                                                    style: TextStyle(
                                                        color: Colors.white))),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            // Navigator.of(context).push(MaterialPageRoute(
                                            //     builder: (context) =>
                                            //     const DetailsIndentDemand()));
                                          },
                                          child: Container(
                                            color: Colors.blue,
                                            height: 50,
                                            child: Center(
                                              child: Text(
                                                'Proceed',
                                                style: TextStyle(
                                                    color: Colors.white),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
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
