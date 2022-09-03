import 'package:fgx_applovin/flutter_applovin_max.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_enhancer/splash_screen/splash_screen.dart';
import 'package:image_enhancer/utils/app_colors.dart';
import 'package:image_enhancer/utils/app_textstyle.dart';
import 'package:image_enhancer/utils/session_controller.dart';

import 'app_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();

  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  FlutterApplovinMax.initSDK();

  FlutterApplovinMax.initRewardAd(SessionController.applovin_rewarded_ad_id);
  FlutterApplovinMax.initInterstitialAd(
      SessionController.applovin_interstetial_ad_id);

  // FacebookAudienceNetwork.init(
  //   testingId: "944eede3-cd5c-4fee-84cd-9bca73588acf",
  //   iOSAdvertiserTrackingEnabled: true,
  // );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Enhance',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.whiteColor,
            titleTextStyle: AppTextStyle.black16,
            elevation: 2,
          ),
          scaffoldBackgroundColor: AppColors.whiteColor,
          iconTheme: IconThemeData(
            color: AppColors.blackColor,
          )),
      home: const SplashScreen(),
      initialBinding: createBindings(context),
    );
  }
}
