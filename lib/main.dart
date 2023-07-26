import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_enhancer/splash_screen/splash_screen.dart';
import 'package:image_enhancer/utils/app_colors.dart';
import 'package:image_enhancer/utils/app_textstyle.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app_bindings.dart';
import 'notification_setup/notification_setup.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initNotification();
  await MobileAds.instance.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
    NotificationService().initNotification();
    requestPermission();
    super.initState();
  }

  void requestPermission() async {
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      // notification permission is granted
    } else {
      Permission.notification;
      // Open settings to enable notification permission
    }
  }

  void getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    log(token ?? "");
  }

  @override
  Widget build(BuildContext context) {
    getToken();
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
