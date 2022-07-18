import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:image_enhancer/edit_screen/edit_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photofilters/filters/preset_filters.dart';
// ignore: depend_on_referenced_packages
import '../ads_controller/ads_controller.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:image/image.dart' as imagelib;
import '../ads_controller/load_ads_helper.dart';
import '../photo_filter/photo_filter_screen.dart';
import '../text_editor/text_editor.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_textstyle.dart';
import '../widgets/choose_photo_bottom_sheet.dart';
import '../widgets/gradient_container_design.dart';

class ListViewDesign extends StatefulWidget {
  const ListViewDesign({Key? key}) : super(key: key);

  @override
  State<ListViewDesign> createState() => _ListViewDesignState();
}

class _ListViewDesignState extends State<ListViewDesign> {
  AdsController ads = Get.find();
  // PurchaseApiController purchaseApiController = Get.find();
  String? fileName;
  File? imageFile;

  File? _userImage;
  List<String> imagesList = [
    AppImagesPath.enhanceCarousel,
    AppImagesPath.filterCarousel,
    AppImagesPath.textCarousel,
    AppImagesPath.hdrCarousel,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: imagesList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: GestureDetector(
            onTap: () {
              _showBottomSheet(
                context,
                index,
              );
            },
            child: SizedBox(
              width: 180,
              height: 180,
              child: Image.asset(
                imagesList[index],
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheet(
    BuildContext context,
    int index,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctz) {
        return ChoosePhotoBottomSheet(
          onChooseFromLibraryPressed: () {
            Get.back();
            _chooseImage(
              context,
              imageSource: ImageSource.gallery,
              index: index,
            );
          },
          onTakePhotoPressed: () {
            Get.back();
            _chooseImage(
              context,
              imageSource: ImageSource.camera,
              index: index,
            );
          },
        );
      },
    );
  }

  Future<void> _chooseImage(
    BuildContext context, {
    required ImageSource imageSource,
    required int index,
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
    if (_userImage != null) {
      log("this is the index ======= $index");
      /* -------------------------------------------------------------------------- */
      /*                                index ==== 0                                */
      /* -------------------------------------------------------------------------- */
      if (index == 0) {
        log(LoadAdsHelper.admobRewardAd.toString());
        log(ads.isRewardedAdReady.value.toString());

        if (ads.isRewardedAdReady.value && LoadAdsHelper.admobRewardAd) {
          Get.defaultDialog(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            radius: 20,
            title: "To get it free?",
            content: Column(
              children: [
                Text(
                  "Watch a video Ad",
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
                    ),
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    GradientContainerDesign(
                      height: 40,
                      width: 120,
                      title: "Ok",
                      onPressed: () {
                        ads.rewardedAd!.show(onUserEarnedReward: (ad, reward) {
                          Get.to(() => EditScreen(
                              buttonText: "Enhance",
                              userImage: userImage,
                              index: index));
                          ads.loadRewardedAd();
                        });
                      },
                      showTrailingIcon: false,
                      showLeadingWidget: false,
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          Get.to(() => EditScreen(
              buttonText: "Enhance", userImage: userImage, index: index));
        }
      }
      /* -------------------------------------------------------------------------- */
      /*                                index ==== 1                                */
      /* -------------------------------------------------------------------------- */
      else if (index == 1) {
        imageFile = File(userImage!.path);
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
                "Select Filter",
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
          Get.to(
            () => PhotoFilterSelector(
              title: Text(
                "Select Filter",
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
      /* -------------------------------------------------------------------------- */
      /*                                index ==== 2                                */
      /* -------------------------------------------------------------------------- */
      else if (index == 2) {
        if (ads.isInterstitialAdReady.value &&
            LoadAdsHelper.admobHomeScreeninterstitialAd) {
          ads.interstitialAd!.show();
          ads.loadInterstitialAd();
          Get.to(() => TextEditorScreen(
                buttonText: "Text Style",
                userImage: userImage,
                index: index,
              ));
        } else {
          Get.to(() => TextEditorScreen(
                buttonText: "Text Style",
                userImage: userImage,
                index: index,
              ));
        }
      }
      /* -------------------------------------------------------------------------- */
      /*                                index ==== 3                                */
      /* -------------------------------------------------------------------------- */
      else if (index == 3) {
        if (ads.isRewardedAdReady.value && LoadAdsHelper.admobRewardAd) {
          Get.defaultDialog(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            radius: 20,
            title: "To get it free?",
            content: Column(
              children: [
                Text(
                  "Watch a video Ad",
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
                    ),
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    GradientContainerDesign(
                      height: 40,
                      width: 120,
                      title: "Ok",
                      onPressed: () {
                        ads.rewardedAd!.show(onUserEarnedReward: (ad, reward) {
                          ads.loadRewardedAd();
                          Get.to(
                            () => EditScreen(
                                buttonText: "HDR",
                                userImage: userImage,
                                index: index),
                          );
                        });
                      },
                      showTrailingIcon: false,
                      showLeadingWidget: false,
                    ),
                  ],
                ),
              ],
            ),
          );
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
