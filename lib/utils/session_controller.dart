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
  /*                          applovin interstetial ads                         */
  /* -------------------------------------------------------------------------- */

  // static bool applovin_interstetial = false;

  /* -------------------------------------------------------------------------- */
  /*                               applovin reward                              */
  /* -------------------------------------------------------------------------- */

  // static bool applovin_reward = false;

  factory SessionController() {
    return _session;
  }
  SessionController._internel();
}
