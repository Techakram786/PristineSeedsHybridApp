import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pristine_seeds/models/orders/order_approver_model.dart';
import '../../models/api_default_entity.dart';
import '../../models/checkin_approver/check_in_approve_entity.dart';
import '../../models/dash_board/emp_master_response.dart';

import '../../models/orders/order_header_create_model.dart';
import '../../repository/orders_repository/order_approver_repository.dart';
import '../../repository/user_expense_repo/expense_approver.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../session_management/session_management_controller.dart';

class OrderApproverViewModel extends GetxController {
  final _api = OrderApproverRepository();
  RxBool loading = false.obs;
  RxBool isPogressIndicator = false.obs;
  var qty_controller = TextEditingController();
  SessionManagement sessionManagement = SessionManagement();
  String Email_id = "";
  List<EmpMasterResponse> employess_List = [];
  var typeAheadControllerEmployee = TextEditingController();
  var remarks_controller = TextEditingController();

  var filter_date_controller = TextEditingController();
  String selection_type = "";
  List<OrderApproverModel> approver_list_data = [];

  RxList<OrderHeaderCreateModel> order_detail_list = <OrderHeaderCreateModel>[].obs;
  bool isButtonEnabled = true;

  @override
  Future<void> onInit() async {
    super.onInit();
    Email_id = await sessionManagement.getEmail() ?? '';
    this.getEmployeeMasterApi('');
  }

  getEmployeeMasterApi(String filter_login) {
    this.loading.value = true;
    Map data = {'email_id': Email_id};
    _api.getEmployeeTeam(data, sessionManagement).then((value) {
      try {
        List<EmpMasterResponse> emp_masterResponse =
        (json.decode(value) as List)
            .map((i) => EmpMasterResponse.fromJson(i))
            .toList();
        if (emp_masterResponse[0]?.condition.toString() == "True") {
          employess_List = emp_masterResponse;
        } else {
          employess_List = [];
        }
      } catch (e) {
        employess_List = [];
      }
    }).onError((error, stackTrace) {
      employess_List = [];
      Utils.sanckBarError('Api Exception onError', error.toString());
    }).whenComplete(() {
      this.loading.value = false;
      this.getApprovalList('');
    });
  }

  List<EmpMasterResponse> getSuggestions(String query) {
    List<EmpMasterResponse> matches = <EmpMasterResponse>[];
    matches.addAll(this.employess_List);
    matches.retainWhere(
            (s) => s.loginEmailId!.toLowerCase().contains(query.toLowerCase()));
    if (matches == null || matches.isEmpty) matches = [];
    print(matches);
    return matches;
  }

  String pending_count = "0", like_count = "0", dislike_count = "0";

