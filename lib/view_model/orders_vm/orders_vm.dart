import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/constants/app_colors.dart';
import 'package:pristine_seeds/constants/app_font_size.dart';
import 'package:pristine_seeds/models/orders/consignee_model.dart';
import 'package:pristine_seeds/models/orders/customers_model.dart';
import 'package:pristine_seeds/models/orders/order_header_get_model.dart';
import 'package:pristine_seeds/models/orders/payment_terms_model.dart';
import 'package:pristine_seeds/models/orders/states_model.dart';
import 'package:pristine_seeds/repository/orders_repository/orders_repository.dart';
import '../../models/orders/item_category_model.dart';
import '../../models/orders/order_header_create_model.dart';
import '../../models/orders/order_item_get_model.dart';
import '../../models/orders/order_item_group_get_model.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../session_management/session_management_controller.dart';

class OrdersVM extends GetxController {
  final _api = OrdersRepository();
  RxBool loading = false.obs;
  RxBool isloading = false.obs;
  RxBool isPogressIndicator = false.obs;
  RxBool isCheckBoxChecked = false.obs;
  RxBool isShowMyExpensesLines = false.obs;
  RxBool isShowCustomerDetails = false.obs;
  RxBool isShowCheck = false.obs;
  RxBool isShowConsigneeDetails = false.obs;
  RxBool isShowListView = false.obs;
  RxBool isShowDropDown = true.obs;
  RxBool isStateName = true.obs;

  RxBool isNearBy = false.obs;

  RxDouble currentLat = 0.0.obs;
  RxDouble currentLng = 0.0.obs;
  RxDouble lat=0.0.obs;
  RxDouble lng=0.0.obs;
  RxString status="Pending".obs;
  RxString shippedstatus=''.obs;




  RxList<OrderHeaderCreateModel> order_detail_list = <OrderHeaderCreateModel>[].obs;

  RxList<OrderHeaderGetModel> order_header_get_list = <OrderHeaderGetModel>[].obs;


  RxList<OrderItemCategoryModel> searchResult = <OrderItemCategoryModel>[].obs;
  RxList<OrderItemCategoryModel> order_item_category_list = <OrderItemCategoryModel>[].obs;

  RxList<OrderItemGroupGetModel> search_group_result = <OrderItemGroupGetModel>[].obs;

  RxList<OrderItemGroupGetModel> order_item_group_get_list = <OrderItemGroupGetModel>[].obs;

  RxList<OrderItemGetModel> order_item_get_list = <OrderItemGetModel>[].obs;

  RxList<PaymentTermModel> paymentTerms_list = <PaymentTermModel>[].obs;
  RxList<ConsigneeModel> consignee_list = <ConsigneeModel>[].obs;

  //List<PaymentTermModel> paymentTerms_list=[];


  //List<OrderItemGroupGetModel> order_item_group_get_list=[];

  //todo for show customerDetails/consignee details.....
  Rx<CustomersModel> selected_customer=new CustomersModel().obs;
  Rx<ConsigneeModel> selected_consignee=new ConsigneeModel().obs;
  Rx<StateModel> selected_state=new StateModel().obs;
  Rx<PaymentTermModel> selected_location=new PaymentTermModel().obs;

  SessionManagement sessionManagement = SessionManagement();
  String email_id = "";
  RxString current_date = "".obs;

  RxString pending_amt = ''.obs;
  RxString under_approval_amt = ''.obs;
  RxString pending_shipment_amt = ''.obs;

  RxString SelectedVariety = "".obs;



  var qty_controller = TextEditingController();
  var customers_controller = TextEditingController();
  var consignee_name_drop_down_controller = TextEditingController();
  var location_center_controller = TextEditingController();
  var consignee_controller = TextEditingController();
  var customer_state_controller = TextEditingController();
  var region_catagory_controller = TextEditingController();
  var order_date_controller = TextEditingController();
  var order_expiry_date_controller = TextEditingController();

  //todo for add new consignee.................

