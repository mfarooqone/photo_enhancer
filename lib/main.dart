import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applovin_max/flutter_applovin_max.dart';
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
  FlutterApplovinMax.initSDK();

  await Firebase.initializeApp();
  if (Platform.isAndroid) {
    FlutterApplovinMax.initInterstitialAd('95ecc9de0b51cb23');
    FlutterApplovinMax.initRewardAd("eb1a99d6645a3fec");
  } else if (Platform.isIOS) {
    FlutterApplovinMax.initInterstitialAd('0d5ec160309435a9');
    FlutterApplovinMax.initRewardAd("6355d2be3d7b1531");
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
    super.initState();
  }

  void getData() async {
    await firestoreInstance.collection("ads").get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        log("***********************************");
        // print(result.data());
        log("***********************************");

        SessionController().admob_banner_ad_ios =
            result.data()["admob_banner_ad_ios"];

        SessionController().admob_banner_ad_android =
            result.data()["admob_banner_ad_android"];

        SessionController().admob_interstetial_ad_ios =
            result.data()["admob_interstetial_ad_ios"];

        SessionController().admob_interstetial_ad_android =
            result.data()["admob_interstetial_ad_android"];

        SessionController().admob_rewarded_ad_android =
            result.data()["admob_rewarded_ad_android"];

        SessionController().admob_rewarded_ad_ios =
            result.data()["admob_rewarded_ad_ios"];

        SessionController().admob_banner_save_screen_ios =
            result.data()["admob_banner_save_screen_ios"];

        SessionController().admob_banner_save_screen_android =
            result.data()["admob_banner_save_screen_android"];

        SessionController().admob_banner_filter_screen_ios =
            result.data()["admob_banner_filter_screen_ios"];

        SessionController().admob_banner_filter_screen_android =
            result.data()["admob_banner_filter_screen_android"];

        SessionController().admob_interstetial_home_screen_ios =
            result.data()["admob_interstetial_home_screen_ios"];

        SessionController().admob_interstetial_home_screen_android =
            result.data()["admob_interstetial_home_screen_android"];

        SessionController().admob_interstetial_save_screen_ios =
            result.data()["admob_interstetial_save_screen_ios"];

        SessionController().admob_interstetial_save_screen_android =
            result.data()["admob_interstetial_save_screen_android"];

        SessionController().admob_interstetial_select_screen_ios =
            result.data()["admob_interstetial_select_screen_ios"];

        SessionController().admob_interstetial_select_screen_android =
            result.data()["admob_interstetial_select_screen_android"];

        SessionController().admob_reward_ios =
            result.data()["admob_reward_ios"];

        SessionController().admob_reward_android =
            result.data()["admob_reward_android"];

/* -------------------------------------------------------------------------- */
/*                              applov in setting                             */
/* -------------------------------------------------------------------------- */

        SessionController().applovin_interstetial_home_screen_ios =
            result.data()["applovin_interstetial_home_screen_ios"];

        SessionController().applovin_interstetial_home_screen_android =
            result.data()["applovin_interstetial_home_screen_android"];

        SessionController().applovin_interstetial_save_screen_ios =
            result.data()["applovin_interstetial_save_screen_ios"];

        SessionController().applovin_interstetial_save_screen_android =
            result.data()["applovin_interstetial_save_screen_android"];

        SessionController().applovin_interstetial_select_screen_ios =
            result.data()["applovin_interstetial_select_screen_ios"];

        SessionController().applovin_interstetial_select_screen_android =
            result.data()["applovin_interstetial_select_screen_android"];

        SessionController().applovin_reward_android =
            result.data()["applovin_reward_android"];
        SessionController().applovin_reward_ios =
            result.data()["applovin_reward_ios"];
      }
    });
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
