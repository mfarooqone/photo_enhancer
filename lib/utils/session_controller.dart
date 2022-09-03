class SessionController {
  static final SessionController _session = SessionController._internel();

  static String admob_banner_ad_id = "";
  static String admob_interstetial_ad_id = "";
  static String admob_rewarded_ad_id = "";
  static String open_ad_id = "";
  static bool admob_banner_save_screen = false;
  static bool admob_banner_filter_screen = false;
  static bool admob_interstetial_splash_screen = false;
  static bool admob_interstetial_privacy_screen = false;
  static bool admob_interstetial_home_screen = false;
  static bool admob_interstetial_save_screen = false;
  static bool admob_interstetial_select_screen = false;
  static bool admob_reward = false;
  /* -------------------------------------------------------------------------- */
  /*                          applovin  ads                                      */
  /* -------------------------------------------------------------------------- */

  static String applovin_sdk_key =
      "45kT4VQU0UG7_N0y2rQ4Afnrbd-xTh-F27IktAuD0E4nt7oBTCRLOyzDIbt8bMFlwk3wQXWiT092k2wwsZNTxW";
  static String applovin_banner_ad_id = "8e37149c086fd15f";
  static String applovin_interstetial_ad_id = "66077cfa48467aca";
  static String applovin_rewarded_ad_id = "5f301c02d7e213a0";
  static String applovin_open_ad_id = "";
  static String applovin_native_ad_id = "2e9df280265f50aa";
  static bool applovin_banner_save_screen = false;
  static bool applovin_banner_filter_screen = false;
  static bool applovin_interstetial_splash_screen = false;
  static bool applovin_interstetial_privacy_screen = false;
  static bool applovin_interstetial_home_screen = false;
  static bool applovin_interstetial_save_screen = false;
  static bool applovin_interstetial_select_screen = false;
  static bool applovin_reward = false;
  static bool applovin_native_ad = false;

  /* -------------------------------------------------------------------------- */
  /*                                  facebook                                  */
  /* -------------------------------------------------------------------------- */

  static String fb_banner_ad_id = "8e37149c086fd15f";
  static String fb_interstetial_ad_id = "66077cfa48467aca";
  static String fb_rewarded_ad_id = "5f301c02d7e213a0";
  static String fb_native_ad_id = "2e9df280265f50aa";
  static bool fb_banner_save_screen = false;
  static bool fb_banner_filter_screen = false;
  static bool fb_interstetial_splash_screen = false;
  static bool fb_interstetial_privacy_screen = false;
  static bool fb_interstetial_home_screen = false;
  static bool fb_interstetial_save_screen = false;
  static bool fb_interstetial_select_screen = false;
  static bool fb_reward = false;
  static bool fb_native_ad = false;

  factory SessionController() {
    return _session;
  }
  SessionController._internel();
}
