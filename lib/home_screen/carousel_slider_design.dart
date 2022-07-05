import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applovin_max/flutter_applovin_max.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as imagelib;
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:image_enhancer/utils/app_images.dart';
import 'package:photofilters/filters/preset_filters.dart';

import '../ads_controller/ads_controller.dart';
import '../ads_controller/load_ads_helper.dart';
import '../edit_screen/edit_screen.dart';
import '../photo_filter/photo_filter_screen.dart';
import '../purchase/purchase_api_controller.dart';
import '../text_editor/text_editor.dart';
import '../utils/app_colors.dart';

class CarouselSliderDesign extends StatefulWidget {
  const CarouselSliderDesign({Key? key}) : super(key: key);

  @override
  State<CarouselSliderDesign> createState() => _CarouselSliderDesignState();
}

class _CarouselSliderDesignState extends State<CarouselSliderDesign> {
  File? _userImage;
  final List<String> imagesList = [
    AppImagesPath.enhanceCarousel,
    AppImagesPath.filterCarousel,
    AppImagesPath.textCarousel,
    AppImagesPath.hdrCarousel,
  ];
  String? fileName;
  File? imageFile;
  AdsController ads = Get.find();
  PurchaseApiController purchaseApiController = Get.find();

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _chooseImage(
              context,
              _currentIndex,
              imageSource: ImageSource.gallery,
            );
          },
          child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 16 / 7.5,
              viewportFraction: 0.8,
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(
                  () {
                    _currentIndex = index;
                  },
                );
              },
            ),
            items: [
              AppImagesPath.enhanceCarousel,
              AppImagesPath.filterCarousel,
              AppImagesPath.textCarousel,
              AppImagesPath.hdrCarousel,
            ]
                .map(
                  (i) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      i,
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(
          height: 13,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imagesList.map((urlOfItem) {
            int index = imagesList.indexOf(urlOfItem);
            return Container(
              width: 10.0,
              height: 10.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? const Color.fromRGBO(0, 0, 0, 0.8)
                    : const Color.fromRGBO(0, 0, 0, 0.0),
              ),
            );
          }).toList(),
        ),
      ],
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
    if (_userImage != null) {
      if (index == 0) {
        if (purchaseApiController.isPurchased.value) {
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
                // log(event);
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
              // log(event);
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
              // log(event);
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
                // log(event);
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
