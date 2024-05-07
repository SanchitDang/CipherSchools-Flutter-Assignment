import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingUtils {
  static var isLoaderShowing = false;

  static void showLoader() {
    if (!isLoaderShowing) {
      Get.dialog(
        WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              color: Colors.black,
              size: 50,
            ),
          ),
        ),
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.7),
      );
      isLoaderShowing = true;
    }
  }

  static void hideLoader() {
    if (isLoaderShowing) {
      Get.back();
      isLoaderShowing = false;
    }
  }
}
