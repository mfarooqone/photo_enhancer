import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_applovin_max/flutter_applovin_max.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as imagelib;
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:image_enhancer/ads_controller/ads_controller.dart';
import 'package:image_enhancer/edit_screen/edit_screen.dart';
import 'package:photofilters/filters/preset_filters.dart';

import '../ads_controller/load_ads_helper.dart';
import '../photo_filter/photo_filter_screen.dart';
import '../purchase/purchase_api_controller.dart';
import '../text_editor/text_editor.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';

class GridViewDesign extends StatefulWidget {
  const GridViewDesign({Key? key}) : super(key: key);

  @override
  State<GridViewDesign> createState() => _GridViewDesignState();
}

class _GridViewDesignState extends State<GridViewDesign> {
  AdsController ads = Get.find();
  PurchaseApiController purchaseApiController = Get.find();
  String? fileName;
  File? imageFile;

  File? _userImage;
  List<String> imagesList = [
    AppImagesPath.enhance,
    AppImagesPath.filter,
    AppImagesPath.text,
    AppImagesPath.hdr,
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(42, 24, 42, 0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 42,
        crossAxisSpacing: 42,
        crossAxisCount: 2,
      ),
      itemCount: imagesList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            _chooseImage(
              context,
              index,
              imageSource: ImageSource.gallery,
            );
          },
          child: SizedBox(
            width: 117,
            height: 117,
            child: Image.asset(
              imagesList[index],
            ),
          ),
        );
      },
    );
  }

  Future<void> _chooseImage(
    BuildContext context,
    int index, {
    required ImageSource imageSource,
  }) async {
    final image = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 2048.0,
      maxHeight: 2048.0,
    );
    if (image != null) {
      final imageFile = File(image.path);
      setState(() {
        _userImage = imageFile;
        tapped(index, _userImage!);
      });
    }
  }

  void tapped(int index, File? userImage) async {
    log(purchaseApiController.isPurchased.value.toString());
    if (_userImage != null) {
      if (index == 0) {
        if (purchaseApiController.isPurchased.value == true) {
          Get.to(() => EditScreen(
              buttonText: "Enhance", userImage: userImage, index: index));
        } else {
          if (LoadAdsHelper.admobRewardAd || LoadAdsHelper.applovinRewardAd) {
            Get.to(
              () => EditScreen(
                  buttonText: "Enhance", userImage: userImage, index: index),
            );
            if (ads.isRewardedAdReady.value) {
              ads.rewardedAd!.show(onUserEarnedReward: (ad, reward) {
                ads.loadRewardedAd();
              });
            } else {
              FlutterApplovinMax.showRewardVideo((AppLovinAdListener? event) {
                ads.listener(event);
              });
            }
          } else {
            Get.to(() => EditScreen(
                buttonText: "Enhance", userImage: userImage, index: index));
          }
        }
      } else if (index == 1) {
        imageFile = File(userImage!.path);
        fileName = basename(imageFile!.path);
        List<int> bytes = await imageFile!.readAsBytes();
        var image = imagelib.decodeImage(bytes);
        image = imagelib.copyResize(image!, width: 600);

        if (purchaseApiController.isPurchased.value) {
          Get.to(
            () => PhotoFilterSelector(
              title: Text(
                "My Edited Image",
                style: TextStyle(color: AppColors.blackColor),
              ),
              image: image!,
              filters: presetFiltersList,
              filename: fileName!,
              loader: const SpinKitSpinningLines(color: Colors.black),
              fit: BoxFit.contain,
              userImage: userImage,
            ),
          );
        } else {
          if (LoadAdsHelper.admobHomeScreeninterstitialAd ||
              LoadAdsHelper.applovinHomeScreeninterstitialAd) {
            Get.to(
              () => PhotoFilterSelector(
                title: Text(
                  "My Edited Image",
                  style: TextStyle(color: AppColors.blackColor),
                ),
                image: image!,
                filters: presetFiltersList,
                filename: fileName!,
                loader: const SpinKitSpinningLines(color: Colors.black),
                fit: BoxFit.contain,
                userImage: userImage,
              ),
            );
            if (ads.isInterstitialAdReady.value) {
              ads.interstitialAd!.show();
              ads.loadInterstitialAd();
            }
            FlutterApplovinMax.showInterstitialVideo(
                (AppLovinAdListener? event) {
              ads.listener(event);
            });
          } else {
            Get.to(
              () => PhotoFilterSelector(
                title: Text(
                  "My Edited Image",
                  style: TextStyle(color: AppColors.blackColor),
                ),
                image: image!,
                filters: presetFiltersList,
                filename: fileName!,
                loader: const SpinKitSpinningLines(color: Colors.black),
                fit: BoxFit.contain,
                userImage: userImage,
              ),
            );
          }
        }
      } else if (index == 2) {
        if (purchaseApiController.isPurchased.value) {
          Get.to(() => TextEditorScreen(
                buttonText: "Text Style",
                userImage: userImage,
                index: index,
              ));
        } else {
          if (LoadAdsHelper.admobHomeScreeninterstitialAd ||
              LoadAdsHelper.applovinHomeScreeninterstitialAd) {
            Get.to(() => TextEditorScreen(
                  buttonText: "Text Style",
                  userImage: userImage,
                  index: index,
                ));
            if (ads.isInterstitialAdReady.value) {
              ads.interstitialAd!.show();
              ads.loadInterstitialAd();
            }
            FlutterApplovinMax.showInterstitialVideo(
                (AppLovinAdListener? event) {
              ads.listener(event);
            });
          } else {
            Get.to(() => TextEditorScreen(
                  buttonText: "Text Style",
                  userImage: userImage,
                  index: index,
                ));
          }
        }
      } else if (index == 3) {
        if (purchaseApiController.isPurchased.value) {
          Get.to(
            () => EditScreen(
                buttonText: "HDR", userImage: userImage, index: index),
          );
        } else {
          if (LoadAdsHelper.admobRewardAd || LoadAdsHelper.applovinRewardAd) {
            Get.to(
              () => EditScreen(
                  buttonText: "HDR", userImage: userImage, index: index),
            );
            if (ads.isRewardedAdReady.value) {
              ads.rewardedAd!.show(onUserEarnedReward: (ad, reward) {
                ads.loadRewardedAd();
              });
            } else {
              FlutterApplovinMax.showRewardVideo((AppLovinAdListener? event) {
                ads.listener(event);
              });
            }
          } else {
            Get.to(
              () => EditScreen(
                  buttonText: "HDR", userImage: userImage, index: index),
            );
          }
        }
      }
    }
  }
}
