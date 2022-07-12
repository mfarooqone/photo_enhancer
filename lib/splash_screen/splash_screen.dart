import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_enhancer/ads_controller/ads_controller.dart';
import 'package:image_enhancer/widgets/gradient_container_design.dart';
import 'package:image_enhancer/widgets/no_internet_controller.dart';

import '../home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // var purchaseApiController = Get.put(PurchaseApiController(), permanent: true);
  @override
  void initState() {
    Get.put(AdsController(), permanent: true);
    Get.put(InternetConnectionController(), permanent: true);

    // purchaseApiController.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 100,
            ),
            BounceInDown(
              from: 400,
              delay: const Duration(milliseconds: 1000),
              child: Container(
                width: 162,
                height: 162,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  "assets/appicon.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Photo Enhancer - PhotoShoot",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GradientContainerDesign(
                title: "Get Started",
                width: 150,
                height: 50,
                onPressed: () {
                  Get.to(() => const HomeScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
