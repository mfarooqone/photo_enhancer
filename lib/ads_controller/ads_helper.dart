import 'dart:io';

import '../utils/session_controller.dart';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return SessionController().admob_banner_ad_android;
    } else if (Platform.isIOS) {
      return SessionController().admob_banner_ad_android;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return SessionController().admob_interstetial_ad_android;
    } else if (Platform.isIOS) {
      return SessionController().admob_interstetial_ad_android;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return SessionController().admob_rewarded_ad_android;
    } else if (Platform.isIOS) {
      return SessionController().admob_rewarded_ad_android;
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
