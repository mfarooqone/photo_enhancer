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
    } else if (applovinHelper) {}
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
    } else if (applovinHelper) {}
  }
}