  getApprovalList(String flag) {
    this.loading.value = true;
    Map data = {
      'email_id': Email_id,
      'filter_date': filter_date_controller.text.toString(),
      'filter_created_by': typeAheadControllerEmployee.text.toString(),
      'approve_status': selection_type
    };
    _api.GetApproverData(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderApproverModel> approver_list =
          jsonResponse.map((data) => OrderApproverModel.fromJson(data))
              .toList();

          if (approver_list[0].condition.toString() == "True") {
            approver_list_data = approver_list;
            pending_count = approver_list_data[0].pendingCount!;
            like_count = approver_list_data[0].approvedCount!;
            dislike_count = approver_list_data[0].rejectedCount!;
          } else {
            approver_list_data = [];
            pending_count = approver_list[0].pendingCount!;
            like_count = approver_list[0].approvedCount!;
            dislike_count = approver_list[0].rejectedCount!;
          }
        }
      } catch (e) {
        approver_list_data = [];
        pending_count = "0";
        like_count = "0";
        dislike_count = "0";
      }
    }).onError((error, stackTrace) {
      approver_list_data = [];
      pending_count = "0";
      like_count = "0";
      dislike_count = "0";
      Utils.sanckBarError('Api Exception onError', error.toString());
    }).whenComplete(()  {
      this.loading.value = false;
       if(flag=='GOTO_LIST'){
         Get.offAllNamed(RoutesName.orderApproverScreen);
       }
    });
  }

  markApproveReject(String document_no, String remarks,String approve_status) {
    this.loading.value = true;
    Map data = {
      'order_no': document_no,
      'approve_status': approve_status,
      'approve_by': Email_id,
      'reject_reason':remarks
    };
    _api.markApproveReject(data, sessionManagement).then((value) {
      try {
        print(value);
        List<ApiDefaultEntity> approver_list = (json.decode(value) as List)
            .map((i) => ApiDefaultEntity.fromJson(i))
            .toList();
        //   print(approver_list);
        if (approver_list[0].condition == "True") {
          this.loading.value = false;
          this.getApprovalList('GOTO_LIST');
          Utils.sanckBarSuccess('Message : ', approver_list[0].message);
        } else {
          this.loading.value = false;
          Utils.sanckBarError('Message : ', approver_list[0].message);
        }
      } catch (e) {
        this.loading.value = false;
        Utils.sanckBarError('Exception : ', e.toString());
      }
    }).onError((error, stackTrace) {
      this.loading.value = false;
      Utils.sanckBarError('Api Exception onError', error.toString());
    });
  }


  getOrderHeaderDetails(String orderNo){
    order_detail_list.value=[];
    loading.value = true;
    Map<String ,String> data={
      'order_no':orderNo,
      'email_id':Email_id
    };
    _api.orderDetailGet(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderHeaderCreateModel> response =
          jsonResponse.map((data) => OrderHeaderCreateModel.fromJson(data)).toList();
          if (response!=null && response.length>0 && response[0].condition == 'True') {
            loading.value = false;
            order_detail_list.value=response;
            Utils.sanckBarSuccess('Success Message!', response[0].message.toString());
            //Get.offAllNamed(RoutesName.orderItemCategoryScreen);
              Get.toNamed(RoutesName.approverCardView);

          } else {
            loading.value = false;
            Utils.sanckBarError('False Message!', response[0].message.toString());
            print(value);
          }
        } else {
          loading.value = false;
          Utils.sanckBarError('API Response Error', jsonResponse);
        }
      } catch (e) {
        loading.value = false;
        printError();
        Utils.sanckBarException('Exception Message!', e.toString());
      }
    }).onError((error, stackTrace) {
      print(error);
      loading.value = false;
    });
  }

  orderApproverItemLineInsert(String orderNo,String itemNo,int qty,String tag) {
    if (!isButtonEnabled) return; // Do not proceed if the button is disabled
       isButtonEnabled = false;
    if(tag=='ADD'){
      qty+=1;
    }
    else if(tag=='REMOVE'){
      qty-=1;
    }

    Map<String, String> data ={
      "order_no": orderNo,
      "item_no": itemNo,
      "qty":qty.toString() ?? '',
      "email_id":Email_id
    };
    isPogressIndicator.value = true;
    _api.orderApproverLineInsert(data, sessionManagement).then((value) {
      print(value);
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderHeaderCreateModel> response =
          jsonResponse.map((data) => OrderHeaderCreateModel.fromJson(data)).toList();
          if (response!=null && response.length>0 && response[0].condition == 'True') {
            isPogressIndicator.value = false;
            isButtonEnabled = true;
            order_detail_list.value=response;
          } else {
            isPogressIndicator.value = false;
            isButtonEnabled = true;
            Utils.sanckBarError('False Message!', response[0].message.toString());
            print(value);
          }
        } else {
          isPogressIndicator.value = false;
          isButtonEnabled = true;
          Utils.sanckBarError('API Response Error', jsonResponse);
        }
      } catch (e) {
        isPogressIndicator.value = false;
        isButtonEnabled = true;
        printError();
        Utils.sanckBarException('Exception Message!', e.toString());
      }
    })
        .onError((error, stackTrace) {
      print(error);
      isPogressIndicator.value = false;
      isButtonEnabled = true;
    });
  }
}