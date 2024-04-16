import 'package:aimms/app/dispensary/views/screens/indent/AddIndent.dart';
import 'package:flutter/material.dart';

import '../../../../../resources/colors/colors.dart';
import '../../../../../resources/utils/normalButton.dart';

class ViewIndent extends StatefulWidget {
  const ViewIndent({super.key});

  @override
  State<ViewIndent> createState() => _ViewIndentState();
}

class _ViewIndentState extends State<ViewIndent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        leadingWidth: 30,
        backgroundColor: AppColors.d1GradColor,
        title: Text("Indent Details",
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddIndent()));
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
                                    Row(
                                      children: [
                                        Text("Name : ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Barlow',
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor)),
                                        Text("Pentopan DSR",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: AppColors.primaryColor)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Category : ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Barlow',
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor)),
                                        Text("Capsule",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                color: AppColors.primaryColor)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Rate : ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Barlow',
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor)),
                                        Text("205/-",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                color: AppColors.primaryColor)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("GST : ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Barlow',
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor)),
                                        Text("23%",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                color: AppColors.primaryColor)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Qty : ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Barlow',
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor)),
                                        Text("250 pcs",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                color: AppColors.primaryColor)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Total : ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Barlow',
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor)),
                                        Text("25000/-",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                color: AppColors.primaryColor)),
                                      ],
                                    ),
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
                            name: 'View',
                            width: 80,
                            height: 30,
                            fontSize: 12,
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
