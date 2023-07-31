class SessionController {
  static final SessionController _session = SessionController._internel();

  static String admob_banner_ad_id = "";
  static String admob_interstetial_ad_id = "";
  static String admob_rewarded_ad_id = "";
  static String open_ad_id = "";
  static bool admob_banner_save_screen = false;
  static bool admob_banner_filter_screen = false;
  static bool admob_banner_privacy_screen = false;
  static bool admob_interstetial_splash_screen = false;
  static bool admob_interstetial_privacy_screen = false;
  static bool admob_interstetial_home_screen = false;
  static bool admob_interstetial_save_screen = false;
  static bool admob_interstetial_select_screen = false;
  static bool admob_reward = false;

  /* -------------------------------------------------------------------------- */
  /*                                 vungle ads                                 */
  /* -------------------------------------------------------------------------- */
  static String vungle_app_id = "64c136d3beec0a16719b8cc3";
  static String vungle_interstitial_id = "";
  static String vungle_reward_id = "";
  static String vungle_banner_id = "";

  ///
  static bool vungle_reward = false;
  static bool vungle_interstitial = false;
  static bool vungle_banner = false;

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
