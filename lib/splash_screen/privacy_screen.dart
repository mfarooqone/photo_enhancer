import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ads_controller/ads_controller.dart';
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/privacy.png",
                    width: 250,
                    height: 250,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 48,
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
                        // TextSpan(
                        //   text: ' and ',
                        //   style: TextStyle(
                        //     color: Colors.grey[500],
                        //     fontSize: 17,
                        //   ),
                        // ),
                        // TextSpan(
                        //   text: "Terms & Conditions",
                        //   style: new TextStyle(
                        //     color: Color(0xFF007556),
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 17,
                        //   ),
                        //   recognizer: new TapGestureRecognizer()
                        //     ..onTap = () {
                        //       Uri url = Uri.parse("");

                        //       _launchUrl(url);
                        //     },
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: GradientContainerDesign(
                      title: "Continue",
                      width: 150,
                      height: 50,
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isPrivacyScreen', true);
                        LoadAdClass().interstetialAd(SessionController
                            .admob_interstetial_privacy_screen);
                        Get.to(() => HomeScreen());
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
