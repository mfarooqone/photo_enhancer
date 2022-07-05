import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_applovin_max/flutter_applovin_max.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ads_helper.dart';

class AdsController extends GetxController {
  BannerAd? saveScreenBanner;
  BannerAd? filterScreenBanner;
  RewardedAd? rewardedAd;

  InterstitialAd? interstitialAd;
  RxBool isBannerAdReady = false.obs;
  RxBool isInterstitialAdReady = false.obs;
  RxBool isRewardedAdReady = false.obs;

  Future<InitializationStatus> initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  listener(AppLovinAdListener? event) {
    // log(event);
    // if (event == AppLovinAdListener.onUserRewarded) {
    //   log('👍get reward');
    // }

    if (event == AppLovinAdListener.onUserRewarded) {
      log('👍get rewarded adddd');
    }
    if (event == AppLovinAdListener.onAdDisplayFailed) {
      FlutterApplovinMax.showInterstitialVideo((AppLovinAdListener? event) {
        if (event == AppLovinAdListener.onUserRewarded) {
          log('👍get showInterstitialVideo');
        }
      });
    }
    update();
  }

  // bool isRewardedVideoAvailable = false;
  // bool isInterstitialVideoAvailable = true;

  void saveScreenBannerAdLoad() {
    saveScreenBanner = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isBannerAdReady.value = true;
          update();
        },
        onAdFailedToLoad: (ad, err) {
          if (kDebugMode) {
            log('Failed to load a banner ad: ${err.message}');
          }
          isBannerAdReady.value = false;
          ad.dispose();
        },
      ),
    );
    saveScreenBanner?.load();
    update();
  }

  void filterScreenBannerAdLoad() {
    filterScreenBanner = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isBannerAdReady.value = true;
          update();
        },
        onAdFailedToLoad: (ad, err) {
          if (kDebugMode) {
            log('Failed to load a banner ad: ${err.message}');
          }
          isBannerAdReady.value = false;
          ad.dispose();
        },
      ),
    );
    filterScreenBanner?.load();
    update();
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            log('$ad loaded');
            interstitialAd = ad;
            interstitialAd!.setImmersiveMode(true);
            isInterstitialAdReady.value = true;
            update();
          },
          onAdFailedToLoad: (LoadAdError error) {
            log('InterstitialAd failed to load: $error');
            isInterstitialAdReady.value = false;
            interstitialAd = null;

            update();
          },
        ));
    update();
  }

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
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
    saveScreenBanner?.dispose();
    interstitialAd?.dispose();
    rewardedAd!.dispose();
  }
}
