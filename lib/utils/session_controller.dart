class SessionController {
  static final SessionController _session = SessionController._internel();

  static String admob_banner_ad_id = "ca-app-pub-3940256099942544/6300978111";
  static String admob_interstetial_ad_id =
      "ca-app-pub-3940256099942544/1033173712";
  static String admob_rewarded_ad_id = "ca-app-pub-3940256099942544/5224354917";
  static String open_ad_id = "ca-app-pub-3940256099942544/3419835294";
  static bool admob_banner_save_screen = true;
  static bool admob_banner_filter_screen = true;
  static bool admob_interstetial_splash_screen = true;
  static bool admob_interstetial_privacy_screen = true;
  static bool admob_interstetial_home_screen = true;
  static bool admob_interstetial_save_screen = true;
  static bool admob_interstetial_select_screen = true;
  static bool admob_reward = true;
  /* -------------------------------------------------------------------------- */
  /*                          applovin interstetial ads                         */
  /* -------------------------------------------------------------------------- */

  // static bool applovin_interstetial = true;

  /* -------------------------------------------------------------------------- */
  /*                               applovin reward                              */
  /* -------------------------------------------------------------------------- */

  // static bool applovin_reward = true;

  factory SessionController() {
    return _session;
  }
  SessionController._internel();
}
