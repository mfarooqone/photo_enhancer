import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApiController extends GetxController {
  RxBool isLoading = false.obs;
  List<Package> packages = [];
  RxBool isPurchased = false.obs;

  @override
  void onInit() async {
    init();
    super.onInit();
  }

  Future init() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(
      Platform.isIOS
          ? "appl_dADHxaWFtqlaYZJabvUssljEIoP"
          : "goog_ZKMFZjoDMPjDQlLUGxyQSCzOZhJ",
    );
    Purchases.addPurchaserInfoUpdateListener((purchaserInfo) async {
      updatePurchaseStatus();
    });
    await fetchOffersNew();
  }

  // static Future<List<Offering>> fetchOffersByIds(List<String> ids) async {
  //   final offers = await fetchOffers();

  //   return offers.where((offer) => ids.contains(offer.identifier)).toList();
  // }

  static Future<List<Offering>> fetchOffers({bool all = true}) async {
    try {
      final offerings = await Purchases.getOfferings();
      if (!all) {
        final current = offerings.current;
        return current == null ? [] : [current];
      } else {
        return offerings.all.values.toList();
      }
    } on PlatformException {
      return [];
    }
  }

  static Future<bool> purchasePackage(Package package) async {
    try {
      await Purchases.purchasePackage(package);
      return true;
    } catch (e) {
      return false;
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                            revenuecat controller                           */
  /* -------------------------------------------------------------------------- */

  Future updatePurchaseStatus() async {
    final purchaserInfo = await Purchases.getPurchaserInfo();
    final entitlements = purchaserInfo.entitlements.active.values.toList();
    if (entitlements.isEmpty) {
      isPurchased.value = false;
    } else {
      isPurchased.value = true;
      // Get.offAll(() => SplashScreen());
    }
    log("purchaserInfo ============ $purchaserInfo");
    log("isPurchased ============ $isPurchased");

    update();
  }

  Future fetchOffersNew() async {
    isLoading.value = true;
    final offerings = await PurchaseApiController.fetchOffers(all: true);
    isLoading.value = false;
    if (offerings.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('No Plans Found'),
        ),
      );
    } else {
      packages = offerings
          .map((offer) => offer.availablePackages)
          .expand((pair) => pair)
          .toList();
    }
    update();
  }
}
