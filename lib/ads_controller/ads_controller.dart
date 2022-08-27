import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_enhancer/utils/session_controller.dart';

class AdsController extends GetxController {
  RewardedAd? rewardedAd;
  InterstitialAd? interstitialAd;

  RxBool isRewardedAdReady = false.obs;
  RxBool isInterstitialAdReady = false.obs;

  Future<InitializationStatus> initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  // listener(AppLovinAdListener? event) {
  //   // log(event);
  //   // if (event == AppLovinAdListener.onUserRewarded) {
  //   //   log('👍get reward');
  //   // }

  //   if (event == AppLovinAdListener.onUserRewarded) {
  //     log('👍get rewarded adddd');
  //   }
  //   if (event == AppLovinAdListener.onAdDisplayFailed) {
  //     FlutterApplovinMax.showInterstitialVideo((AppLovinAdListener? event) {
  //       if (event == AppLovinAdListener.onUserRewarded) {
  //         log('👍get showInterstitialVideo');
  //       }
  //     });
  //   }
  //   update();
  // }

  void loadInterstitialAd() {
    InterstitialAd.load(
        adUnitId: SessionController.admob_interstetial_ad_id,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            interstitialAd = ad;
            interstitialAd!.setImmersiveMode(true);
            isInterstitialAdReady.value = true;
            update();
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
            isInterstitialAdReady.value = false;
            interstitialAd = null;
            update();
          },
        ));

    update();
  }

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: SessionController.admob_rewarded_ad_id,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              isRewardedAdReady.value = false;
              loadRewardedAd();
              update();
            },
          );

          isRewardedAdReady.value = true;
        },
        onAdFailedToLoad: (err) {
          log('Failed to load a rewarded ad: ${err.message}');
          isRewardedAdReady.value = false;
          update();
        },
      ),
    );
    update();
  }

  @override
  void dispose() {
    super.dispose();
    interstitialAd?.dispose();
    rewardedAd!.dispose();
  }
}
