import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pristine_seeds/models/forgotpass/ForgotPassResponse.dart';
import 'package:pristine_seeds/repository/forgot_password_repo/forgot_pass.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';

import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';

class ForgotPasswordViewModel extends GetxController{
  final _api=ForgotPasswordRepository();
  SessionManagement sessionManagement=SessionManagement();
  final emailController =TextEditingController().obs;
  RxBool loading=false.obs;
  forgotPasswordApi(){
    loading.value=true;
    Map data={
      'email_id':emailController.value.text,
    };
    _api.forgotPassApiHit(data,sessionManagement).then((value){
      try{
        loading.value=false;
        List<ForgotPassResponse> passResponse=(json.decode(value) as List).map((i) =>
            ForgotPassResponse.fromJson(i)).toList();

        if (passResponse[0].condition.toString() == "True") {
            Utils.sanckBarSuccess('OTP', passResponse[0].message.toString());
            Get.toNamed(RoutesName.createPasswordScreen,arguments:passResponse[0].mailSendOnEmail.toString());
          }
         else {
          Utils.sanckBarError('Message', passResponse[0].message.toString());
        }
      }catch(e){
        Utils.sanckBarException('Exception', e.toString());
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      //print(stackTrace);
      Utils.sanckBarError('Api Exception onError', error.toString());
    });
  }
}