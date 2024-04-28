

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pristine_seeds/repository/shipped_order_repository/shipped_order_repository.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';

import '../../models/orders/order_header_get_model.dart';
import '../../models/shipped_oeder_header/shipped_order_header_modal.dart';
import '../../utils/app_utils.dart';

class ShippedOrderVm extends GetxController {
  SessionManagement sessionManagement=SessionManagement();
  final _api=ShippedOrderRepository();

  String email_id = "";
  RxBool loading=false.obs;
  int rowsPerPage=10;
  int pageNumber=0;
  RxString orderNo="".obs;
  RxBool isdropdown=true.obs;


  RxList<OrderHeaderGetModel> orderShippedData=<OrderHeaderGetModel>[].obs;
  RxList<ShippedOrderHeaderModal> headerDataList=<ShippedOrderHeaderModal>[].obs;

  @override
  void onInit() async{
   email_id= await sessionManagement.getEmail()??'';
   getOrderHeader();
  }

  getOrderHeader() {
    this.loading.value = true;
    Map data ={
      "order_no": "",
      "order_date": "",
      "customer_no": "",
      "customer_name": "",
      "consignee_id": "",
      "consignee_name": "",
      "email_id": email_id,
      "rowsPerPage": rowsPerPage,
      "pageNumber": pageNumber,
      "order_status": "Shipped"
    };
    _api.getOrderHeaderGetApiHit(data, sessionManagement).then((value) {
      print(value);
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderHeaderGetModel> header_response = jsonResponse.map((data) => OrderHeaderGetModel.fromJson(data))
              .toList();
          if (header_response != null && header_response.length > 0 && header_response[0].condition == 'True') {
            loading.value = false;
            orderShippedData.value=header_response;
            print('lengh...${header_response.length}');
          }
          else {
            Utils.sanckBarError('False Message!', header_response[0].message.toString());
            loading.value = false;
          }
        } else {
          loading.value = false;
          Utils.sanckBarError(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);
        }
      } catch (e) {
        loading.value = false;
        Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      Utils.sanckBarError('API Error Exception',error.toString() );
      print(error);
      orderShippedData.value=[];
    });
  }

  void getShippedOrderData(String orderNo) {
    Map<String, String> data={
      "order_no": orderNo,
      "email_id": email_id
    };

    _api.shippedOrderGetApiHit(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ShippedOrderHeaderModal> response = jsonResponse.map((data) => ShippedOrderHeaderModal.fromJson(data))
              .toList();
          if (response != null && response.length > 0 && response[0].condition == 'True') {
            loading.value = false;
            headerDataList.value=response;
            Get.toNamed(RoutesName.shippedOrderHeaderScreen);
          }
          else {
            Utils.sanckBarError('False Message!', response[0].message.toString());
            loading.value = false;
          }
        } else {
          loading.value = false;
          Utils.sanckBarError(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);
        }
      } catch (e) {
        loading.value = false;
        Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      Utils.sanckBarError('API Error Exception',error.toString() );
      print(error);
      headerDataList.value=[];
    });



  }
}