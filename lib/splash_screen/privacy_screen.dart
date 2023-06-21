import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ads_controller/ads_controller.dart';
import '../ads_controller/banner_ad_widget.dart';
import '../ads_controller/load_ads_function.dart';
import '../home_screen/home_screen.dart';
import '../utils/session_controller.dart';
import '../widgets/gradient_container_design.dart';
import 'exit_screen.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  final AdsController ads = Get.find();
  void _launchUrl(url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await Get.to(() => ExitScreen())) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Privacy Policy",
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BannerAdWidget(
                adSize: AdSize.mediumRectangle,
                helperValue: true,
              ),
              Image.asset(
                "assets/privacy.png",
                width: 250,
                height: 250,
                fit: BoxFit.fill,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "By using this app, You agree to our ",
                      style: TextStyle(
                        height: 3,
                        color: Colors.grey[500],
                        fontSize: 17,
                      ),
                    ),
                    TextSpan(
                      text: "\nPrivacy Policy",
                      style: new TextStyle(
                        color: Color(0xFF007556),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          Uri url = Uri.parse(
                            "https://desiresol911.blogspot.com/p/privacy-policy-our-privacy-policy-helps.html",
                          );

                          _launchUrl(url);
                        },
                    ),
                  ],
                ),
              ),
              GradientContainerDesign(
                  title: "Continue",
                  width: 150,
                  height: 50,
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isPrivacyScreen', true);
                    LoadAdClass().interstetialAd(
                      SessionController.admob_interstetial_privacy_screen,
                      SessionController.applovin_interstetial_privacy_screen,
                      SessionController.fb_interstetial_privacy_screen,
                    );
                    Get.to(() => HomeScreen());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
