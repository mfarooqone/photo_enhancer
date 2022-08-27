import 'package:get/get.dart';

import 'ads_controller.dart';

class LoadAdClass {
  final AdsController ads = Get.find();
  Future<void> interstetialAd(bool helperValue) async {
    if (helperValue) {
      ads.loadInterstitialAd();
      if (ads.isInterstitialAdReady.value) {
        ads.interstitialAd!.show();
      }
    }
  }

  Future<void> rewardAd(bool helperValue) async {
    if (helperValue) {
      ads.loadRewardedAd();
      if (ads.isRewardedAdReady.value) {
        ads.rewardedAd!.show(onUserEarnedReward: (ad, reward) {});
      }
    }
  }
}
