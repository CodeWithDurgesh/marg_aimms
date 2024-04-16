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
import 'ViewOpeningStock.dart';

class AddOpeningStock extends StatefulWidget {
  const AddOpeningStock({super.key});

  @override
  State<AddOpeningStock> createState() => _AddOpeningStockState();
}

class _AddOpeningStockState extends State<AddOpeningStock> {
  var medicineCategories = [];
  var medicineNameByCategories = [];
  var openingBalanceMedicineQuantity;
  var chooseOptions = ['Ayush', 'Directorate'];
  String OpeningBalanceID = '0';
  String userToken = '';
  String streamID = '';
  String finYearID = '';
  String dispensaryID = '';
  String dispensaryTypeID = '';
  bool scroll = false;
  var optionDropdownValue;
  var _optionDropdownValue;
  var categoryDropdownValue;
  var medicineDropdownValue;
  TextEditingController medicineNameController = TextEditingController();
  FocusNode medicineNameFocusNode = FocusNode();
  TextEditingController medicineQuantityController = TextEditingController();
  FocusNode medicineQuantityFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    getUserToken();
    //medicineQuantityController = TextEditingController(text: openingBalanceMedicineQuantity.Quantity);
    super.initState();
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
        elevation: 0,
        foregroundColor: Colors.white,
        leadingWidth: 30,
        backgroundColor: AppColors.d1GradColor,
        title: Text("Add Opening Stock",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: AppColors.whiteColor)),
      ),
      body: scroll
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: double.infinity,
              width: double.infinity,
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
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
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
                                      'Select Option',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 16),
                                        child: Icon(Icons.keyboard_arrow_down),
                                      ),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      elevation: 1,
                                      maxHeight:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey[50],
                                      ),
                                    ),
                                    buttonStyleData: ButtonStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                    ),
                                    items: chooseOptions.map((item1) {
                                      return DropdownMenuItem(
                                        value: item1,
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Text(
                                              item1,
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                      );
                                    }).toList(),
                                    onChanged: (ctegoryValue1) {
                                      setState(() {
                                        optionDropdownValue = ctegoryValue1;
                                        if (optionDropdownValue == 'Ayush') {
                                          _optionDropdownValue = '1';
                                        } else {
                                          _optionDropdownValue = '2';
                                        }
                                        print(
                                            'Category Value @@@@@@@@$_optionDropdownValue');
                                      });
                                    },
                                    value: optionDropdownValue,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
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
                                        child: Icon(Icons.keyboard_arrow_down),
                                      ),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      elevation: 1,
                                      maxHeight:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey[50],
                                      ),
                                    ),
                                    buttonStyleData: ButtonStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
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
                                              style:
                                                  const TextStyle(fontSize: 12),
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
                                height: 15,
                              ),
                              Container(
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
                                        child: Icon(Icons.keyboard_arrow_down),
                                      ),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      elevation: 1,
                                      maxHeight:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey[50],
                                      ),
                                    ),
                                    buttonStyleData: ButtonStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
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
                                          style: const TextStyle(fontSize: 12),
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
                                        getOpeningBalanceMedicineQuantity();
                                      });
                                    },
                                    value: medicineDropdownValue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        /*Padding(
                          padding: const EdgeInsets.fromLTRB(35, 20, 35, 5),
                          child: EditTextSimple(
                            controllers: medicineNameController,
                            focusNode: medicineNameFocusNode,
                            hint: 'Medicine Name',
                            keyboardTypes: TextInputType.text,
                            maxlength: 30,
                          ),
                        ),*/
                        Padding(
                          padding: const EdgeInsets.fromLTRB(35, 10, 35, 5),
                          child: EditTextSimple(
                            controllers: medicineQuantityController,
                            focusNode: medicineQuantityFocusNode,
                            hint: 'Quantity',
                            keyboardTypes: TextInputType.text,
                            maxlength: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(35, 10, 35, 0),
                          height: 60,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                            ),
                            child: const Text(
                              "Save Opening Stock",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.normal),
                            ),
                            onPressed: () {
                              if (optionDropdownValue == null) {
                                toasts().redToastLong('Select Options First');
                                return;
                              } else if (categoryDropdownValue == null) {
                                toasts().redToastLong('Select Category');
                                return;
                              } else if (medicineDropdownValue == null) {
                                toasts().redToastLong('Select Medicine');
                                return;
                              } else {
                                postOpeningStock();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
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

  Future<void> getOpeningBalanceMedicineQuantity() async {
    setState(() {
      scroll = true;
    });
    var headers = {'Authorization': 'Bearer $userToken'};

    var request = http.Request(
        'GET',
        Uri.parse(urls().base_url +
            allAPI().getOpeningBalanceMedicineQuantity +
            '?StreamID=$streamID&FinYearID=$finYearID&MissionDirectorate=1&DispensaryID=$dispensaryID&DispensaryTypeID=$dispensaryTypeID&MCategoryID=$categoryDropdownValue&MedicineID=$medicineDropdownValue'));
    request.headers.addAll(headers);
    var response = await request.send();
    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(
          await 'getOpeningBalanceMedicineQuantity@@@@@@@@@@@-----${results}');
      if (results['status'] == 'success') {
        openingBalanceMedicineQuantity = results['data'];
        medicineQuantityController.text = openingBalanceMedicineQuantity == null
            ? "0"
            : openingBalanceMedicineQuantity['Quantity'].toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('OpeningBalanceID',
            openingBalanceMedicineQuantity['OpeningBalanceID'].toString());
        print(
            await 'getOpeningBalanceMedicineQuantity@@@@@@@@@@@-----Print Successfully$openingBalanceMedicineQuantity');
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

  Future<void> postOpeningStock() async {
    setState(() {
      scroll = true;
    });

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    };

    var request = http.Request('POST',
        Uri.parse(urls().base_url + allAPI().createOrUpdateOpeningBalance));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    OpeningBalanceID = prefs.getString('OpeningBalanceID')!;
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    request.body = json.encode({
      "OpeningBalanceID": OpeningBalanceID,
      "StreamID": streamID,
      "DispensaryTypeID": dispensaryTypeID,
      "DispensaryID": dispensaryID,
      "MCategoryID": categoryDropdownValue,
      "MedicineID": medicineDropdownValue,
      "Quantity": medicineQuantityController.text.toString(),
      "MissionDirectorate": _optionDropdownValue,
      "AsOnDate": formattedDate,
      "FinYearID": finYearID
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
            MaterialPageRoute(builder: (context) => const ViewOpeningStock()));
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
