import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/repository/orders_repository/orders_repository.dart';
import '../../models/collection/collection_res.dart';
import '../../models/collection/customer_modal.dart';
import '../../models/orders/customers_model.dart';
import '../../repository/collection_repository/collection_repo.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../session_management/session_management_controller.dart';

class CollectionViewModal extends GetxController{
  final _api = CollectionRepository();

  SessionManagement sessionManagement = SessionManagement();
  RxBool loading = false.obs;

  RxBool isDocument_type=true.obs;
  RxBool isParty_Name=true.obs;

  RxBool isEndButtons = false.obs;
  RxBool isSendButtons = false.obs;
  RxBool isRefreshMap = true.obs;
  RxBool isAddLine = false.obs;
  RxBool reset_field_ui=false.obs;
  RxBool isNearBy=false.obs;

  RxDouble currentLat = 0.0.obs;
  RxDouble currentLng = 0.0.obs;

  RxDouble lat=0.0.obs;
  RxDouble lng=0.0.obs;



  RxBool isShowDocDropDown=true.obs;
  RxList<CollectionResponse> collection_list = <CollectionResponse>[].obs;
  RxList<CustomerResponse> customers_list=<CustomerResponse>[].obs;
  RxString email_id="".obs;
  RxBool isReadOnly=false.obs;

   RxString doc_type=''.obs;

   int pageNumber=0;
   int row_per_page=10;
   int total_rows=0;



  final partyName = TextEditingController();
  final  place= TextEditingController();
  final chqDDRtgsNo = TextEditingController();
  final depositedBank = TextEditingController();
  final depositedAt = TextEditingController();
  final bank = TextEditingController();
  final dateOfReceipt = TextEditingController();
  final amount = TextEditingController();
  final drawnBankname = TextEditingController();
  final remarks = TextEditingController();
  final date = TextEditingController();
  final collectionType=TextEditingController();


  List<String> collectionTypedata=['ABS', 'CD', 'Outstanding','SD'];
  Rx<String> selected_type=''.obs;



  @override
  void onInit() async {
    super.onInit();
    email_id.value = await sessionManagement.getEmail() ?? '';
    collectionGetApiHiting();
    initCurrentLocationLatLant();
    //getCustomerName();
    getCurrentDate();
  }


  collectionGetApiHiting()  {
    loading.value=true;
    Map data={
      "email": email_id.value,
      "created_by":email_id.value
    };

    _api.collectionMasterGetApiHit(data,sessionManagement).then((value){
      try{
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<CollectionResponse> response =
          jsonResponse.map((data) => CollectionResponse.fromJson(data)).toList();
          if (response.length>0 && response!=null &&  response[0].condition == 'True') {
            loading.value=false;
            collection_list.value=response;
          } else {
            loading.value=false;
            Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          loading.value=false;
          Utils.sanckBarError('API Response', jsonResponse);
        }
      }catch(e){
        loading.value=false;
        collection_list.value = [];
        Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      Utils.sanckBarError('API Error Exception',error.toString() );
      print(error);
      collection_list.value = [];
    });
  }
  Future collectionGetRefressUi() async{
    collection_list.value=[];
    collectionGetApiHiting();
  }

  addData() async {
    if(collectionType.text.isEmpty){
      Utils.sanckBarError('Message : ', 'Please Select Collection type.');
      return;
    }
    else  if(date.text.isEmpty){
      Utils.sanckBarError('Message : ', 'Please Select Date.');
      return;
    }
    else if(partyName.text.isEmpty){
      Utils.sanckBarError('Message : ', 'Please Select party Name.');
      return;
    }
   else if( place.text.isEmpty){
      Utils.sanckBarError('Message : ', 'Please Enter place.');
      return;
    }

  else  if(chqDDRtgsNo.text.isEmpty){
      Utils.sanckBarError('Message : ', 'Please Enter Chq/DD/RTGS.No.');
      return;
    }
    else if(drawnBankname.text.isEmpty){
      Utils.sanckBarError('Message : ', 'Please Enter Drawn Bank Name');
      return;
    }
  else  if(depositedBank.text.isEmpty){
      Utils.sanckBarError('Message : ', 'Please Enter deposited bank ');
      return;
    }
   else if(depositedAt.text.isEmpty){
      Utils.sanckBarError('Message : ', 'Please Select Deposited At');
      return;
    }
  else  if(bank.text.isEmpty){
      Utils.sanckBarError('Message : ', 'Please Enter bank');
      return;
    }
   else if(dateOfReceipt.text.isEmpty){
      Utils.sanckBarError('Message : ', 'Please Enter date of Receipt');
      return;
    }
    else if(amount.text.isEmpty){
      Utils.sanckBarError('Message : ', 'Please Enter amount');
      return;
    }
    else if(remarks.text.isEmpty){
      Utils.sanckBarError('Message : ', 'Please Enter Remark.');
      return;
    }
    else {
      loading.value=true;
      Map data={
        "amount": amount.value.text,
        "date": date.value.text,
        "party_name": partyName.value.text,
        "place": place.value.text,
        "chq_dd_rtgs_no": chqDDRtgsNo.value.text,
        "drawn_on_bank_name":drawnBankname.value.text,
        "deposited_bank":depositedBank.value.text,
        "deposited_at": depositedAt.value.text,
        "collection_type": collectionType.value.text,
        "bank": bank.value.text,
        "date_of_receipt": dateOfReceipt.value.text,
        "remark": remarks.value.text,
        "email": email_id.value
      };
      await _api.collectionMasterCreateApiHit(data,sessionManagement).then((value){
        try{
          final jsonResponse = json.decode(value);
          print(value);
          if (jsonResponse is List) {
            List<CollectionResponse> response =
            jsonResponse.map((data) => CollectionResponse.fromJson(data)).toList();
            if (response.length>0 && response!=null &&  response[0].condition == 'True') {
              Utils.sanckBarSuccess('Success',response[0].message.toString());
              loading.value=false;
              Get.offAllNamed(RoutesName.collectionScreen);
            } else {
              loading.value=false;
              Utils.sanckBarError('False Message!', response[0].message.toString());
            }
          } else {
            loading.value=false;
            Utils.sanckBarError('API Response', jsonResponse);
          }

        }catch(e){
          loading.value=false;
          print(e);
          Utils.sanckBarError('Exception!',e.toString());
        }

      }).onError((error, stackTrace) {
        loading.value=false;
        Utils.sanckBarError('API Error Exception',error.toString() );
        print(error);
      });
      }

  }

  void getCurrentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    date.value = formatter.format(now) as TextEditingValue;
    print(date.value);
  }

