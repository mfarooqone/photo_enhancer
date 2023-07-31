import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_enhancer/utils/session_controller.dart';
import 'package:vungle/vungle.dart';

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

  ///
  ///
  ///
  ///
  RxBool sdkInit = false.obs;
  RxBool adLoaded = false.obs;

  void vungleAdsInit() {
    Vungle.onInitilizeListener = () {
      sdkInit.value = true;
    };
    Vungle.onAdPlayableListener = (placementId, playable) {
      if (playable) {
        adLoaded.value = true;
      }
    };
    Vungle.onAdStartedListener = (placementId) {
      print('ad started');
    };
    Vungle.onAdFinishedListener = (placementId, isCTAClicked, completedView) {
      print(
          'ad finished, isCTAClicked:($isCTAClicked), completedView:($completedView)');
      adLoaded.value = false;
    };
  }

  ///
  ///
  ///
  void vungleInit() {
    Vungle.init(SessionController.vungle_app_id);
  }

  void vungleInterstitialAdLoad() {
    Vungle.loadAd(SessionController.vungle_interstitial_id);
  }

  void vungleRewardLoad() {
    Vungle.loadAd(SessionController.vungle_reward_id);
  }

  void vungleBannerAdLoad() {
    Vungle.loadAd(SessionController.vungle_banner_id);
  }

  void vungleRewardedAd() async {
    if (await Vungle.isAdPlayable(SessionController.vungle_reward_id)) {
      Vungle.playAd(SessionController.vungle_reward_id);
    } else {
      print(' vungle_reward_id The ad is not ready to play');
    }
  }

  void vungleInterstitialAd() async {
    if (await Vungle.isAdPlayable(SessionController.vungle_interstitial_id)) {
      Vungle.playAd(SessionController.vungle_interstitial_id);
    } else {
      print('The ad is not ready to play');
    }
  }

  void vungleRewardAd() async {
    if (await Vungle.isAdPlayable(SessionController.vungle_reward_id)) {
      Vungle.playAd(SessionController.vungle_reward_id);
    } else {
      print('The ad is not ready to play');
    }
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
