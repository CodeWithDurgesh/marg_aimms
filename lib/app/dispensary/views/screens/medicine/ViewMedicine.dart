import 'package:aimms/app/dispensary/views/screens/medicine/AddMedicine.dart';
import 'package:aimms/resources/utils/normalButton.dart';
import 'package:flutter/material.dart';

import '../../../../../resources/colors/colors.dart';

class ViewMedicine extends StatefulWidget {
  const ViewMedicine({super.key});

  @override
  State<ViewMedicine> createState() => _ViewMedicineState();
}

class _ViewMedicineState extends State<ViewMedicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        leadingWidth: 30,
        backgroundColor: AppColors.d1GradColor,
        title: Text("Medicine Details",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: AppColors.whiteColor)),
        actions: [
          IconButton(
            icon: Image.asset(
              color: Colors.white,
              "assets/images/add_medicine_new.png",
              width: 80,
              height: 80,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddMedicine()));
            },
          ),
        ],
      ),
      body: Container(
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
        child:  ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Pentopan DSR (Capsule)",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Barlow',
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryColor)),
                                    Text(
                                      "Pentopan DSR Capsule Capsule PR is a prescription medicine used to treat gastroesophageal reflux disease (Acid reflux), dyspepsia (indigestion), and gastritis. It helps treat the conditions by reducing the amount of acid in the stomach thereby relieving symptoms of acidity such as heartburn, stomach pain, or irritation.",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Barlow',
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.blackColor),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: normalButton(
                            name: 'View More',
                            width: 70,
                            height: 20,
                            fontSize: 8,
                            bordeRadious: 20,
                            textColor: Colors.white,
                            bckColor: AppColors.greenTextColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                    )
                  ],
                );
              }),

      ),
    );
  }
}
