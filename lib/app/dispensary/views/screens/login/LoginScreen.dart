import 'dart:convert';

import 'package:aimms/app/dispensary/views/screens/dashboard_dispensary/DashboardDispensary.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../resources/colors/colors.dart';
import '../../../../../resources/utils/EditTextSimple.dart';
import '../../../../../resources/utils/toasts.dart';
import '../../../../apis/allAPI.dart';
import '../../../../apis/baseUrl.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool scroll = false;
  bool halfUI = true;
  bool? check1 = true;
  TextEditingController userNameController = TextEditingController();
  FocusNode userNameFocusNode = FocusNode();

  TextEditingController userPasswordController = TextEditingController();
  FocusNode userPasswordFocusNode = FocusNode();
  bool _isObscure = true;

  var financialTypeItem = [];
  var financialDropdownValue;

  @override
  void initState() {
    // TODO: implement initState
    getFinancialYear();
    userNameController = TextEditingController(text: "");
    userPasswordController = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
    ));
    return SafeArea(
      child: Container(
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
        child: scroll
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Image.asset(
                            "assets/images/logo_aimms.png",
                            width: 100,
                            height: 80,
                          ),
                        ),
                        const Center(
                          child: Text(
                            "AiMMS",
                            style: TextStyle(
                                fontSize: 40,
                                fontFamily: 'Barlow',
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.normal,
                                color: AppColors.primaryColor),
                          ),
                        ),
                        const Center(
                          child: Text(
                            "Enter your credentials to login to your account",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: AppColors.primaryColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(35, 30, 35, 5),
                          child: EditTextSimple(
                            controllers: userNameController,
                            focusNode: userNameFocusNode,
                            hint: 'User Name',
                            keyboardTypes: TextInputType.text,
                            maxlength: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(35, 10, 35, 0),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  5.0), // Adjust the radius as needed
                            ),
                            child: TextField(
                              maxLength: 30,
                              controller: userPasswordController,
                              focusNode: userPasswordFocusNode,
                              obscureText: _isObscure,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Color(0xffC5C5C5), // Border color
                                    width: 0.5, // Border width
                                  ),
                                ),
                                counterText: "",
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.none),
                                labelStyle: const TextStyle(
                                    decoration: TextDecoration.none),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: IconButton(
                                    icon: Icon(_isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 50,
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
                                      'Select Session',
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
                                    items: financialTypeItem.map((item1) {
                                      return DropdownMenuItem(
                                        value: item1['FinYearID'],
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Text(
                                              item1['FinYearName'],
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                      );
                                    }).toList(),
                                    onChanged: (newVal1) {
                                      setState(() {
                                        financialDropdownValue = newVal1;
                                        print(
                                            'llllllllll----$financialDropdownValue');
                                      });
                                    },
                                    value: financialDropdownValue,
                                  ),
                                ),
                              ),
                            ],
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
                              "Submit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.normal),
                            ),
                            onPressed: () {
                              if (userNameController.text.isEmpty) {
                                toasts().redToastLong('Fill User Name');
                                userNameFocusNode.requestFocus();
                                return;
                              } else if (userPasswordController.text.isEmpty) {
                                toasts().redToastLong('Fill Password');
                                userPasswordFocusNode.requestFocus();
                                return;
                              } else if (financialDropdownValue == null) {
                                toasts().redToastLong('Select Session');
                                return;
                              } else {
                                dispensaryLogin();
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Image.asset(
                    "assets/images/login_footer.png",
                    width: 250,
                    height: 140,
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> getFinancialYear() async {
    setState(() {
      scroll = true;
    });

    var request = http.Request(
        'GET', Uri.parse(urls().base_url + allAPI().financialYearURL));
    var response = await request.send();
    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      financialTypeItem = results['data'];
      setState(() {
        scroll = false;
      });
    } else {
      toasts().redToastLong('Server Error');
      setState(() {
        scroll = false;
      });
    }
  }

  Future<void> dispensaryLogin() async {
    setState(() {
      scroll = true;
    });

    var request = http.Request(
        'POST',
        Uri.parse(urls().base_url +
            allAPI().dispensaryLoginURL +
            '?FinYearID=$financialDropdownValue&UserName=${userNameController.text}&Password=${userPasswordController.text}'));
    var response = await request.send();
    var results = jsonDecode(await response.stream.bytesToString());

    if (response.statusCode == 200) {
      print(await 'aaaaaaaaa-----${results}');
      if (results['status'] == 'success') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', '${results['token']}');
        prefs.setString('finYearID', '${results['FinYearID']}');
        setState(() {
          scroll = false;
        });
        toasts().redToastLong(results['message']);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const DashboardDispensary()));
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