  var consignee_contact_controller = TextEditingController();
  var consignee_contact_name_controller = TextEditingController();
  var consignee_name_controller = TextEditingController();
  var consignee_address_controller = TextEditingController();
  var consignee_address2_controller = TextEditingController();
  var consignee_city_controller = TextEditingController();
  var consignee_pincode_controller = TextEditingController();
  var consignee_state_name_controller = TextEditingController();

  //todo for item category page......
  var item_category_crop_controller = TextEditingController();
  var search_item_category_crop_controller = TextEditingController();
  var search_item_varieties_controller = TextEditingController();

  //todo for pagination....................
  ScrollController scrollController = ScrollController();
  int pageNumber=0;
  int rowsPerPage=10;
  int total_rows=0;

  @override
  void onInit() async {
    super.onInit();
    getCurrentDate();
    email_id = await sessionManagement.getEmail() ?? '';
    order_date_controller.text=current_date.value;
    //todo for get pending header lines...............
    this.pageNumber=0;
    getOrderHeader('Pending',0,'');
    getPaymentTerms();
    initCurrentLocationLatLant();


    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // You have reached the end of the list
        int total_page= (total_rows/rowsPerPage).toInt();
        if((total_rows%rowsPerPage)>0)
          total_page+=1;

        print("last index ${pageNumber} ${total_rows} ${rowsPerPage} ${total_page}");


        if(pageNumber+1!=total_page){
          getOrderHeader(last_status_value,pageNumber+1,'');
          this.pageNumber+=1;
        }
      }
    });

  }
  getCurrentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    current_date.value = formatter.format(now);
    print(current_date.value);
  }
  String getCurrentExpryDate(int no_of_expiry_days) {
    var now = new DateTime.now();
    now=now.add(Duration( days: no_of_expiry_days));
    var formatter = new DateFormat('yyyy-MM-dd');
    print(formatter.format(now) +"  "+no_of_expiry_days.toString());
    return formatter.format(now);
  }

  List<CustomersModel> customers_list=[];


  List<StateModel> state_list=[];


  Future<Iterable<CustomersModel>> searchCustomer(String query) async {

    if (query == '') {
      return const Iterable<CustomersModel>.empty();
    }
    Map data = {
      'customer_no': '',
      'customer_name': query,
      'customer_type': 'customer',
      "email_id": email_id,
      "latitude": lat.value==0.0 ? "" : (lat.toString()),
      "longitude": lng.value==0.0? "" : (lng.toString()),
      'row_per_page': 10,
      'page_number': 0
    };
    String customer_response =await _api.getCustomersApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(customer_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<CustomersModel> response =
        jsonResponse.map((data) => CustomersModel.fromJson(data)).toList();
        print('condition..'+response[0].condition.toString());
        if (response[0].condition == 'True') {
          print(jsonResponse);
          customers_list = response;

        } else {
          Utils.sanckBarException('False!', response[0].message!);
          customers_list = [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        customers_list = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      customers_list = [];
    }
    return customers_list;
  }

  getConsignee(String code){
    print('code......'+code);
    Map data = {
      'name':'',
      'customer_code': code
    };
    _api.getConsignee(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ConsigneeModel> response =
          jsonResponse
              .map((data) => ConsigneeModel.fromJson(data))
              .toList();
          if (response[0].condition == 'True') {
            consignee_list.value = response;
            print(consignee_list);

          } else {
            consignee_list.value = [];
            Utils.sanckBarError('Consignee!', response[0].message.toString());
          }
        } else {
          consignee_list.value = [];
          Utils.sanckBarError('API Error', jsonResponse);
        }
      } catch (e) {
        consignee_list.value = [];
        printError();
      }
    }).onError((error, stackTrace) {
      print(error);
      consignee_list.value = [];
    });
  }

  getPaymentTerms(){
    Map data = {
      'flag': 'Get',
      "created_by": email_id
    };
    _api.getPaymentTerms(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<PaymentTermModel> response =
          jsonResponse
              .map((data) => PaymentTermModel.fromJson(data))
              .toList();
          if (response[0].condition == 'True') {
            paymentTerms_list.value = response;

          } else {
            paymentTerms_list.value = [];
            Utils.sanckBarError('False Message!', response[0].message.toString());
            print(response[0].message);
          }
        } else {
          paymentTerms_list .value= [];
          Utils.sanckBarError('API Response Error!', jsonResponse);
        }
      } catch (e) {
        Utils.sanckBarException('Exception!', e.toString());
        paymentTerms_list.value = [];
        printError();
      }
    }).onError((error, stackTrace) {
      print(error);
      paymentTerms_list .value= [];
    });
  }

  getStatesList(){
    Map<String, String> data = {};
    _api.getStates(data, sessionManagement).then((value) {
      try {
        print(value);
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<StateModel> response = jsonResponse
              .map((data) => StateModel.fromJson(data))
              .toList();
          if (response[0].condition == 'True') {
            state_list=response;
          } else {
            state_list = [];
          }
        } else {
          state_list = [];
          Utils.sanckBarError('API Response Error!', jsonResponse);
        }

      } catch (e) {
        state_list = [];
        print(e);
      }
    }).onError((error, stackTrace) {
      state_list = [];
    });
  }

  orderHeaderCreate(){

    order_detail_list.value=[];
    if(customers_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Customer.');
      return;
    }
    if(isCheckBoxChecked.value && consignee_name_drop_down_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Consignee Name.');
      return;
    }

    if(order_date_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Order Date.');
      return;
    }
    if(location_center_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Payment Term.');
      return;
    }
    if(order_expiry_date_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Expiry Date.');
      return;
    }
    loading.value = true;
    Map<String ,String> data={
      'order_date':order_date_controller.text,
      'payment_term_code':selected_location.value.code!,
      'expiry_date':order_expiry_date_controller.text,
      'customer_no':selected_customer.value.customerNo ?? '',
      'consignee_id':selected_consignee.value.consigneeId ?? '',
      'email_id':email_id
    };
    _api.orderHeaderCreate(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderHeaderCreateModel> response =
          jsonResponse.map((data) => OrderHeaderCreateModel.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value = false;
            order_detail_list.value=response;
            Utils.sanckBarSuccess('Success Message!', response[0].message.toString());
            //Get.offAllNamed(RoutesName.orderItemCategoryScreen);
            Get.toNamed(RoutesName.orderItemCategoryScreen);
            getOrderItemCategoryGet(order_detail_list[0].orderNo!);

          } else {
            loading.value = false;
            Utils.sanckBarError('False Message!', response[0].message.toString());
            print(value);
          }
        } else {
          loading.value = false;
          Utils.sanckBarError('API Response Error!',jsonResponse);
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

  getOrderHeaderDetails(String orderNo,String tag){
    order_detail_list.value=[];
    loading.value = true;
    Map<String ,String> data={
      'order_no':orderNo,
      'email_id':email_id
    };
    _api.orderHeaderCreate(data, sessionManagement).then((value) {
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

            if(tag=='CART' || tag=='Shipped Details'){
              Get.toNamed(RoutesName.viewCartScreen);
            }
            else{
              Get.toNamed(RoutesName.orderItemCategoryScreen);
              getOrderItemCategoryGet(order_detail_list[0].orderNo!);
            }
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

  insertUpdateconsignee(){
    if(consignee_name_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Enter Consignee Name.');
      return;
    }

    if(consignee_contact_name_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Enter Contact Name.');
      return;
    }

    if(consignee_contact_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Enter Consignee Contact No.');
      return;
    }
    if(consignee_state_name_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Consignee State.');
      return;
    }
    if(consignee_address_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Enter Consignee Address.');
      return;
    }
    if(consignee_city_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Enter City Name.');
      return;
    }
    if(consignee_pincode_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Enter Consignee Pin-Code.');
      return;
    }
    var data  = [{
      "party_no": selected_customer.value.customerNo.toString(),
      "name": consignee_name_controller.text,
      "contact_name":consignee_contact_name_controller.text,
      "mobile_no": consignee_contact_controller.text,
      "address":  consignee_address_controller.text,
      "address2": consignee_address2_controller.text,
      "city":  consignee_city_controller.text,
      "pincode":  consignee_pincode_controller.text,
      "created_by": email_id,
      "state_name":consignee_state_name_controller.text,
      "state_code":  selected_state.value.stateCode,
    }];
    loading.value = true;
    _api.consigneeMstInsertUpdate(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ConsigneeModel> response =
          jsonResponse
              .map((data) => ConsigneeModel.fromJson(data))
              .toList();
          if (response[0].condition == 'True') {
            loading.value = false;
            resetAllConsigneeFields();
            Get.back();
            //paymentTerms_list.value = response;
            consignee_list.value = response;
            print('current id......'+consignee_list[0].currentConsigneeId.toString());

            getPaymentTerms();
            if(consignee_list[0].currentConsigneeId!.isNotEmpty){
              this.selected_consignee.value=consignee_list.firstWhere((element) => element.currentConsigneeId==element.consigneeId);
              this.consignee_name_drop_down_controller.text=selected_consignee.value.name!;
            }

            //getConsignee(selected_customer.value.customerNo!);
            isCheckBoxChecked.value=false;

          } else {
            paymentTerms_list.value = [];
            loading.value = false;
            Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          paymentTerms_list .value= [];
          loading.value = false;

          Utils.sanckBarError(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);
        }
      } catch (e) {
        paymentTerms_list.value = [];
        loading.value = false;
        printError();
      }
    }).onError((error, stackTrace) {
      print(error);
      loading.value = false;
      paymentTerms_list.value = [];
    });
  }

  getOrderItemCategoryGet(String orderNo){
    Map<String, String> data = {
      'order_no':orderNo,
      'email_id':email_id
    };
    _api.getOrderItemCategoryGet(data, sessionManagement).then((value) {
      try {
        print(value);
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderItemCategoryModel> response =
          jsonResponse.map((data) => OrderItemCategoryModel.fromJson(data)).toList();
          if (response!=null && response.isNotEmpty && response[0].condition == 'True') {
            isShowListView.value=true;
            order_item_category_list.value=response;
            searchResult.value=response;
            print('list length:: ${searchResult.length.toString()}');
          } else {
            order_item_category_list.value = [];
          }
        } else {
          order_item_category_list.value = [];
          Utils.sanckBarError(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);
        }
      } catch (e) {
        order_item_category_list.value = [];
        print(e);
      }
    }).onError((error, stackTrace) {
      order_item_category_list.value = [];
    });
  }

  String last_status_value="";
  getOrderHeader(String status,int pageNumber,String tag) {
    if(pageNumber<=0)
      order_header_get_list.value=[];
    if(status!=null && status!=""){
      this.last_status_value=status;
    }
    this.loading.value = true;
    Map<String, String> data ={
      "order_no": "",
      "order_date": "",
      "customer_no": "",
      "customer_name": "",
      "consignee_id": "",
      "consignee_name": "",
      "email_id": email_id,
      "rowsPerPage": this.rowsPerPage.toString(),
      "pageNumber": pageNumber.toString(),
      "order_status": status
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
            // print(header_response[0].underApproveAmount.toString());
            List<OrderHeaderGetModel> current_order_list=[];
            current_order_list.addAll(order_header_get_list.value);
            current_order_list.addAll(header_response);
            order_header_get_list.value=[];
            order_header_get_list.value=current_order_list;
            pending_amt.value=header_response[0].pendingAmount.toString();
            under_approval_amt.value=header_response[0].underApproveAmount.toString();
            pending_shipment_amt.value=header_response[0].pendingShipmentAmount.toString();
           // pending_shipment_amt.value=header_response[0].totalApprovePrice.toString();
            isShowMyExpensesLines.value = true;
            this.total_rows=int.parse(order_header_get_list[0].totalRows!);
            if(tag=='FromViewCart'){
              Get.toNamed(RoutesName.orderItemCategoryScreen);
            }
          }
          else {
            pending_amt.value=header_response[0].pendingAmount.toString();
            under_approval_amt.value=header_response[0].underApproveAmount.toString();
            pending_shipment_amt.value=header_response[0].pendingShipmentAmount.toString();
            //pending_shipment_amt.value=header_response[0].totalApprovePrice.toString();
            isShowMyExpensesLines.value = true;
            loading.value = false;
            order_header_get_list.value = [];
            if(tag=='FromViewCart'){
              Get.toNamed(RoutesName.orderItemCategoryScreen);
            }
          }
        } else {
          order_header_get_list.value=[];
          loading.value = false;
          Utils.sanckBarError(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);
        }
      } catch (e) {
        order_header_get_list.value=[];
        loading.value = false;
        printError();
        print(e);
      }finally{
        if(tag=='list_page'){
          Get.offAllNamed(RoutesName.ordersScreen);
        }
      }
    }).onError((error, stackTrace) {
      pending_amt.value='0';
      under_approval_amt.value='0';
      pending_shipment_amt.value='0';
      order_header_get_list.value=[];
      print(error);
      loading.value = false;
    });
  }

  getOrderItemGroupGet(String orderNo,String category_code,String tag) {
    this.loading.value = true;
    Map<String, String> data ={
      "order_no": orderNo,
      "email_id": email_id,
      "category_code":category_code
    };
    _api.getOrderItemGroupGet(data, sessionManagement).then((value) {
      print(value);

      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderItemGroupGetModel> response = jsonResponse.map((data) => OrderItemGroupGetModel.fromJson(data))
              .toList();
          if (response != null && response.length > 0 && response[0].condition == 'True') {
            loading.value = false;
            order_item_group_get_list.value = response;
            search_group_result.value=response;
            if(tag=='screen'){
              Get.toNamed(RoutesName.orderItemVarietiesScreen);
            }
          } else {
            Utils.sanckBarError(
                'Message False!',response[0].message!);
            loading.value = false;
            order_item_group_get_list.value = [];
          }
        } else {
          order_item_group_get_list.value=[];
          loading.value = false;
          Utils.sanckBarError('API Response Error!', jsonResponse.toString());
        }
      } catch (e) {
        Utils.sanckBarException('Exception!', e.toString());
        order_item_group_get_list.value=[];
        loading.value = false;
        printError();
        print(e);
      }
    }).onError((error, stackTrace) {
      order_item_group_get_list.value=[];
      print(error);
      loading.value = false;
    });
  }

  getOrderItem(String orderNo,String category_code,String group_code,String flag) {
    this.loading.value = true;
    Map<String, String> data ={
      "order_no": orderNo,
      "email_id": email_id,
      "category_code":category_code,
      "group_code":group_code
    };
    _api.getOrderItemGet(data, sessionManagement).then((value) {
      print(value);

      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderItemGetModel> response = jsonResponse.map((data) => OrderItemGetModel.fromJson(data))
              .toList();
          if (response != null && response.length > 0 && response[0].condition == 'True') {
            loading.value = false;
            order_item_get_list.value = response;
            if(flag=='Vairiety'){
              Get.toNamed(RoutesName.orderItemVarietyCardScreen);
            }
          }
          else {
            order_item_get_list.value=[];
            loading.value = false;
            Utils.sanckBarError('API Response Error', response[0].message!);
          }
        }
      } catch (e) {
        Utils.sanckBarError('API Response ', e.toString());
        order_item_get_list.value=[];
        loading.value = false;
        printError();
        print(e);
      }
    }).onError((error, stackTrace) {
      order_item_get_list.value=[];
      print(error);
      loading.value = false;
    });
  }


  bool isButtonEnabled = true;

  orderItemLineInsert(String orderNo,String itemNo,int qty,String tag,String from_page) {
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
      "email_id":email_id
    };
    isPogressIndicator.value = true;
    _api.orderLineInsert(data, sessionManagement).then((value) {
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
            print(response);

            getOrderItemGroupGet(order_detail_list[0].orderNo!,SelectedVariety.value,'');

            //Utils.sanckBarSuccess('Success Message!', order_detail_list[0].message.toString());

            //todo for refresh item category list

            getOrderItemCategoryGet(order_detail_list[0].orderNo!);

            if(from_page=='VARIETY' || from_page=='CART' || from_page=='Dialog')
            {
              if(order_item_get_list.length>0)
                getOrderItem(orderNo,this.order_item_get_list[0].categoryCode!,this.order_item_get_list[0].groupCode!,'');
            }

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

  orderHeaderComplete(String orderNo) {
    Map<String, String> data ={
      "order_no": orderNo,
      "email_id":email_id
    };
    loading.value = true;
    _api.orderHeaderComplete(data, sessionManagement).then((value) {
      print(value);
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<OrderHeaderCreateModel> response =
          jsonResponse.map((data) => OrderHeaderCreateModel.fromJson(data)).toList();
          if (response!=null && response.length>0 && response[0].condition == 'True') {
            loading.value = false;
            Utils.sanckBarSuccess('Success Message!', response[0].message.toString());
            Get.dialog(
              WillPopScope(
                onWillPop: () async {
                  return false; // Return true to allow popping the route
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white, // Change this color or add decoration as needed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/check.png", // Replace with your tick image asset
                          width: 100,
                          height: 100,
                          // Adjust width and height according to your image size
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Order Confirmed !',
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontSize: AllFontSize.twentee,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("Your order,(${response[0].orderNo!}) has been completed.",
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500
                          ),),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        child: Text(
                            'Continue Shopping',
                            style: GoogleFonts.poppins(
                                color: AllColors.customDarkerWhite,
                                fontSize: AllFontSize.sisxteen,
                                fontWeight: FontWeight.w700
                            )
                        ),
                        onPressed: () {
                          getOrderHeader('Pending',0,'list_page');

                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.grey,
                            elevation: 2,
                            backgroundColor: AllColors.primaryDark1),
                      ),
                    ],
                  ),
                ),
              ),
              barrierDismissible: false, // Set to true to allow dismissing by tapping outside
              // barrierColor: Colors.black.withOpacity(0.5), // Adjust background opacity as needed
              useSafeArea: true, // Ensure content is within safe area boundaries
            );

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
    })
        .onError((error, stackTrace) {
      print(error);
      loading.value = false;
    });
  }

  //todo for filter list........
  onSearchTextChanged(String text) async {
    try{
      if (text.isEmpty) {
        searchResult.value = await List.from(order_item_category_list);
        update();
        return;
      }
      searchResult.value = await order_item_category_list
          .where((item) => item.categoryCode!.toLowerCase().contains(text.toLowerCase()))
          .toList();
      update();
    }catch(e){
      print(e);
    }
  }

  //todo for filter varieties ........
  onSearchVarietiesTextChanged(String text) async {
    try{
      if (text.isEmpty) {
        search_group_result.value = await List.from(order_item_group_get_list);
        update();
        return;
      }
      search_group_result.value = await order_item_group_get_list
          .where((item) => item.groupCode!.toLowerCase().contains(text.toLowerCase()))
          .toList();
      update();
    }catch(e){
      print(e);
    }
  }

  void resetAllNewOrderFields(){
    isShowDropDown.value=false;
    isShowCustomerDetails.value = false;
    isShowConsigneeDetails.value = false;
    isCheckBoxChecked.value=false;
    consignee_name_drop_down_controller.clear();
    selected_customer.value=new CustomersModel();
    customers_controller.clear();
    location_center_controller.clear();
    order_expiry_date_controller.clear();
    isShowDropDown.value=true;
    //todo reset all consignee fields...............
    resetAllConsigneeFields();

  }

  void resetAllConsigneeFields(){
    //todo reset all consignee fields...............
    isStateName.value=false;
    isStateName.value=true;
    consignee_contact_controller.clear();
    consignee_contact_name_controller.clear();
    consignee_name_controller.clear();
    consignee_address_controller.clear();
    consignee_address2_controller.clear();
    consignee_city_controller.clear();
    consignee_pincode_controller.clear();
    consignee_state_name_controller.clear();
  }

  initCurrentLocationLatLant()async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled && (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse)) {
      Position userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentLat.value=userLocation.latitude;
      currentLng.value=userLocation.longitude;
      print("gfgmkdfgkfdkgfg"+currentLat.value.toString());
    }

  }

}