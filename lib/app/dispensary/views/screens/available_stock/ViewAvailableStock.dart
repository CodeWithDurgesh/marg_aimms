import 'package:flutter/material.dart';

import '../../../../../resources/colors/colors.dart';
import '../../../../../resources/utils/normalButton.dart';

class ViewAvailableStock extends StatefulWidget {
  const ViewAvailableStock({super.key});

  @override
  State<ViewAvailableStock> createState() => _ViewAvailableStockState();
}

class _ViewAvailableStockState extends State<ViewAvailableStock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        leadingWidth: 30,
        backgroundColor: AppColors.d1GradColor,
        title: Text("Available Stock",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: AppColors.whiteColor)),
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
                                    Text("Name - Qutan 25",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Barlow',
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryColor)),
                                    Text("Category - Tablet",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Barlow',
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryColor)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: normalButton(
                            name: 'Quantity - 2500',
                            width: 100,
                            height: 35,
                            fontSize: 10,
                            bordeRadious: 20,
                            textColor: Colors.white,
                            bckColor: AppColors.d1GradColor,
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
