import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pristine_seeds/models/notification/notification_get_model.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';

import '../../repository/notification_repository/notification_repository.dart';
import '../../utils/app_utils.dart';

class NotificationVM extends GetxController{
  final _api = NotificationRepository();
  RxBool loading = false.obs;
  SessionManagement sessionManagement= SessionManagement();
  String email_id = "";
  RxList<NotificationModel> notification_list=<NotificationModel>[].obs;
  RxList<NotificationModel> notification_acknowledge_list=<NotificationModel>[].obs;
  var selectedIndex = RxInt(0);
  RxInt acknowledgement_id=0.obs;
  RxString flag="".obs;
  RxInt totalUnacknowledgedCount = 0.obs;


  @override
  void onInit() async {
    email_id = await sessionManagement.getEmail() ?? '';
    getNotificationList("get","");
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  getNotificationList(String flag,String id) {
    this.loading.value = true;
    Map<String, String> data ={
      "flag": flag,
      "id": id,
      "email_id":email_id
    };
    _api.getNotificationList(data, sessionManagement).then((value) {

      print(value);
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<NotificationModel> response = jsonResponse.map((data) => NotificationModel.fromJson(data))
              .toList();
          if (response != null && response.length > 0 && response[0].condition == 'True') {
            loading.value = false;
            notification_list.value = response;
            totalUnacknowledgedCount.value=notification_list.where((item) => item.acknowledgement==0).length;
          } else {
            //Utils.sanckBarError('Message False!',response[0].message!);
            loading.value = false;
          }
        } else {
          notification_list.value=[];
          loading.value = false;
          Utils.sanckBarError('API Response Error!', jsonResponse.toString());
        }
      } catch (e) {
        Utils.sanckBarException('Exception!', e.toString());
        notification_list.value=[];
        loading.value = false;
        print(e);
      }
    }).onError((error, stackTrace) {
      notification_list.value=[];
      print(error);
      loading.value = false;
    });
  }
}