  resetAllLineFields(){
    place.clear();
    date.clear();
    dateOfReceipt.clear();
    depositedBank.clear();
    depositedAt.clear();
    bank.clear();
    amount.clear();
    remarks.clear();
    collectionType.clear();
    chqDDRtgsNo.clear();
    drawnBankname.clear();

  }

  viewHeaderLineData(CollectionResponse collection_list){
    try{
      Get.toNamed(RoutesName.collectionCreate);
      partyName.text=collection_list.partyname!;
      isReadOnly.value=true;
      isShowDocDropDown.value=false;
      place.text=collection_list.place!;
      date.text=collection_list.date!;
      dateOfReceipt.text=collection_list.dateofreceipt!;
      depositedBank.text=collection_list.depositedbank!;
      depositedAt.text=collection_list.depositedat!;
      bank.text=collection_list.bank!;
      amount.text=collection_list.amount!.toString();
      remarks.text=collection_list.remark!;
      collectionType.text=collection_list.collectiontype!;
      chqDDRtgsNo.text=collection_list.chqddrtgsno!;
      drawnBankname.text=collection_list.drawnonbankname!;
    }catch(e)
    {}

  }


  /*getCustomerName() {
    Map data = {
      "customer_no": "",
      "customer_name": "",
      "customer_type": "customer",
      "state_code": "",
      "latitude": lat.value==0.0 ? "" : (lat.toString()),
      "longitude": lng.value==0.0 ? "" : (lng.toString()),
      "email_id": email_id.value,
      "row_per_page":10 ,
      "page_number": 0
    };

    _api.getCustomersApiHit(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<CustomerResponse> response =
          jsonResponse.map((data) => CustomerResponse.fromJson(data)).toList();
          if (response.length > 0 && response != null && response[0].condition == 'True') {
            loading.value = false;
            customers_list.value=response;
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
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.sanckBarError('API Error Exception', error.toString());
      print(error);
    });
  }*/

  Future<Iterable<CustomerResponse>> searchCustomer(String text) async {

    if (text == '') {
      return const Iterable<CustomerResponse>.empty();
    }
    Map data = {
      "customer_no": text,
      "customer_name": "",
      "customer_type": "customer",
      "state_code": "",
      "latitude": lat.value==0.0 ? "" : (lat.toString()),
      "longitude": lng.value==0.0 ? "" : (lng.toString()),
      "email_id": email_id.value,
      "row_per_page":10 ,
      "page_number": 0
    };


    String customer_response =await  _api.getCustomersApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(customer_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<CustomerResponse> response =
        jsonResponse.map((data) => CustomerResponse.fromJson(data)).toList();
        print('condition..'+response[0].condition.toString());
        if (response[0].condition == 'True') {
          print(jsonResponse);
          customers_list.value = response;

        } else {
          Utils.sanckBarException('False!', response[0].message!);
          customers_list.value= [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        customers_list.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      customers_list.value = [];
    }
    return  customers_list.value;
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