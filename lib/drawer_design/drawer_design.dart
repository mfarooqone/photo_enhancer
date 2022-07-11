import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_enhancer/utils/app_colors.dart';
import 'package:image_enhancer/utils/app_textstyle.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

import '../purchase/purchase_api_controller.dart';
import '../purchase/subscriptions_page.dart';

class DrawerDesign extends StatefulWidget {
  const DrawerDesign({Key? key}) : super(key: key);

  @override
  State<DrawerDesign> createState() => _DrawerDesignState();
}

class _DrawerDesignState extends State<DrawerDesign> {
  void _launchUrl(url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

  var purchaseApiController = Get.find<PurchaseApiController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: 307,
          height: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  onTap: () async {
                    Get.to(() => const SubscriptionsPage());
                  },
                  leading: Icon(
                    Icons.workspace_premium_rounded,
                    size: 20,
                    color: AppColors.blackColor,
                  ),
                  title: Text(
                    "Go Premium",
                    style: AppTextStyle.black16,
                  ),
                ),

                /* -------------------------------------------------------------------------- */
                /*                              restore purchase                              */
                /* -------------------------------------------------------------------------- */
                const Divider(),
                ListTile(
                  onTap: () async {
                    try {
                      // PurchaserInfo restoredInfo =
                      await Purchases.restoreTransactions();
                      await purchaseApiController.init();
                      Get.back();
                    } catch (e) {
                      Get.snackbar("              Something went wrong", "");
                    }
                  },
                  leading: Icon(
                    Icons.restore_outlined,
                    size: 20,
                    color: AppColors.blackColor,
                  ),
                  title: Text(
                    "Restore Purchase",
                    style: AppTextStyle.black16,
                  ),
                ),
                Divider(),
                /* -------------------------------------------------------------------------- */
                /*                                   Rate us                                  */
                /* -------------------------------------------------------------------------- */
                if (Platform.isAndroid)
                  ListTile(
                    onTap: () {
                      StoreRedirect.redirect(
                        androidAppId:
                            "com.hdphoto.photoshoot.enhance.image.hdr.ai",
                        // iOSAppId: "585027354",
                      );
                    },
                    leading: Icon(
                      Icons.star,
                      size: 20,
                      color: AppColors.blackColor,
                    ),
                    title: Text(
                      "Rate us",
                      style: AppTextStyle.black16,
                    ),
                  ),
                /* -------------------------------------------------------------------------- */
                /*                                    Share                                   */
                /* -------------------------------------------------------------------------- */
                const Divider(),
                ListTile(
                  onTap: () {
                    Share.share(
                        'https://play.google.com/store/apps/details?id=com.hdphoto.photoshoot.enhance.image.hdr.ai',
                        subject: 'check out this app');
                  },
                  leading: Icon(
                    Icons.share,
                    size: 20,
                    color: AppColors.blackColor,
                  ),
                  title: Text(
                    "Share",
                    style: AppTextStyle.black16,
                  ),
                ),
                /* -------------------------------------------------------------------------- */
                /*                               Privacy Policy                               */
                /* -------------------------------------------------------------------------- */
                const Divider(),
                ListTile(
                  onTap: () {
                    Uri url = Uri.parse(
                        "https://docs.google.com/document/d/1VSoU4LNtnxS9V_4YeephTCsmnIEi7HrUbqZJ6YUg-vw/edit");

                    _launchUrl(url);
                  },
                  leading: Icon(
                    Icons.privacy_tip_outlined,
                    size: 20,
                    color: AppColors.blackColor,
                  ),
                  title: Text(
                    "Privacy Policy",
                    style: AppTextStyle.black16,
                  ),
                ),
                /* -------------------------------------------------------------------------- */
                /*                            terms and conditions                            */
                /* -------------------------------------------------------------------------- */
                const Divider(),
                ListTile(
                  onTap: () {
                    Uri url = Uri.parse(
                        "https://docs.google.com/document/d/1SvleJc1JzBNrj_Ji28DmEYOybbX2VN6if0Z-Y_McIZ8/edit");

                    _launchUrl(url);
                  },
                  leading: Icon(
                    Icons.privacy_tip_outlined,
                    size: 20,
                    color: AppColors.blackColor,
                  ),
                  title: Text(
                    "Terms & Conditions",
                    style: AppTextStyle.black16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
