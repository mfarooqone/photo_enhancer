import 'dart:io';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as imagelib;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:image_enhancer/ads_controller/ads_controller.dart';
import 'package:image_enhancer/utils/app_colors.dart';
import 'package:image_enhancer/utils/app_textstyle.dart';
import 'package:photofilters/filters/preset_filters.dart';

import '../ads_controller/load_ads_helper.dart';
import '../edit_screen/edit_screen.dart';
import '../photo_filter/photo_filter_screen.dart';
import '../text_editor/text_editor.dart';
import '../utils/app_images.dart';

class SelectedImage extends StatefulWidget {
  const SelectedImage({
    Key? key,
    this.userImage,
  }) : super(key: key);

  final File? userImage;

  @override
  State<SelectedImage> createState() => _SelectedImageState();
}

class _SelectedImageState extends State<SelectedImage> {
  // PurchaseApiController purchaseApiController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Select Action",
          style: AppTextStyle.black16,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.close,
            color: AppColors.blackColor,
            size: 30,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(widget.userImage!),
                  fit: BoxFit.cover,
                ),
              ),
              child: BlurryContainer(
                blur: 20,
                width: double.infinity,
                height: double.infinity,
                borderRadius: BorderRadius.circular(0),
                child: const SizedBox(),
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            child: Image.file(
              widget.userImage!,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: showActions(),
          ),
        ],
      ),
    );
  }

  List<String> imagesList = [
    AppImagesPath.enhance,
    AppImagesPath.filter,
    AppImagesPath.text,
    AppImagesPath.hdr,
  ];
  List<String> buttonText = ["Enhance", "Filter", "Text", "HDR"];
  AdsController ads = Get.find();
  String? fileName;
  File? imageFile;
  Widget showActions() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              if (ads.isRewardedAdReady.value && LoadAdsHelper.admobRewardAd) {
                ads.rewardedAd!.show(onUserEarnedReward: (ad, reward) {
                  Get.to(
                    () => EditScreen(
                        buttonText: "Enhance",
                        userImage: widget.userImage!,
                        index: 0),
                  );
                  ads.loadRewardedAd();
                });
              } else {
                Get.to(() => EditScreen(
                    buttonText: "Enhance",
                    userImage: widget.userImage!,
                    index: 0));
              }
            },
            child: SizedBox(
              width: 84,
              height: 84,
              child: Image.asset(
                AppImagesPath.enhance,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              imageFile = File(widget.userImage!.path);
              fileName = basename(imageFile!.path);
              List<int> bytes = await imageFile!.readAsBytes();
              var image = imagelib.decodeImage(bytes);
              image = imagelib.copyResize(image!, width: 600);

              if (ads.isInterstitialAdReady.value &&
                  LoadAdsHelper.admobHomeScreeninterstitialAd) {
                ads.interstitialAd!.show();
                ads.loadInterstitialAd();
                Get.to(
                  () => PhotoFilterSelector(
                    title: Text(
                      "Apply Filter",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    image: image!,
                    filters: presetFiltersList,
                    filename: fileName!,
                    loader: const SpinKitSpinningLines(color: Colors.black),
                    fit: BoxFit.contain,
                    userImage: widget.userImage!,
                  ),
                );
              } else {
                Get.to(
                  () => PhotoFilterSelector(
                    title: Text(
                      "Apply Filter",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                    image: image!,
                    filters: presetFiltersList,
                    filename: fileName!,
                    loader: const SpinKitSpinningLines(color: Colors.black),
                    fit: BoxFit.contain,
                    userImage: widget.userImage!,
                  ),
                );
              }
            },
            child: SizedBox(
              width: 84,
              height: 84,
              child: Image.asset(
                AppImagesPath.filter,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (ads.isInterstitialAdReady.value &&
                  LoadAdsHelper.admobHomeScreeninterstitialAd) {
                ads.interstitialAd!.show();
                ads.loadInterstitialAd();
                Get.to(
                  () => TextEditorScreen(
                    buttonText: "Text Style",
                    userImage: widget.userImage!,
                    index: 2,
                  ),
                );
              } else {
                Get.to(() => TextEditorScreen(
                      buttonText: "Text Style",
                      userImage: widget.userImage!,
                      index: 2,
                    ));
              }
            },
            child: SizedBox(
              width: 84,
              height: 84,
              child: Image.asset(
                AppImagesPath.text,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (ads.isRewardedAdReady.value && LoadAdsHelper.admobRewardAd) {
                ads.rewardedAd!.show(onUserEarnedReward: (ad, reward) {
                  Get.to(
                    () => EditScreen(
                        buttonText: "HDR",
                        userImage: widget.userImage!,
                        index: 3),
                  );
                  ads.loadRewardedAd();
                });
              } else {
                Get.to(
                  () => EditScreen(
                      buttonText: "HDR",
                      userImage: widget.userImage!,
                      index: 3),
                );
              }
            },
            child: SizedBox(
              width: 84,
              height: 84,
              child: Image.asset(
                AppImagesPath.hdr,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
