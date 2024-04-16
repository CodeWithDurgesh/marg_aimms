import 'package:aimms/app/dispensary/views/screens/medicine/ViewMedicine.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../../resources/colors/colors.dart';
import '../../../../../resources/utils/EditTextSimple.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  TextEditingController medicineNameController = TextEditingController();
  FocusNode medicineNameFocusNode = FocusNode();
  TextEditingController medicineRateController = TextEditingController();
  FocusNode medicineRateFocusNode = FocusNode();
  TextEditingController medicineQuantityController = TextEditingController();
  FocusNode medicineQuantityFocusNode = FocusNode();
  TextEditingController medicineGSTController = TextEditingController();
  FocusNode medicineGSTFocusNode = FocusNode();
  TextEditingController medicineTotalAmountController = TextEditingController();
  FocusNode medicineTotalAmountFocusNode = FocusNode();
  bool _isObscure = true;
  var financialTypeItem = [
    'Category Item -1',
    'Category Item -2',
    'Category Item -3',
    'Category Item -4'
  ];
  var financialDropdownValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        leadingWidth: 30,
        backgroundColor: AppColors.d1GradColor,
        title: Text("Add New Medicine",
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
                              items: financialTypeItem.map((item1) {
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 20, 35, 5),
                    child: EditTextSimple(
                      controllers: medicineNameController,
                      focusNode: medicineNameFocusNode,
                      hint: 'Medicine Name',
                      keyboardTypes: TextInputType.text,
                      maxlength: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 5),
                    child: EditTextSimple(
                      controllers: medicineRateController,
                      focusNode: medicineRateFocusNode,
                      hint: 'Rate',
                      keyboardTypes: TextInputType.text,
                      maxlength: 30,
                    ),
                  ),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 5),
                    child: EditTextSimple(
                      controllers: medicineGSTController,
                      focusNode: medicineGSTFocusNode,
                      hint: 'GST',
                      keyboardTypes: TextInputType.text,
                      maxlength: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 5),
                    child: EditTextSimple(
                      controllers: medicineTotalAmountController,
                      focusNode: medicineTotalAmountFocusNode,
                      hint: 'Total Amount',
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
                        "Save Medicine",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.normal),
                      ),
                      onPressed: () {
                       Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ViewMedicine()));
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
}
