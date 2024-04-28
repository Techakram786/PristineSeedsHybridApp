import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pristine_seeds/models/forgotpass/ForgotPassResponse.dart';
import 'package:pristine_seeds/repository/create_pass_repo/create_pass_repo.dart';
import 'package:pristine_seeds/repository/forgot_password_repo/forgot_pass.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';

import '../../models/createpass/create_pass_resp.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';

class CreatePasswordViewModel extends GetxController{
  final _api=CreatePassRepository();
  SessionManagement sessionManagement=SessionManagement();
  final emailController =TextEditingController().obs;
  final otpController =TextEditingController().obs;
  final newPassController =TextEditingController().obs;

  RxBool isPasswordVisible = false.obs;

  RxBool loading=false.obs;
  forgotPasswordApi(){
    loading.value=true;
    Map data={
      'email_id':Get.arguments.toString(),
      'otp_password':otpController.value.text,
      'new_user_password':newPassController.value.text,
    };
    _api.createPassApiHit(data,sessionManagement).then((value){
      try{
        loading.value=false;
        List<PasswordResponse> passResponse=(json.decode(value) as List).map((i) =>
            PasswordResponse.fromJson(i)).toList();

        if (passResponse[0].condition.toString() == "True") {
          Utils.sanckBarSuccess('Thanks!', passResponse[0].message.toString());
          otpController.value.text="";
          newPassController.value.text="";
          Get.toNamed(RoutesName.loginScreen);
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