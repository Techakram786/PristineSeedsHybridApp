import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pristine_seeds/constants/app_colors.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  /* static toastMessage(String message){
    Fluttertoast.showToast(msg: message,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER);
  }

  static toastMessageCenter(String message){
    Fluttertoast.showToast(msg: message,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        textColor: AllColors.primaryColor);
  }*/

  static sanckBarSuccess(String title, String message) {
    try {
      Get.snackbar(
        title,
        message,
        colorText: AllColors.whiteColor,
        backgroundColor: AllColors.primaryDark1,
        barBlur: 2.0,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
     // print(e);
    }
  }

  static sanckBarError(String title, String message) {
    try {
      Get.snackbar(
        title,
        message,
        colorText: AllColors.whiteColor,
        backgroundColor: AllColors.redColor,
        barBlur: 2.0,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      //print(e);
    }
  }

  static sanckBarException(String title, String message) {
    try {
      Get.snackbar(
        title,
        message,
        colorText: AllColors.whiteColor,
        backgroundColor: AllColors.lightredColor,
        barBlur: 2.0,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
     // print(e);
    }
  }
}
