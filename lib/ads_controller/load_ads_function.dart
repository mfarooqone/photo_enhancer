import 'dart:developer';

import 'package:fgx_applovin/flutter_applovin_max.dart';
import 'package:get/get.dart';

import 'ads_controller.dart';

class LoadAdClass {
  final AdsController ads = Get.find();
  Future<void> interstetialAd(
      bool admobHelper, bool applovinHelper, bool fbHelper) async {
    if (admobHelper) {
      ads.loadInterstitialAd();
      if (ads.isInterstitialAdReady.value) {
        ads.interstitialAd!.show();
      }
    } else if (fbHelper) {
      // ads.showFacebookInterstitialAd();
    } else if (applovinHelper) {
      FlutterApplovinMax.showInterstitialVideo((AppLovinAdListener? event) {
        print(event);
        ads.listener(event);
      });
    }
  }

  Future<void> rewardAd(
      bool admobHelper, bool applovinHelper, bool fbHelper) async {
    if (admobHelper) {
      ads.loadRewardedAd();
      if (ads.isRewardedAdReady.value) {
        ads.rewardedAd!.show(onUserEarnedReward: (ad, reward) {});
      }
    } else if (fbHelper) {
      // ads.showFacebookRewardedAd();
    } else if (applovinHelper) {
      log(applovinHelper.toString());
      FlutterApplovinMax.showRewardVideo((AppLovinAdListener? event) {
        print(event);
        log(event.toString());
        ads.listener(event);
      });
    }
  }
}
