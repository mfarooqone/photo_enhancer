import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../ads_controller/ads_controller.dart';

class BannerAdWidget extends StatelessWidget {
  BannerAdWidget(
      {Key? key,
      required this.sessionBool,
      required this.adName,
      this.isPurchased = false})
      : super(key: key);
  final ads = Get.find<AdsController>();
  final bool sessionBool;
  final BannerAd adName;
  final bool? isPurchased;

  @override
  Widget build(BuildContext context) {
    return isPurchased!
        ? const SizedBox()
        : Column(
            children: [
              const SizedBox(
                height: 3,
              ),
              if (ads.isBannerAdReady.value)
                SizedBox(
                  height: 60.0,
                  width: double.infinity,
                  child: AdWidget(ad: adName),
                ),
              const SizedBox(
                height: 3,
              ),
            ],
          );
  }
}
