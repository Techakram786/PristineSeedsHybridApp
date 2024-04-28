import 'dart:async';
import 'package:get/get.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';
class SplashServices{
  SessionManagement sessionManagement=SessionManagement();
  void isLogin() {
    sessionManagement.getEmail().then((value) {
      if (value != null && value.isNotEmpty) {
        sessionManagement.getMenuList().then((menuList) {
          Timer(const Duration(seconds: 1), () => Get.offAllNamed(RoutesName.homeScreen));
        });
      } else {
        Timer(const Duration(seconds: 1), () => Get.toNamed(RoutesName.loginScreen));
      }
    }).onError((error, stackTrace) {
      print(error);
    } );
  }
}