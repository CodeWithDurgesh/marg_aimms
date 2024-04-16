import 'package:flutter/material.dart';

import '../../../../../resources/colors/colors.dart';
import '../../../../../resources/utils/bottomNavigationBar.dart';
import '../../../../../resources/utils/moduleview.dart';
import '../category/Category.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        leadingWidth: 30,
        backgroundColor: AppColors.d1GradColor,
        title: Image.asset(
          "assets/images/logo_with_name.png",
          width: 160,
          height: 50,
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              "assets/images/profile_pic.png",
              width: 60,
              height: 60,
            ),
            onPressed: () {
              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => userProfile()));
            },
          ),
        ],
      ),
      drawer: const Drawer(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(25, 10, 0, 0),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.d1GradColor,
              AppColors.d2GradColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome XYZ!",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor),
              ),
              const Text(
                "Please select a category",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: AppColors.whiteColor),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  primary: false,
                  children: [
                    InkWell(
                      child: const moduleview(
                        title: 'Ayush Mission',
                        path: 'assets/images/ayush_mission_logo_green.png',
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Category()));
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      child: const moduleview(
                        title: 'Directorate',
                        path: 'assets/images/directorate.png',
                      ),
                      onTap: () {
                        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => homePage()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(0),
    );
  }
}
