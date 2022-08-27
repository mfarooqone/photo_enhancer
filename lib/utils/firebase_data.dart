import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_enhancer/utils/session_controller.dart';

class FirebaseData {
  final firestoreInstance = FirebaseFirestore.instance;

  Future<void> getFirebaseData() async {
    /* -------------------------------------------------------------------------- */
    /*                           admob collection                          */
    /* -------------------------------------------------------------------------- */
    try {
      await firestoreInstance.collection("admob").get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          /* -------------------------------------------------------------------------- */
          /*                                   ads ids                                  */
          /* -------------------------------------------------------------------------- */

          SessionController.admob_banner_ad_id =
              result.data()["admob_banner_ad_id"];

          SessionController.admob_interstetial_ad_id =
              result.data()["admob_interstetial_ad_id"];

          SessionController.admob_rewarded_ad_id =
              result.data()["admob_rewarded_ad_id"];

          SessionController.open_ad_id = result.data()["open_ad_id"];

          /* -------------------------------------------------------------------------- */
          /*                               stop admob ads                               */
          /* -------------------------------------------------------------------------- */

          /* -------------------------------------------------------------------------- */
          /*                                 banner ads                                 */
          /* -------------------------------------------------------------------------- */

          SessionController.admob_banner_save_screen =
              result.data()["admob_banner_save_screen"];

          SessionController.admob_banner_filter_screen =
              result.data()["admob_banner_filter_screen"];

          SessionController.admob_interstetial_splash_screen =
              result.data()["admob_interstetial_splash_screen"];

          SessionController.admob_interstetial_privacy_screen =
              result.data()["admob_interstetial_privacy_screen"];

          SessionController.admob_interstetial_save_screen =
              result.data()["admob_interstetial_save_screen"];

          SessionController.admob_interstetial_home_screen =
              result.data()["admob_interstetial_home_screen"];

          SessionController.admob_interstetial_select_screen =
              result.data()["admob_interstetial_select_screen"];

          SessionController.admob_reward = result.data()["admob_reward"];

          // log("***********************************");
          // log(result.data().toString());
          // log("***********************************");
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
