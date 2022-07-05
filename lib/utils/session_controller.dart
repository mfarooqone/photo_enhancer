// ignore_for_file: non_constant_identifier_names

class SessionController {
  static final SessionController _session = SessionController._internel();
  String admob_banner_ad_ios = "ca-app-pub-3821043537076150/9947084076";
  String admob_banner_ad_android = "ca-app-pub-3940256099942544/6300978111";

  String admob_interstetial_ad_ios = "ca-app-pub-3821043537076150/6470873499";
  String admob_interstetial_ad_android =
      "ca-app-pub-3940256099942544/1033173712";

  String admob_rewarded_ad_ios = "ca-app-pub-3821043537076150/1985080993";
  String admob_rewarded_ad_android = "ca-app-pub-3940256099942544/5224354917";
  String open_ad_id = "";

  /* -------------------------------------------------------------------------- */
  /*                                 banner ads                                 */
  /* -------------------------------------------------------------------------- */

  bool admob_banner_save_screen_ios = false;
  bool admob_banner_save_screen_android = false;

  bool admob_banner_filter_screen_ios = false;
  bool admob_banner_filter_screen_android = false;

  /* -------------------------------------------------------------------------- */
  /*                              interstetial ads                              */
  /* -------------------------------------------------------------------------- */

  bool admob_interstetial_home_screen_ios = false;
  bool admob_interstetial_home_screen_android = false;

  bool admob_interstetial_save_screen_ios = false;
  bool admob_interstetial_save_screen_android = false;

  bool admob_interstetial_select_screen_ios = false;
  bool admob_interstetial_select_screen_android = false;

  /* -------------------------------------------------------------------------- */
  /*                                ad mob reward                               */
  /* -------------------------------------------------------------------------- */

  bool admob_reward_ios = false;
  bool admob_reward_android = false;

  /* -------------------------------------------------------------------------- */
  /*                          applovin interstetial ads                         */
  /* -------------------------------------------------------------------------- */

  bool applovin_interstetial_home_screen_ios = false;
  bool applovin_interstetial_home_screen_android = false;

  bool applovin_interstetial_save_screen_ios = false;
  bool applovin_interstetial_save_screen_android = false;

  bool applovin_interstetial_select_screen_ios = false;
  bool applovin_interstetial_select_screen_android = false;

  /* -------------------------------------------------------------------------- */
  /*                               applovin reward                              */
  /* -------------------------------------------------------------------------- */

  bool applovin_reward_ios = false;
  bool applovin_reward_android = false;

  factory SessionController() {
    return _session;
  }
  SessionController._internel();
}
