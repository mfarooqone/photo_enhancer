import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_enhancer/widgets/no_internet_controller.dart';
import 'package:image_enhancer/purchase/purchase_api_controller.dart';
import 'ads_controller/ads_controller.dart';

BindingsBuilder createBindings(BuildContext context) {
  return BindingsBuilder(() {
    Get.put(AdsController(), permanent: true);
    Get.put(InternetConnectionController(), permanent: true);
    Get.put(PurchaseApiController(), permanent: true);
  });
}
