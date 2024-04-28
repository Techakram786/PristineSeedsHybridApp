
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/models/product_on_ground/item_no_modal.dart';
import 'package:pristine_seeds/models/product_on_ground/pog_discard_modal.dart';
import 'package:pristine_seeds/models/product_on_ground/zone_get_modal.dart';
import 'package:pristine_seeds/repository/product_on_ground_repository/product_on_ground_repo.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';

import '../../models/collection/customer_modal.dart';
import '../../models/dash_board/emp_master_response.dart';
import '../../models/planting/season_model.dart';
import '../../models/product_on_ground/category_code_modal.dart';
import '../../models/product_on_ground/item_group_code_modal.dart';
import '../../models/product_on_ground/pog_approval_modal.dart';
import '../../models/product_on_ground/pog_complete_modal.dart';
import '../../models/product_on_ground/pog_create_model.dart';
import '../../models/product_on_ground/pog_list_modal.dart';
import '../../models/product_on_ground/pog_update_line_modal.dart';
import '../../repository/planting_repository/planting_creation_repo.dart';
import '../../utils/app_utils.dart';
import '../session_management/session_management_controller.dart';

class ProductOnGroundVM extends GetxController {
  final _api = ProductOnGroundRepository();
  final _api2 = plantingCreationRepository();

  SessionManagement sessionManagement = SessionManagement();
  String category_code = '';
  String item_group_code = '';

  RxBool loading = false.obs;
  String flag = 'Add';
  RxBool isShowDocDropDown = true.obs;
  RxBool isReadOnly = false.obs;
  RxBool isZone = true.obs;
  RxBool isSeason = true.obs;
  RxBool isCategoryCode = true.obs;
  RxBool isItemGroupCode = true.obs;
  RxBool isitemNo = true.obs;
  RxBool iscustomerdritri = true.obs;
  RxString isColorStatus="0".obs;

  RxBool isNearBy=false.obs;

  String pog_code = '';

  RxDouble currentLat = 0.0.obs;
  RxDouble currentLng = 0.0.obs;

  RxDouble lat=0.0.obs;
  RxDouble lng=0.0.obs;

  RxList<ZoneModal> zoneList = <ZoneModal>[].obs;
  RxList<SeasonGetModel> seasonList = <SeasonGetModel>[].obs;
  RxList<CategoryCodeModal> categoryCodeList = <CategoryCodeModal>[].obs;
  RxList<ItemGroupCodeModal> itemGroupCodeList = <ItemGroupCodeModal>[].obs;
  RxList<ItemNoModal> itemNoList = <ItemNoModal>[].obs;
  RxList<CustomerResponse> customerorDistributorList = <CustomerResponse>[].obs;
  RxList<ProductOnGroundDataListModal> pogDataList = <
      ProductOnGroundDataListModal>[].obs;


  var zone_controller = TextEditingController().obs;
  var season_controller = TextEditingController().obs;
  var empName_controller = TextEditingController().obs;
  var categoryCode_controller = TextEditingController().obs;
  var itemGroupCode_controller = TextEditingController().obs;
  var itemNo_controller = TextEditingController().obs;
  var customer_controller = TextEditingController().obs;
  var pogQty_controller = TextEditingController().obs;
  var date_controller = TextEditingController();
  var remark_controller = TextEditingController().obs;


  RxString email_id = ''.obs;

  int active = -1;
  int rowPerpage = 10;
  int pageNumber = 0;
  int total_rows = 0;

  String selectionType='Pending';


  @override
  void onInit() async {
    super.onInit();
    email_id.value = await sessionManagement.getEmail() ?? '';
    initCurrentLocationLatLant();
    productOnGroundGetData(pageNumber);
    getZoneFun();
    getSeasonCode();
    getCategoryCode();
    getCurrentDate();
  }

  Future collectionGetRefressUi() async {
    pageNumber=0;
    total_rows=0;
    pogDataList.value = [];
    productOnGroundGetData(pageNumber);
  }


