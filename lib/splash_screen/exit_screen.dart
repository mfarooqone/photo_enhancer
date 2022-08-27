import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../ads_controller/ads_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/gradient_container_design.dart';

class ExitScreen extends StatefulWidget {
  const ExitScreen({Key? key}) : super(key: key);

  @override
  State<ExitScreen> createState() => _ExitScreenState();
}

class _ExitScreenState extends State<ExitScreen> {
  final AdsController ads = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Exit",
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
            ),
            Image.asset(
              "assets/exit.png",
              width: 300,
              height: 300,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Exit",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Are you sure, you want to exit?",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.lightGreyColor,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientContainerDesign(
                  title: "Exit",
                  width: 120,
                  height: 35,
                  onPressed: () {
                    Get.defaultDialog(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      title: "Confirm Exit",
                      middleText: "",
                      middleTextStyle: TextStyle(fontSize: 0),
                      titlePadding: EdgeInsets.only(left: 0, top: 16),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GradientContainerDesign(
                              title: "No",
                              width: 120,
                              height: 35,
                              onPressed: () {
                                Get.back();
                                Get.back();
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GradientContainerDesign(
                              title: "Exit",
                              width: 120,
                              height: 35,
                              onPressed: () {
                                SystemNavigator.pop();
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                GradientContainerDesign(
                  title: "No",
                  width: 120,
                  height: 35,
                  onPressed: () {
                    Get.back();
                  },
                ),

                // InkWell(
                //   onTap: () {

                //   },
                //   child: GradientContainerDesign(
                //     title: "Exit",
                //     width: 160,
                //     height: 40,
                //     onPressed: () {},
                //   ),
                // ),
                SizedBox(
                  width: 10,
                ),
                // InkWell(
                //   onTap: () {
                //     Get.to(() => PurchaseScreen());
                //   },
                //   child: Container(
                //     width: 160,
                //     height: 40,
                //     decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //         begin: Alignment.topCenter,
                //         end: Alignment.bottomCenter,
                //         colors: [
                //           Color(0xFFDBA631),
                //           Color(0xFFD8BD62),
                //           Color(0xFFF1DD80),
                //           Color(0xFFFBF2A8),
                //           Color(0xFFF1DD80),
                //           Color(0xFFDBA631),
                //         ],
                //       ),
                //       borderRadius: BorderRadius.circular(6),
                //     ),
                //     child: Center(
                //       child: Text(
                //         AppLabels.goPremium.tr,
                //         style: TextStyle(),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
