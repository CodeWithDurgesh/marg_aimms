import 'package:aimms/resources/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:shape_maker/shape_maker.dart';
import 'package:shape_maker/shape_maker_painter.dart';

import '../../../../../resources/utils/ayurvedic_category.dart';
import '../../../../../resources/utils/bottomNavigationBar.dart';
import '../../../../../resources/utils/normalButton.dart';

class CategoryAyurvedic extends StatefulWidget {
  const CategoryAyurvedic({super.key});

  @override
  State<CategoryAyurvedic> createState() => _CategoryAyurvedicState();
}

class _CategoryAyurvedicState extends State<CategoryAyurvedic> {
  bool showFilter = false;

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
            const Text(
              'Ayurvedic',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
      ),
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
          children: [
            Container(
              height: 150,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/dashboard_upper.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: AppColors.whiteColor,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      showFilter
                                          ? Container()
                                          : const RotatedBox(
                                              quarterTurns: 2,
                                              child: ShapeMaker(
                                                width: 100,
                                                height: 42,
                                                shapeType: ShapeType.triangle,
                                                bgColor:
                                                    AppColors.greenTextColor,
                                              ),
                                            ),
                                      Positioned(
                                        child: InkWell(
                                          child: normalButton(
                                            name: 'Session',
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            height: 35,
                                            bordeRadious: 5,
                                            fontSize: 14,
                                            textColor: showFilter
                                                ? Colors.black
                                                : Colors.white,
                                            bckColor: showFilter
                                                ? AppColors.whiteColor
                                                : AppColors.greenTextColor,
                                          ),
                                          onTap: () async {
                                            setState(() {
                                              showFilter = false;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      showFilter
                                          ? const RotatedBox(
                                              quarterTurns: 2,
                                              child: ShapeMaker(
                                                width: 100,
                                                height: 42,
                                                shapeType: ShapeType.triangle,
                                                bgColor:
                                                    AppColors.greenTextColor,
                                              ),
                                            )
                                          : Container(),
                                      Positioned(
                                        child: InkWell(
                                          child: normalButton(
                                            name: 'Statistics',
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            height: 35,
                                            bordeRadious: 5,
                                            fontSize: 14,
                                            textColor: showFilter
                                                ? Colors.white
                                                : Colors.black,
                                            bckColor: showFilter
                                                ? AppColors.greenTextColor
                                                : Colors.white,
                                          ),
                                          onTap: () {
                                            setState(() {
                                              showFilter = true;
                                            });
                                          },
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
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                showFilter
                    ? const Center(
                        child: Text(
                          "Statistics",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor),
                        ),
                      )
                    : const Center(
                        child: Text(
                          "Session",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    children: [
                      InkWell(
                        child: const ayurvedic_category(
                          title1: 'Budget Alloted',
                          title2: 'XXXXX',
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CategoryAyurvedic()));
                        },
                      ),
                      InkWell(
                        child: const ayurvedic_category(
                          title1: 'Opening Stock',
                          title2: 'XXXXX',
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CategoryAyurvedic()));
                        },
                      ),
                      InkWell(
                        child: const ayurvedic_category(
                          title1: 'Indent Raised',
                          title2: 'XXXXX',
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CategoryAyurvedic()));
                        },
                      ),
                      InkWell(
                        child: const ayurvedic_category(
                          title1: 'Medicine Received',
                          title2: 'XXXXX',
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CategoryAyurvedic()));
                        },
                      ),
                      InkWell(
                        child: const ayurvedic_category(
                          title1: 'Available Stock',
                          title2: 'XXXXX',
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CategoryAyurvedic()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(0),
    );
  }
}
