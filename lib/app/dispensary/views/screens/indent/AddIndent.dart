import 'package:aimms/app/dispensary/views/screens/indent/ViewIndent.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../resources/colors/colors.dart';
import '../../../../../resources/utils/EditTextSimple.dart';

class AddIndent extends StatefulWidget {
  const AddIndent({super.key});

  @override
  State<AddIndent> createState() => _AddIndentState();
}

class _AddIndentState extends State<AddIndent> {
  TextEditingController dobController = TextEditingController();
  DateTime? selectedDate;
  var indentForItem = [
    'Ayush Mission',
    'Directorate',
  ];
  var indentForDropdownValue;
  TextEditingController dateOfIndentController = TextEditingController();
  FocusNode dateOfIndentFocusNode = FocusNode();
  TextEditingController intentValueController = TextEditingController();
  FocusNode intentValueFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        leadingWidth: 30,
        backgroundColor: AppColors.d1GradColor,
        title: Text("Add Indent",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: AppColors.whiteColor)),
      ),
      body: Container(
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
                                'Select Indent For',
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
                                    MediaQuery.of(context).size.height / 2,
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
                              items: indentForItem.map((item1) {
                                return DropdownMenuItem(
                                  value: item1,
                                  child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        item1,
                                        style: const TextStyle(fontSize: 12),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                );
                              }).toList(),
                              onChanged: (newVal1) {
                                setState(() {
                                  indentForDropdownValue = newVal1;
                                  print(
                                      'Indent For Dropdown Value@@@@@@$indentForDropdownValue');
                                });
                              },
                              value: indentForDropdownValue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 20, 35, 5),
                    child: EditTextSimple(
                      onTap: () {
                        _selectDate(context);
                      },
                      controllers: dateOfIndentController,
                      focusNode: dateOfIndentFocusNode,
                      hint: 'Date Of Indent',
                      keyboardTypes: TextInputType.datetime,
                      maxlength: 30,

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 5),
                    child: EditTextSimple(
                      controllers: intentValueController,
                      focusNode: intentValueFocusNode,
                      hint: 'Indent Value',
                      keyboardTypes: TextInputType.number,
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
                        "Add Indent",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.normal),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ViewIndent()));
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

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate != null ? selectedDate! : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext? context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppColors.buttonColor,
                onPrimary: Colors.black,
                surface: AppColors.whiteColor,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: AppColors.whiteColor,
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      setState(() {
        selectedDate = newSelectedDate;
        dateOfIndentController
          ..text = DateFormat("dd-MM-yyyy").format(selectedDate!)
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: dateOfIndentController.text.length,
              affinity: TextAffinity.upstream));
      });


    }
  }
}
