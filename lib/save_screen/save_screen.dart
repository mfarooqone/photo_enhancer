import 'dart:io';
import 'dart:typed_data';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as imagelib;
import 'package:image_enhancer/ads_controller/ads_controller.dart';
import 'package:image_enhancer/edit_screen/edit_screen.dart';
import 'package:image_enhancer/home_screen/home_screen.dart';
import 'package:image_enhancer/widgets/before_after/custom_widget.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:share_plus/share_plus.dart';

import '../ads_controller/banner_ad_widget.dart';
import '../ads_controller/load_ads_function.dart';
import '../photo_filter/photo_filter_screen.dart';
import '../text_editor/text_editor.dart';
import '../utils/app_colors.dart';
import '../utils/app_textstyle.dart';
import '../utils/session_controller.dart';
import '../widgets/gradient_container_design.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen(
      {Key? key,
      required this.buttonText,
      required this.userImage,
      required this.index,
      this.bytes,
      this.filteredImage})
      : super(key: key);
  final String buttonText;
  final File? userImage;
  final File? filteredImage;
  final int index;
  final List<int>? bytes;
  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  String? fileName;
  File? imageFile;
  var date = DateTime.now();
  AdsController ads = Get.find();
  bool isSaved = false;

  List<Widget> iconList = [
    GradientContainerDesign1(
      title: "Enhance",
      imagePath: "assets/enhance.png",
    ),
    GradientContainerDesign1(
      title: "Filter",
      imagePath: "assets/filter.png",
    ),
    GradientContainerDesign1(
      title: "Text",
      imagePath: "assets/text.png",
    ),
    GradientContainerDesign1(
      title: "HDR",
      imagePath: "assets/hdr.png",
    ),
  ];

  @override
  void initState() {
    saveFilteredImage();
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await Get.offAll(() => const HomeScreen())) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "${widget.buttonText} Photo",
            style: AppTextStyle.black16,
          ),
          leading: InkWell(
            onTap: () {
              Get.offAll(() => const HomeScreen());
            },
            child: Icon(
              Icons.close,
              color: AppColors.blackColor,
              size: 30,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () {
                  Share.shareFiles([(tempImagePath!.path)],
                      text: 'Great picture');
                },
                child: Icon(
                  Icons.share,
                  size: 25,
                  color: AppColors.blackColor,
                ),
              ),
            ),
          ],
        ),
        body: bodyWidget(context),
      ),
    );
  }

  Column bodyWidget(BuildContext context) {
    return Column(
      children: [
        BannerAdWidget(
          helperValue: SessionController.admob_banner_save_screen,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 23),
            child: Center(
              child: Container(
                  alignment: Alignment.topCenter,
                  child: showImageWidget(widget.index)),
            ),
          ),
        ),
        /* -------------------------------------------------------------------------- */
        /*                           GradientContainerDesign                          */
        /* -------------------------------------------------------------------------- */
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  isSaved
                      ? Opacity(
                          opacity: 0.5,
                          child: GradientContainerDesign(
                            height: 48,
                            width: 177,
                            title: "Save Image",
                            onPressed: () {},
                            showTrailingIcon: false,
                            showLeadingWidget: true,
                            leading: Icon(
                              Icons.save_alt,
                              size: 20,
                              color: AppColors.blackColor,
                            ),
                          ),
                        )
                      : GradientContainerDesign(
                          height: 48,
                          width: 177,
                          title: "Save Image",
                          onPressed: () {
                            setState(() {
                              isSaved = true;
                              _savetoGallery(context, widget.index);
                            });
                          },
                          showTrailingIcon: false,
                          showLeadingWidget: true,
                          leading: Icon(
                            Icons.save_alt,
                            size: 20,
                            color: AppColors.blackColor,
                          ),
                        ),
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              GradientContainerDesign(
                height: 48,
                width: 48,
                title: "",
                onPressed: () {
                  _showBottomSheet(context, widget.index);
                },
                showLeadingWidget: true,
                leading: Icon(
                  Icons.more_horiz_outlined,
                  color: AppColors.blackColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context, int index) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctz) {
        return Container(
          // color: Colors.white,
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          height: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              index == 0
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            radius: 20,
                            title: "To get it free?",
                            content: Column(
                              children: [
                                Text(
                                  "Watch a video Ad",
                                  style: AppTextStyle.black14,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GradientContainerDesign(
                                      height: 40,
                                      width: 120,
                                      title: "Cancel",
                                      onPressed: () {
                                        Get.back();
                                      },
                                      showTrailingIcon: false,
                                      showLeadingWidget: true,
                                    ),
                                    GradientContainerDesign(
                                      height: 40,
                                      width: 120,
                                      title: "Ok",
                                      onPressed: () async {
                                        LoadAdClass()
                                            .rewardAd(
                                                SessionController.admob_reward)
                                            .then((value) => Get.to(() =>
                                                EditScreen(
                                                    buttonText: "Enhance",
                                                    userImage: widget.userImage,
                                                    index: 0)));
                                      },
                                      showTrailingIcon: false,
                                      showLeadingWidget: false,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        child: iconList[0],
                      ),
                    ),
              index == 1
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: InkWell(
                        onTap: () async {
                          imageFile = File(widget.userImage!.path);
                          fileName = basename(imageFile!.path);
                          List<int> bytes = await imageFile!.readAsBytes();
                          var image = imagelib.decodeImage(bytes);
                          image = imagelib.copyResize(image!, width: 600);

                          LoadAdClass().interstetialAd(
                              SessionController.admob_interstetial_save_screen);

                          Get.to(
                            () => PhotoFilterSelector(
                              title: Text(
                                "Select Filter",
                                style: TextStyle(color: AppColors.blackColor),
                              ),
                              image: image!,
                              filters: presetFiltersList,
                              filename: fileName!,
                              loader: const SpinKitSpinningLines(
                                  color: Colors.black),
                              fit: BoxFit.contain,
                              userImage: widget.userImage!,
                            ),
                          );
                        },
                        child: iconList[1],
                      ),
                    ),
              index == 2
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: InkWell(
                        onTap: () {
                          LoadAdClass().interstetialAd(
                              SessionController.admob_interstetial_save_screen);

                          Get.to(() => TextEditorScreen(
                                buttonText: "Text Style",
                                userImage: widget.userImage,
                                index: 2,
                              ));
                        },
                        child: iconList[2],
                      ),
                    ),
              index == 3
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            radius: 20,
                            title: "To get it free?",
                            content: Column(
                              children: [
                                Text(
                                  "Watch a video Ad",
                                  style: AppTextStyle.black14,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GradientContainerDesign(
                                      height: 40,
                                      width: 120,
                                      title: "Cancel",
                                      onPressed: () {
                                        Get.back();
                                      },
                                      showTrailingIcon: false,
                                      showLeadingWidget: true,
                                    ),
                                    GradientContainerDesign(
                                      height: 40,
                                      width: 120,
                                      title: "Ok",
                                      onPressed: () async {
                                        LoadAdClass()
                                            .rewardAd(
                                                SessionController.admob_reward)
                                            .then(
                                              (value) => Get.to(() =>
                                                  EditScreen(
                                                      buttonText: "HDR",
                                                      userImage:
                                                          widget.userImage,
                                                      index: 3)),
                                            );
                                      },
                                      showTrailingIcon: false,
                                      showLeadingWidget: false,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        child: iconList[3],
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget showImageWidget(int index) {
    return index == 0
        ? BeforeAfter(
            beforeImage: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.file(
                  widget.userImage!,
                  fit: BoxFit.contain,
                ).blurred(
                  colorOpacity: 0.1,
                  blur: 0.1,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: beforeAfterWidget("Before"),
                ),
              ],
            ),
            afterImage: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.memory(
                  Uint8List.fromList(widget.bytes!),
                  fit: BoxFit.contain,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: beforeAfterWidget("After"),
                ),
              ],
            ),
          )
        : index == 1
            ? BeforeAfter(
                beforeImage: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.file(
                      widget.userImage!,
                      fit: BoxFit.contain,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: beforeAfterWidget("Before"),
                    ),
                  ],
                ),
                afterImage: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.file(
                      widget.filteredImage!,
                      fit: BoxFit.contain,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: beforeAfterWidget("After"),
                    ),
                  ],
                ),
              )
            : index == 2
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.memory(
                      Uint8List.fromList(widget.bytes!),
                      fit: BoxFit.contain,
                    ),
                  )
                : index == 3
                    ? BeforeAfter(
                        beforeImage: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Image.file(
                              widget.userImage!,
                              fit: BoxFit.contain,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: beforeAfterWidget("Before"),
                            ),
                          ],
                        ),
                        afterImage: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Image.memory(
                              Uint8List.fromList(widget.bytes!),
                              fit: BoxFit.contain,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: beforeAfterWidget("After"),
                            ),
                          ],
                        ),
                      )
                    : const Text("No Implementation found");
  }

  Padding beforeAfterWidget(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

//
//
//

  File? tempImagePath;
  Future<File> get _localFile async {
    final path = await _localPath;
    tempImagePath = File('$path/filtered_' '${date.millisecond}' '.jpg');
    return tempImagePath!;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> saveFilteredImage() async {
    var imageFile = await _localFile;
    await imageFile.writeAsBytes(widget.bytes!);

    return imageFile;
  }

  void _savetoGallery(BuildContext context, int index) async {
    if (tempImagePath != null) {
      GallerySaver.saveImage(tempImagePath!.path);
      Get.snackbar(
        "                       Image saved successfully",
        "",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.defaultDialog(title: "Alert!", middleText: "Some Error Occurred");
    }
  }
}

class GradientContainerDesign1 extends StatelessWidget {
  const GradientContainerDesign1({
    Key? key,
    required this.title,
    required this.imagePath,
  }) : super(key: key);
  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 84,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.pinkColor,
            AppColors.redColor,
            AppColors.orangeColor,
            AppColors.blueColor,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
          padding: const EdgeInsets.all(2.5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: 30,
                  height: 30,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(title)
              ],
            ),
          )),
    );
  }
}
