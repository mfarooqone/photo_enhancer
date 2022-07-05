import 'dart:io';

import '../utils/session_controller.dart';

class LoadAdsHelper {
  /* -------------------------------------------------------------------------- */
  /*                                saveScreenAd                                */
  /* -------------------------------------------------------------------------- */
  static bool get admobSaveScreenBannerAd {
    if (Platform.isAndroid) {
      return SessionController().admob_banner_save_screen_android;
    } else if (Platform.isIOS) {
      return SessionController().admob_banner_save_screen_ios;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
  /* -------------------------------------------------------------------------- */
  /*                            admobFilterScreenBannerAd                            */
  /* -------------------------------------------------------------------------- */

  static bool get admobFilterScreenBannerAd {
    if (Platform.isAndroid) {
      return SessionController().admob_banner_filter_screen_android;
    } else if (Platform.isIOS) {
      return SessionController().admob_banner_filter_screen_ios;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

/* -------------------------------------------------------------------------- */
/*                            admob interstitial Ad                           */
/* -------------------------------------------------------------------------- */

  static bool get admobHomeScreeninterstitialAd {
    if (Platform.isAndroid) {
      return SessionController().admob_interstetial_home_screen_android;
    } else if (Platform.isIOS) {
      return SessionController().admob_interstetial_home_screen_ios;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static bool get admobSaveScreeninterstitialAd {
    if (Platform.isAndroid) {
      return SessionController().admob_interstetial_home_screen_android;
    } else if (Platform.isIOS) {
      return SessionController().admob_interstetial_home_screen_ios;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static bool get admobSelectScreeninterstitialAd {
    if (Platform.isAndroid) {
      return SessionController().admob_interstetial_home_screen_android;
    } else if (Platform.isIOS) {
      return SessionController().admob_interstetial_home_screen_ios;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                              admob reward ads                              */
  /* -------------------------------------------------------------------------- */

  static bool get admobRewardAd {
    if (Platform.isAndroid) {
      return SessionController().admob_reward_android;
    } else if (Platform.isIOS) {
      return SessionController().admob_reward_ios;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

/* -------------------------------------------------------------------------- */
/*                           applovin nterstitial Ad                          */
/* -------------------------------------------------------------------------- */

  static bool get applovinHomeScreeninterstitialAd {
    if (Platform.isAndroid) {
      return SessionController().applovin_interstetial_home_screen_android;
    } else if (Platform.isIOS) {
      return SessionController().applovin_interstetial_home_screen_ios;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static bool get applovinSaveScreeninterstitialAd {
    if (Platform.isAndroid) {
      return SessionController().applovin_interstetial_home_screen_android;
    } else if (Platform.isIOS) {
      return SessionController().applovin_interstetial_home_screen_ios;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static bool get applovinSelectScreeninterstitialAd {
    if (Platform.isAndroid) {
      return SessionController().applovin_interstetial_home_screen_android;
    } else if (Platform.isIOS) {
      return SessionController().applovin_interstetial_home_screen_ios;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                             applovin reward ad                             */
  /* -------------------------------------------------------------------------- */

  static bool get applovinRewardAd {
    if (Platform.isAndroid) {
      return SessionController().admob_reward_android;
    } else if (Platform.isIOS) {
      return SessionController().admob_reward_ios;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
