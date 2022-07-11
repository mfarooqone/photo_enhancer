// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../utils/app_images.dart';
// import 'purchase_api_controller.dart';

// class SubscriptionsPage extends StatefulWidget {
//   const SubscriptionsPage({Key? key}) : super(key: key);

//   @override
//   State<SubscriptionsPage> createState() => _SubscriptionsPageState();
// }

// class _SubscriptionsPageState extends State<SubscriptionsPage> {
//   final PurchaseApiController purchaseApiController =
//       Get.put(PurchaseApiController());

//   @override
//   void initState() {
//     purchaseApiController.init();
//     super.initState();
//   }

//   Future<bool> _onWillPop() async {
//     return (await purchaseApiController.init()) ?? false;
//   }

//   void _launchUrl(url) async {
//     if (!await launchUrl(url)) throw 'Could not launch $url';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () {
//         return WillPopScope(
//           onWillPop: _onWillPop,
//           child: Scaffold(
//             body: SafeArea(
//               child: SizedBox(
//                 width: double.infinity,
//                 height: double.infinity,
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           InkWell(
//                             onTap: () async {
//                               await purchaseApiController.init();
//                               Get.back();
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.grey[300],
//                                   shape: BoxShape.circle),
//                               child: const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Icon(
//                                   Icons.close,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const Spacer(),
//                           TextButton(
//                             onPressed: () async {
//                               try {
//                                 // PurchaserInfo restoredInfo =
//                                 await Purchases.restoreTransactions();
//                                 await purchaseApiController.init();
//                                 Get.back();
//                               } catch (e) {
//                                 Get.snackbar(
//                                     "              Something went wrong", "");
//                               }
//                             },
//                             child: const Text(
//                               "Restore",
//                               style: TextStyle(
//                                 color: Colors.black,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                       Image.asset(
//                         AppImagesPath.inAppPurchase,
//                         width: 320,
//                         height: 339,
//                         fit: BoxFit.fill,
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       purchaseApiController.isLoading.value
//                           ? const Center(
//                               child: Padding(
//                                 padding: EdgeInsets.only(top: 50),
//                                 child:
//                                     SpinKitSpinningLines(color: Colors.black),
//                               ),
//                             )
//                           : ListView.builder(
//                               shrinkWrap: true,
//                               padding: EdgeInsets.zero,
//                               itemCount: purchaseApiController.packages.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 0, vertical: 2),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         border: Border.all(
//                                           color: Colors.black,
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     child: ListTile(
//                                         contentPadding:
//                                             const EdgeInsets.symmetric(
//                                                 horizontal: 8, vertical: 1),
//                                         title: Text(
//                                           purchaseApiController
//                                               .packages[index].product.title,
//                                           style: const TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         subtitle: Text(
//                                           purchaseApiController.packages[index]
//                                               .product.description,
//                                           style: const TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                         trailing: Text(
//                                           purchaseApiController.packages[index]
//                                               .product.priceString,
//                                           style: const TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         onTap: () async {
//                                           purchaseApiController
//                                               .isLoading.value = true;

//                                           await PurchaseApiController
//                                               .purchasePackage(
//                                             purchaseApiController
//                                                 .packages[index],
//                                           );
//                                           await purchaseApiController.init();
//                                           Get.back();
//                                           purchaseApiController
//                                               .isLoading.value = false;
//                                         }),
//                                   ),
//                                 );
//                               },
//                             ),

//                       /* -------------------------------------------------------------------------- */
//                       /*                                terms of use                                */
//                       /* -------------------------------------------------------------------------- */

//                       const Spacer(),
//                       const Text(
//                         "An auto-renewable subscription will be activated at the end of the selected period.",
//                         style: TextStyle(color: Colors.black38),
//                         textAlign: TextAlign.center,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             "Our ",
//                             style: TextStyle(color: Colors.black38),
//                             textAlign: TextAlign.center,
//                           ),
//                           InkWell(
//                             onTap: () {
//                               Uri url = Uri.parse(
//                                   "https://docs.google.com/document/d/1SvleJc1JzBNrj_Ji28DmEYOybbX2VN6if0Z-Y_McIZ8/edit");
//                               _launchUrl(url);
//                             },
//                             child: const Text(
//                               " Terms Of Services",
//                               style: TextStyle(color: Colors.black),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                           const Text(
//                             " applies to all purchases",
//                             style: TextStyle(color: Colors.black38),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
