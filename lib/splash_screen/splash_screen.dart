import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_enhancer/ads_controller/ads_controller.dart';
import 'package:image_enhancer/splash_screen/privacy_screen.dart';
import 'package:image_enhancer/widgets/no_internet_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ads_controller/load_ads_function.dart';
import '../home_screen/home_screen.dart';
import '../utils/firebase_data.dart';
import '../utils/session_controller.dart';
import '../widgets/gradient_container_design.dart';
import 'exit_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AdsController ads = Get.put(AdsController(), permanent: true);
  bool isPrivacyScreen = false;
  getPreferencesData() async {
    final prefs = await SharedPreferences.getInstance();
    isPrivacyScreen = await prefs.getBool('isPrivacyScreen') ?? false;
  }

  bool splashLoading = true;
  void checkPurchase() async {
    FirebaseData().getFirebaseData().then((value) {
      ads.loadInterstitialAd();
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          splashLoading = false;
        });
      });
    });

    getPreferencesData();
  }

  Future<bool> _onWillPop() async {
    return (await Get.to(() => ExitScreen())) ?? false;
  }

  @override
  void initState() {
    Get.put(InternetConnectionController(), permanent: true);
    checkPurchase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
                    "Photo Enhancer AI - PhotoShoot",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: GradientContainerDesign(
                  title: splashLoading ? "Loading..." : "Get Started",
                  width: 150,
                  height: 50,
                  onPressed: () {
                    if (splashLoading) {
                    } else {
                      LoadAdClass().interstetialAd(
                          SessionController.admob_interstetial_splash_screen);
                      !isPrivacyScreen
                          ? Get.to(() => PrivacyScreen())
                          : Get.off(() => HomeScreen());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
