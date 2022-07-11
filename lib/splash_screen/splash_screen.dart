import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_enhancer/ads_controller/ads_controller.dart';
import 'package:image_enhancer/home_screen/home_screen.dart';
import 'package:image_enhancer/widgets/no_internet_controller.dart';

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

    Future.delayed(const Duration(seconds: 4), () {
      Get.to(() => const HomeScreen());
    });
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
          children: [
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
          ],
        ),
      ),
    );
  }
}