  productOnGroundGetData(int pageNumber) {
    print("data.....");
    loading.value = true;
    Map data = {
      "created_by": email_id.value,
      "email": email_id.value,
      "status": selectionType,
      "row_per_page": rowPerpage,
      "page_no": pageNumber
    };

    _api.productOnGroundGetApiHit(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ProductOnGroundDataListModal> response =
          jsonResponse.map((data) =>
              ProductOnGroundDataListModal.fromJson(data)).toList();
          if (response.length > 0 && response != null &&
              response[0].condition == 'True') {
            loading.value = false;
            List<ProductOnGroundDataListModal> pogHeaderList = [];
          //  pogDataList.value=response;
            if(pageNumber==0){
              pogDataList.clear();
            }

            //pogHeaderList.addAll(pogDataList.value);
            pogDataList.addAll(response);
           // pogDataList.value = [];
           // pogDataList.value = pogHeaderList;
            this.total_rows = response[0].totalrows!;
          } else {
            pogDataList.value = [];
            loading.value = false;
           // Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          loading.value = false;
          Utils.sanckBarError('API Response', jsonResponse);
        }
      } catch (e) {
        loading.value = false;
        pogDataList.value = [];
        Utils.sanckBarError('Exception!', e.toString());
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.sanckBarError('API Error Exception', error.toString());
      print(error);
      pogDataList.value = [];
    });
  }

  getZoneFun() {
    loading.value = true;
    Map<String, String> data = {};
    _api.zoneGetApiHit(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ZoneModal> response =
          jsonResponse.map((data) => ZoneModal.fromJson(data)).toList();
          if (response.length > 0 && response != null &&
              response[0].condition == 'True') {
            loading.value = false;
            zoneList.value = response;
          } else {
            loading.value = false;
            Utils.sanckBarError(
                'Zone False Message!', response[0].message.toString());
          }
        } else {
          loading.value = false;
          Utils.sanckBarError('API Response', jsonResponse);
        }
      } catch (e) {
        loading.value = false;
        zoneList.value = [];
        Utils.sanckBarError('Exception!', e.toString());
      }
    });
  }

  getSeasonCode() {
    loading.value = true;
    Map<String, String> data = {
      "season_code": "",
      "season_name": ""
    };
    _api2.seasonMstGet(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<SeasonGetModel> response =
          jsonResponse.map((data) => SeasonGetModel.fromJson(data)).toList();
          if (response.length > 0 && response != null &&
              response[0].condition == 'True') {
            loading.value = false;
            seasonList.value = response;
          } else {
            loading.value = false;
            Utils.sanckBarError(
                "Season False Message!", response[0].message.toString());
          }
        } else {
          loading.value = false;
          Utils.sanckBarError('API Response', jsonResponse);
        }
      } catch (e) {
        loading.value = false;
        seasonList.value = [];
        Utils.sanckBarError('Exception!', e.toString());
      }
    });
  }

  getCategoryCode() {
    loading.value = true;
    Map<String, String> data = {};
    _api.categoryCodeApiHit(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<CategoryCodeModal> response =
          jsonResponse.map((data) => CategoryCodeModal.fromJson(data)).toList();
          if (response.length > 0 && response != null &&
              response[0].condition == 'True') {
            loading.value = false;
            categoryCodeList.value = response;

            // itemGroupCodeFun(categoryCode_controller.value as String);
          } else {
            loading.value = false;
            Utils.sanckBarError(
                'Category False Message!', response[0].message.toString());
          }
        } else {
          loading.value = false;
          Utils.sanckBarError('API Response', jsonResponse);
        }
      } catch (e) {
        loading.value = false;
        categoryCodeList.value = [];
        Utils.sanckBarError('Exception!', e.toString());
      }
    });
  }

  itemGroupCodeFun() {
    loading.value = true;
    Map<String, String> data = {
      "category_code": category_code
    };
    print("catttt.......${category_code.toString()}");

    _api.itemGroupCode(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ItemGroupCodeModal> response =
          jsonResponse.map((data) => ItemGroupCodeModal.fromJson(data))
              .toList();
          if (response.length > 0 && response != null &&
              response[0].condition == 'True') {
            loading.value = false;
            itemGroupCodeList.value = response;
            //getCustomerName();
          } else {
            Utils.sanckBarError(
                'False Message!', response[0].message.toString());
            loading.value = false;
            //getCustomerName();
          }
        } else {
          loading.value = false;
          Utils.sanckBarError('API Response', jsonResponse);
        }
      }
      catch (e) {
        loading.value = false;
        itemGroupCodeList.value = [];
        Utils.sanckBarError('Exception!', e.toString());
      }
    });
  }

  getItemNoFun() async {
    loading.value = true;
    print('fdh$category_code');
    print('hjsdfghg...${item_group_code}');
    Map data = {
      "item_no": "",
      "name": "",
      "category_code": category_code,
      "group_code": item_group_code,
      "crop_type": "",
      "gst_group_code": "",
      "hsn_code": "",
      "active": active,
      "rowsPerPage": rowPerpage,
      "pageNumber": 0
    };
    await _api.itemNoApiHit(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        print('response$jsonResponse');
        if (jsonResponse is List) {
          List<ItemNoModal> response =
          jsonResponse.map((data) => ItemNoModal.fromJson(data)).toList();
          List<ItemNoModal> itemNodataList = [];
          if (response.length > 0 && response != null &&
              response[0].condition == 'True') {
            loading.value = false;
            itemNodataList = response;
            itemNoList.value = itemNodataList;
          } else {
            itemNoList.value = [];
            Utils.sanckBarError(
                'Item No. Message', response[0].message.toString());
            loading.value = false;
          }
        } else {
          loading.value = false;
          Utils.sanckBarError('API Response', jsonResponse);
        }
      }
      catch (e) {
        loading.value = false;
        itemNoList.value = [];
        Utils.sanckBarError('Exception!', e.toString());
      }
    });
  }

  /*getCustomerName() {
    loading.value = true;
    Map data = {
      "customer_no": "",
      "customer_name": "",
      "customer_type": "customer",
      "state_code": "",
      "latitude": lat.value==0.0 ? "" : (lat.toString()),
      "longitude":  lng.value==0.0? "" : (lng.toString()),
      "email_id": email_id.value,
      "row_per_page": 10,
      "page_number": 0
    };

    _api2.getCustomersApiHit(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<CustomerResponse> response =
          jsonResponse.map((data) => CustomerResponse.fromJson(data)).toList();
          if (response.length > 0 && response != null &&
              response[0].condition == 'True') {
            customerorDistributorList.value = response;
            loading.value = false;
          } else {
            loading.value = false;
            Utils.sanckBarError(
                'Customer/Distributor False Message!', response[0].message.toString());
          }
        } else {
          loading.value = false;
          Utils.sanckBarError('API Response', jsonResponse);
        }
      } catch (e) {
        loading.value = false;
        print(e);
        Utils.sanckBarError('Exception!', e.toString());
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.sanckBarError('API Error Exception', error.toString());
      print(error);
    });
  }
*/
  void getCurrentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    date_controller.text = formatter.format(now).toString();
  }

  void addLines() async {
    if (zone_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Zone.');
      return;
    }
    else if (season_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Season.');
      return;
    }
    else if (categoryCode_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Category Code.');
      return;
    }
    else if (itemGroupCode_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Item Group Code.');
      return;
    } else if (itemNo_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Item No');
      return;
    }
    else if (customer_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Customer/Dristributor');
      return;
    }
    else if (pogQty_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Enter POG Qty.');
      return;
    }
    else if (date_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Date');
      return;
    }
    else if (remark_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Enter Remark.');
      return;
    }
    else {
      loading.value = true;
      double? pogQty = double.parse(pogQty_controller.value.text);
      Map data = {
        "zone": zone_controller.value.text,
        "emp_name": "",
        "season": season_controller.value.text,
        "category_code": categoryCode_controller.value.text,
        "item_group_code": itemGroupCode_controller.value.text,
        "item_no": itemNo_controller.value.text,
        "customer_or_distributor": customer_controller.value.text,
        "pog_qty": pogQty,
        "date": date_controller.value.text,
        "remarks": remark_controller.value.text,
        "created_by": email_id.value
      };
      await _api.productionOnGroundLineApiHit(data, sessionManagement).then((
          value) {
        try {
          final jsonResponse = json.decode(value);
          if (jsonResponse is List) {
            List<ProductOfGroundCreate> response =
            jsonResponse.map((data) => ProductOfGroundCreate.fromJson(data))
                .toList();
            if (response[0].condition == 'True') {
              Utils.sanckBarSuccess('Success', response[0].message.toString());
              Get.offAllNamed(RoutesName.productongroundScreen);
              loading.value = false;
            } else {
              loading.value = false;
              Utils.sanckBarError(
                  'False Message!', response[0].message.toString());
            }
          } else {
            loading.value = false;
            Utils.sanckBarError('API Response', jsonResponse);
          }
        } catch (e) {
          loading.value = false;
          print(e);
          Utils.sanckBarError('Exception!', e.toString());
        }
      });
    }
  }


  void clearAllField() {
    zone_controller.value.clear();
    isZone.value = false;
    isZone.value = true;
    season_controller.value.clear();
    isSeason.value = false;
    isSeason.value = true;
    empName_controller.value.clear();
    categoryCode_controller.value.clear();
    isCategoryCode.value = false;
    isCategoryCode.value = true;
    itemGroupCode_controller.value.clear();
    isItemGroupCode.value = false;
    isItemGroupCode.value = true;
    itemNo_controller.value.clear();
    isitemNo.value = false;
    isitemNo.value = true;
    customer_controller.value.clear();
    iscustomerdritri.value = false;
    iscustomerdritri.value = true;
    pogQty_controller.value.clear();
    date_controller.clear();
    remark_controller.value.clear();
  }

  void viewHeaderLineData(ProductOnGroundDataListModal pogDataList) {
    try {
      pog_code = pogDataList.pogcode!;
      Get.toNamed(RoutesName.productOnGroundLineDetails);
      zone_controller.value.text = pogDataList.zone!;
      isReadOnly.value = true;
      isShowDocDropDown.value = false;
      empName_controller.value.text = pogDataList.empname!;
      date_controller.text = pogDataList.date!;
      season_controller.value.text = pogDataList.season!;
      categoryCode_controller.value.text = pogDataList.categorycode!;
      itemGroupCode_controller.value.text = pogDataList.itemgroupcode!;
      itemNo_controller.value.text = pogDataList.itemno!;
      customer_controller.value.text = pogDataList.customerordistributor!;
      remark_controller.value.text = pogDataList.remarks!;
      pogQty_controller.value.text = pogDataList.pogqty.toString()!;
    } catch (e) {}
  }

  completeLine() {
    if (zone_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Zone.');
      return;
    }
    else if (empName_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Enter Emp Name.');
      return;
    }
    else if (season_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Season.');
      return;
    }
    else if (categoryCode_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Category Code.');
      return;
    }
    else if (itemGroupCode_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Item Group Code.');
      return;
    }
    else if (itemNo_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Item No');
      return;
    }
    else if (customer_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Customer/Dristributor');
      return;
    }
    else if (pogQty_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Enter POG Qty.');
      return;
    }
    else if (date_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Date');
      return;
    }
    else if (remark_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Enter Remark.');
      return;
    }
    else{
      loading.value = true;
      Map<String, String> data = {
        "email_id": email_id.value,
        "pog_code": pog_code!
      };

      _api.productOnGroundcompleteApiHit(data, sessionManagement).then((value) {
        try {
          final jsonResponse = json.decode(value);
          if (jsonResponse is List) {
            List<ProductOnGroundCompleteModal> response =
            jsonResponse.map((data) =>
                ProductOnGroundCompleteModal.fromJson(data)).toList();
            if (response[0].condition == 'True') {
              Utils.sanckBarSuccess('Success', response[0].message.toString());
              Get.offAllNamed(RoutesName.productongroundScreen);
              loading.value = false;
            } else {
              loading.value = false;
              Utils.sanckBarError('False Message!', response[0].message.toString());
            }
          } else {
            loading.value = false;
            Utils.sanckBarError('API Response', jsonResponse);
          }
        } catch (e) {
          loading.value = false;
          print(e);
          Utils.sanckBarError('Exception!', e.toString());
        }
      });
    }

  }

  updateDataLine() {
    print('pogcode....${pog_code}');
    if (zone_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Zone.');
      return;
    }
    else if (empName_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Enter Emp Name.');
      return;
    }
    else if (season_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Season.');
      return;
    }
    else if (categoryCode_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Category Code.');
      return;
    }
    else if (itemGroupCode_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Item Group Code.');
      return;
    } else if (itemNo_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Item No');
      return;
    }
    else if (customer_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Customer/Dristributor');
      return;
    }
    else if (pogQty_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Enter POG Qty.');
      return;
    }
    else if (date_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Select Date');
      return;
    }
    else if (remark_controller.value.text.isEmpty) {
      Utils.sanckBarError('Message : ', 'Please Enter Remark.');
      return;
    }
    else {
      loading.value = true;
      double? pogQty = double.parse(pogQty_controller.value.text);
      Map data = {
        "pog_code": pog_code!,
        "zone": zone_controller.value.text,
        "emp_name": empName_controller.value.text,
        "season": season_controller.value.text,
        "category_code": categoryCode_controller.value.text,
        "item_group_code": itemGroupCode_controller.value.text,
        "item_no": itemNo_controller.value.text,
        "customer_or_distributor": customer_controller.value.text,
        "pog_qty": pogQty ?? '',
        "date": date_controller.value.text,
        "remarks": remark_controller.value.text,
        "created_by": email_id.value
      };

      _api.productOnGroundUpdateApiHit(data, sessionManagement).then((value) {
        try {
          final jsonResponse = json.decode(value);
          if (jsonResponse is List) {
            List<ProductOnGroundUpdateModal> response =
            jsonResponse.map((data) =>
                ProductOnGroundUpdateModal.fromJson(data)).toList();
            if (response.length > 0 && response != null &&
                response[0].condition == 'True') {
              Utils.sanckBarSuccess('Success', response[0].message.toString());
              Get.offAllNamed(RoutesName.productongroundScreen);
              loading.value = false;
            } else {
              loading.value = false;
              Utils.sanckBarError(
                  'False Message!', response[0].message.toString());
            }
          } else {
            loading.value = false;
            Utils.sanckBarError('API Response', jsonResponse);
          }
        } catch (e) {
          loading.value = false;
          print(e);
          Utils.sanckBarError('Exception!', e.toString());
        }
      });
    }
  }

  discardLines(String pogCode) {
    loading.value = true;
   Map data = {
     "email_id": email_id.value,
     "pog_code": pogCode
   };
   _api.pogDiscardApiHit(data, sessionManagement).then((value) {
     try {
       final jsonResponse = json.decode(value);
       if (jsonResponse is List) {
         List<ProductOnGroundDiscardModal> response =
         jsonResponse.map((data) =>
             ProductOnGroundDiscardModal.fromJson(data)).toList();
         if (response[0].condition == 'True') {
           Utils.sanckBarSuccess('Success', response[0].message.toString());
           pageNumber=0;
           total_rows=0;
           //pogDataList.value = [];
           productOnGroundGetData(pageNumber);
           loading.value = false;
         } else {
           loading.value = false;
           Utils.sanckBarError('False Message!', response[0].message.toString());
         }
       } else {
         loading.value = false;
         Utils.sanckBarError('API Response', jsonResponse);
       }
     } catch (e) {
       loading.value = false;
       print(e);
       Utils.sanckBarError('Exception!', e.toString());
     }
   });

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

  Future<Iterable<CustomerResponse>> searchCustomer(String query) async {
    if (query == '') {
      return const Iterable<CustomerResponse>.empty();
    }
    Map data = {
      "customer_no":query,
      "customer_name": "",
      "customer_type": "customer",
      "state_code": "",
      "latitude": lat.value==0.0 ? "" : (lat.toString()),
      "longitude":  lng.value==0.0? "" : (lng.toString()),
      "email_id": email_id.value,
      "row_per_page": 10,
      "page_number": 0
    };

    String customer_response =await _api2.getCustomersApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(customer_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<CustomerResponse> response =
        jsonResponse.map((data) => CustomerResponse.fromJson(data)).toList();
        print('condition..'+response[0].condition.toString());
        if (response[0].condition == 'True') {
          print(jsonResponse);
          customerorDistributorList.value = response;

        } else {
          Utils.sanckBarException('False!', response[0].message!);
          customerorDistributorList.value = [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        customerorDistributorList.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      customerorDistributorList.value= [];
    }
    return customerorDistributorList.value;
  }
}