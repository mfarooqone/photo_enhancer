import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_enhancer/ads_controller/ads_controller.dart';
import 'package:image_enhancer/drawer_design/drawer_design.dart';
import 'package:image_enhancer/utils/app_colors.dart';
import 'package:image_enhancer/utils/app_textstyle.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

import '../ads_controller/load_ads_helper.dart';
import '../selected_image/selected_image.dart';
import '../widgets/gradient_container_design.dart';
import 'listview_design.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AdsController ads = Get.find();
  // PurchaseApiController purchaseApiController = Get.find();

  @override
  void initState() {
    if (LoadAdsHelper.admobHomeScreeninterstitialAd) {
      ads.loadInterstitialAd();
    }
    if (LoadAdsHelper.admobRewardAd) {
      ads.loadRewardedAd();
    }
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await Get.defaultDialog(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            radius: 20,
            title: "Exit App",
            content: Column(
              children: [
                Text(
                  "Are you sure you want to exit?",
                  style: AppTextStyle.black14,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GradientContainerDesign(
                      height: 40,
                      width: 120,
                      title: "Cancel",
                      onPressed: () {
                        Get.back();
                      },
                      showTrailingIcon: false,
                      showLeadingWidget: true,
                      leading: Icon(
                        Icons.close_rounded,
                        size: 15,
                        color: AppColors.blackColor,
                      ),
                    ),
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    GradientContainerDesign(
                      height: 40,
                      width: 120,
                      title: "Exit",
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      showTrailingIcon: false,
                      showLeadingWidget: true,
                      leading: Icon(
                        Icons.exit_to_app_outlined,
                        size: 15,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ],
            ))) ??
        false;
  }

  bool isBotomSheet = false;
  File? _userImage;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (isBotomSheet) {
              isBotomSheet = false;
            }
          });
        },
        child: Scaffold(
          key: _scaffoldKey,
          drawer: const DrawerDesign(),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Photo Enhancer",
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: IconButton(
                iconSize: 35,
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: Icon(
                  Icons.menu_rounded,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            // actions: [
            //   IconButton(
            //     iconSize: 50,
            //     onPressed: () {
            //       Get.to(() => const SubscriptionsPage());
            //     },
            //     icon: Icon(
            //       Icons.workspace_premium_rounded,
            //       size: 25,
            //       color: AppColors.blackColor,
            //     ),
            //   )
            // ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: const [
                    SizedBox(
                      height: 13,
                    ),
                    ListViewDesign(),
                    SizedBox(
                      height: 84,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showActions() {
    return Container(
      color: Colors.transparent,
      height: 80,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            height: 50,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.orange,
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF7E03FB),
                    Color(0xFFDC01F9),
                    Color(0xFFF20080),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isBotomSheet = !isBotomSheet;
                  });
                },
                child: Icon(
                  Icons.add,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheetDesign() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: ShapeOfView(
          width: 320,
          height: 136,
          elevation: 0.5,
          shape: BubbleShape(
            position: BubblePosition.Bottom,
            arrowPositionPercent: 0.5,
            borderRadius: 20,
            arrowHeight: 10,
            arrowWidth: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientContainerDesign(
                height: 48,
                width: 290,
                title: "Camera",
                leading: Image.asset(
                  "assets/camera.png",
                  width: 24,
                  height: 24,
                ),
                showLeadingWidget: true,
                onPressed: () {
                  Get.back();
                  _chooseImage(
                    context,
                    imageSource: ImageSource.camera,
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GradientContainerDesign(
                height: 48,
                width: 290,
                title: "Gallery",
                leading: Image.asset(
                  "assets/gallery.png",
                  width: 24,
                  height: 24,
                ),
                showLeadingWidget: true,
                onPressed: () {
                  _chooseImage(
                    context,
                    imageSource: ImageSource.gallery,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
  //
  //
  Future<void> _chooseImage(
    BuildContext context, {
    required ImageSource imageSource,
  }) async {
    final image = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 2048.0,
      maxHeight: 2048.0,
    );
    if (image != null) {
      final imageFile = File(image.path);
      // setState(() {
      isBotomSheet = false;
      _userImage = imageFile;

      Get.to(
        () => SelectedImage(
          userImage: _userImage,
        ),
      );
    }
  }
}
