import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../utils/session_controller.dart';

class BannerAdWidget extends StatefulWidget {
  final bool helperValue;
  const BannerAdWidget({Key? key, required this.helperValue}) : super(key: key);
  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? bannerAd;

  bool bannerReady = false;

  @override
  void initState() {
    setState(() {
      bannerReady = false;
    });

    if (widget.helperValue)
      bannerAd = BannerAd(
        adUnitId: SessionController.admob_banner_ad_id,
        request: const AdRequest(),
        size: AdSize.fullBanner,
        listener: BannerAdListener(
          onAdLoaded: (_) {
            setState(() {
              bannerReady = true;
            });
          },
          onAdFailedToLoad: (ad, err) {
            setState(() {
              bannerReady = false;
            });
            ad.dispose();
          },
        ),
      );
    if (widget.helperValue) bannerAd!.load();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.helperValue) bannerAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bannerReady ? bannerWidget() : loadingWidget(context);
  }

  Widget loadingWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          height: 60.0,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              "Loading Ad...",
            ),
          ),
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }

  Column bannerWidget() {
    return Column(
      children: [
        SizedBox(
          height: 60,
          width: double.infinity,
          child: AdWidget(ad: bannerAd!),
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}
