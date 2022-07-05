// ignore_for_file: non_constant_identifier_names

class SessionController {
  static final SessionController _session = SessionController._internel();
  String admob_banner_ad_ios = "ca-app-pub-3821043537076150/9947084076";
  String admob_banner_ad_android = "ca-app-pub-6627817022425407/3658923613";

  String admob_interstetial_ad_ios = "ca-app-pub-3821043537076150/6470873499";
  String admob_interstetial_ad_android =
      "ca-app-pub-6627817022425407/6504578800";

  String admob_rewarded_ad_ios = "ca-app-pub-3821043537076150/1985080993";
  String admob_rewarded_ad_android = "ca-app-pub-6627817022425407/9266473515";
  String open_ad_id = "";

  /* -------------------------------------------------------------------------- */
  /*                                 banner ads                                 */
  /* -------------------------------------------------------------------------- */

  bool admob_banner_save_screen_ios = true;
  bool admob_banner_save_screen_android = true;

  bool admob_banner_filter_screen_ios = true;
  bool admob_banner_filter_screen_android = true;

  /* -------------------------------------------------------------------------- */
  /*                              interstetial ads                              */
  /* -------------------------------------------------------------------------- */

  bool admob_interstetial_home_screen_ios = true;
  bool admob_interstetial_home_screen_android = true;

  bool admob_interstetial_save_screen_ios = true;
  bool admob_interstetial_save_screen_android = true;

  bool admob_interstetial_select_screen_ios = true;
  bool admob_interstetial_select_screen_android = true;

  /* -------------------------------------------------------------------------- */
  /*                                ad mob reward                               */
  /* -------------------------------------------------------------------------- */

  bool admob_reward_ios = true;
  bool admob_reward_android = true;

  /* -------------------------------------------------------------------------- */
  /*                          applovin interstetial ads                         */
  /* -------------------------------------------------------------------------- */

  bool applovin_interstetial_home_screen_ios = true;
  bool applovin_interstetial_home_screen_android = true;

  bool applovin_interstetial_save_screen_ios = true;
  bool applovin_interstetial_save_screen_android = true;

  bool applovin_interstetial_select_screen_ios = true;
  bool applovin_interstetial_select_screen_android = true;

  /* -------------------------------------------------------------------------- */
  /*                               applovin reward                              */
  /* -------------------------------------------------------------------------- */

  bool applovin_reward_ios = true;
  bool applovin_reward_android = true;

  factory SessionController() {
    return _session;
  }
  SessionController._internel();
}
