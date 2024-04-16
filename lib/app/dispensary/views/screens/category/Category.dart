import 'package:aimms/app/dispensary/views/screens/CategoryAyurvedic/category_ayurvedic.dart';
import 'package:flutter/material.dart';

import '../../../../../resources/colors/colors.dart';
import '../../../../../resources/utils/bottomNavigationBar.dart';
import '../../../../../resources/utils/moduleview_category.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height / 5.5),
          child: Container(
            color: Colors.white,
            child: Container(
              height: 150,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/dashboard_upper.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 0, 0),
                child: Text(
                  "Choose Category",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: AppColors.whiteColor),
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: const Drawer(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        height: double.infinity,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                children: [
                  InkWell(
                    child: const moduleview_category(
                      title: 'Ayurvedic',
                      path: 'assets/images/ic_ayurvedic.png',
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CategoryAyurvedic()));
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    child: const moduleview_category(
                      title: 'Unani',
                      path: 'assets/images/ic_unani.png',
                    ),
                    onTap: () {
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => homePage()));
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    child: const moduleview_category(
                      title: 'Homeopath',
                      path: 'assets/images/ic_homeopath.png',
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
      bottomNavigationBar: bottomNavigationBar(0),
    );
  }
}
