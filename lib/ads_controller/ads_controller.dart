import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_enhancer/utils/session_controller.dart';

enum AdLoadState { notLoaded, loading, loaded }

class AdsController extends GetxController {
  RewardedAd? rewardedAd;
  InterstitialAd? interstitialAd;

  RxBool isRewardedAdReady = false.obs;
  RxBool isInterstitialAdReady = false.obs;

  // bool isFBInterstitialAdLoaded = false;
  // bool isFBRewardedAdLoaded = false;

  Future<InitializationStatus> initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

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
          isRewardedAdReady.value = false;
          update();
        },
      ),
    );
    update();
  }

  /* -------------------------------------------------------------------------- */
  /*                                facebook ads                                */
  /* -------------------------------------------------------------------------- */

  // initializeServices() {
  //   // FacebookAudienceNetwork.init(
  //   //     testingId: "820972062394062", //optional
  //   //     iOSAdvertiserTrackingEnabled: true //default false
  //   //     );
  // }

  // loadFacebookInterstitialAd() {
  //   FacebookInterstitialAd.loadInterstitialAd(
  //     placementId: "IMG_16_9_APP_INSTALL#820972062394062_820980109059924",
  //     // placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
  //     // placementId: SessionController().facebook_interstetial_placement_id,
  //     listener: (result, value) {
  //       log(">> FAN > Interstitial Ad: $result --> $value");
  //       if (result == InterstitialAdResult.LOADED) {
  //         isFBInterstitialAdLoaded = true;
  //       }
  //       if (result == InterstitialAdResult.DISMISSED &&
  //           value["invalidated"] == true) {
  //         isFBInterstitialAdLoaded = false;
  //         loadFacebookInterstitialAd();
  //       }
  //     },
  //   );
  // }

  // showFacebookInterstitialAd() {
  //   if (isFBInterstitialAdLoaded == true) {
  //     FacebookInterstitialAd.showInterstitialAd();
  //   } else {
  //     loadFacebookInterstitialAd();
  //     log("Interstial Ad not yet loaded!");
  //   }
  // }

  // void loadFacebookRewardedVideoAd() {
  //   FacebookRewardedVideoAd.loadRewardedVideoAd(
  //     placementId: "IMG_16_9_APP_INSTALL#820972062394062_820981025726499",
  //     // placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
  //     listener: (result, value) {
  //       print("Rewarded Ad: $result --> $value");
  //       if (result == RewardedVideoAdResult.LOADED) isFBRewardedAdLoaded = true;
  //       if (result == RewardedVideoAdResult.VIDEO_COMPLETE) if (result ==
  //               RewardedVideoAdResult.VIDEO_CLOSED &&
  //           (value == true || value["invalidated"] == true)) {
  //         isFBRewardedAdLoaded = false;
  //         loadFacebookRewardedVideoAd();
  //       }
  //     },
  //   );
  // }

  // showFacebookRewardedAd() {
  //   if (isFBRewardedAdLoaded == true)
  //     FacebookRewardedVideoAd.showRewardedVideoAd();
  //   else
  //     log("Rewarded Ad not yet loaded!");
  // }

  @override
  void dispose() {
    super.dispose();
    interstitialAd?.dispose();
    rewardedAd!.dispose();
  }
}
