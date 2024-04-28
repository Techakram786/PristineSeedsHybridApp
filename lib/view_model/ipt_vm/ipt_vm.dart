import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/models/ipt/ipt_approvar_list_model.dart';
import 'package:pristine_seeds/models/ipt/lot_no_model.dart';
import 'package:pristine_seeds/repository/ipt_repository/ipt_repository.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/api_default_entity.dart';
import '../../models/dash_board/emp_master_response.dart';
import '../../models/ipt/ipt_header_create_model.dart';
import '../../models/ipt/ipt_item_category_model.dart';
import '../../models/ipt/ipt_item_get_model.dart';
import '../../models/ipt/ipt_item_group_model.dart';
import '../../models/ipt/ipt_model.dart';
import '../../models/orders/customers_model.dart';
import '../../utils/app_utils.dart';

class IPTViewModel extends GetxController{
   final _api=IptRepository();
   SessionManagement sessionManagement=SessionManagement();
   String email="";
   RxBool loading = false.obs;
   RxList<IptResponseModel> ipt_get_list=<IptResponseModel>[].obs;
   RxList<CustomersModel> ipt_customer_list=<CustomersModel>[].obs;
   RxList<IptHeaderCreateResponse> ipt_header_create=<IptHeaderCreateResponse>[].obs;
   RxList<itemCategoryResponse> ipt_item_category_list=<itemCategoryResponse>[].obs;
   RxList<itemCategoryResponse> searchResult=<itemCategoryResponse>[].obs;
   RxList<ItemGroupResponse> ipt_item_group_list=<ItemGroupResponse>[].obs;
   RxList<ItemGroupResponse> search_group_result=<ItemGroupResponse>[].obs;
   RxList<IptItemGetResponse> ipt_item_get_list=<IptItemGetResponse>[].obs;
   RxList<IptApproverModel>ipt_approver_list=<IptApproverModel>[].obs;
   List<EmpMasterResponse> employess_List = [];

   RxList<IptHeaderCreateResponse> approver_details_list=<IptHeaderCreateResponse>[].obs;

   RxList<IptHeaderCreateResponse> approvar_line_update_list=<IptHeaderCreateResponse>[].obs;


   RxString flag_lot=''.obs;
   RxBool isAddUpdate=false.obs;
   RxBool isUpdateLayout=true.obs;
   Rx<CustomersModel> selected_customer=new CustomersModel().obs;
   Rx<CustomersModel> selected_tocustomer=new CustomersModel().obs;
   RxList<LotNoModel> get_lot_no_list=<LotNoModel>[].obs;
   RxString pending_amt = ''.obs;
   RxString under_approval_amt = ''.obs;
   RxString pending_shipment_amt = ''.obs;
   RxString SelectedVariety = "".obs;
   RxBool isNearBy = false.obs;

   String category_code="";
   String group_code="";



   String pending_count = "0", approve_count = "0", rejected_count = "0";




   RxBool isShowfrom_CustomerDetails = false.obs;
   RxBool isShowto_CustomerDetails = false.obs;

   RxDouble currentLat = 0.0.obs;
   RxDouble currentLng = 0.0.obs;

   RxDouble lat=0.0.obs;
   RxDouble lng=0.0.obs;
   RxBool isShowDropDown = true.obs;

   String from_customer_no="";
   String to_customer_no="";
   String ipt_no="";

   int pageNumber=0;
   int rowsPerPage=10;
   int total_rows=0;

   String onCompleteflag="";

   RxString selectedFlag="Pending".obs;

   String approve_flag="";


   String selection_type="";


   var from_customers_controller = TextEditingController();
   var to_customers_controller = TextEditingController();
   var search_item_category_crop_controller = TextEditingController();

   var search_item_varieties_controller = TextEditingController();
   var filter_date_controller = TextEditingController();

   var ipt_qty_controller = TextEditingController();

   var ipt_lot_no_controller = TextEditingController();
   var ipt_emp_controller = TextEditingController();
   var remarks_controller = TextEditingController();


   @override
  void onInit() async  {
     email= await sessionManagement.getEmail() ?? "";
     getIptHeaderList(pageNumber,selectedFlag.value,"");
     initCurrentLocationLatLant();
     getEmployeeMasterApi("");
     getApproverList(selection_type,approve_flag);

  }






   //todo for filter varieties ........
   onSearchVarietiesTextChanged(String text) async {
      try{
         if (text.isEmpty) {
            search_group_result.value = await List.from(ipt_item_group_list);
            update();
            return;
         }
         search_group_result.value = await ipt_item_group_list
             .where((item) => item.groupcode!.toLowerCase().contains(text.toLowerCase()))
             .toList();
         update();
      }catch(e){
         print(e);
      }
   }



   getIptItem(String iptNo,String category_code,String group_code,String flag) {
      this.loading.value = true;
      Map<String, String> data ={
         "ipt_no": iptNo,
         "email_id": email,
         "category_code":category_code,
         "group_code":group_code
      };
      _api.getIPtItemGetApiHit(data, sessionManagement).then((value) {
         print(value);

         try {
            final jsonResponse = json.decode(value);
            if (jsonResponse is List) {
               List<IptItemGetResponse> response = jsonResponse.map((data) => IptItemGetResponse.fromJson(data))
                   .toList();
               if (response != null && response.length > 0 && response[0].condition == 'True') {
                  loading.value = false;
                  ipt_item_get_list.value = response;
             //   Utils.sanckBarSuccess('Success ', response[0].message.toString());
                  if(flag=='Vairiety'){
                     Get.toNamed(RoutesName.iptItemVerietyCardDetails);
                  }
               }
               else {
                  ipt_item_get_list.value=[];
                  loading.value = false;
                 Utils.sanckBarError('Error ', response[0].message.toString());
               }
            }
         } catch (e) {
            Utils.sanckBarError('API Response ', e.toString());
            ipt_item_get_list.value=[];
            loading.value = false;
            printError();
            print(e);
         }
      }).onError((error, stackTrace) {
         ipt_item_get_list.value=[];
         print(error);
         loading.value = false;
      });
   }

   onSearchTextChanged(String text) async {
      try{
         if (text.isEmpty) {
            searchResult.value = await List.from(ipt_item_category_list);
            update();
            return;
         }
         searchResult.value = await ipt_item_category_list
             .where((item) => item.categorycode!.toLowerCase().contains(text.toLowerCase()))
             .toList();
         update();
      }catch(e){
         print(e);
      }
   }



  getIptHeaderList(int page_no,String status,String tag){
      try{
         Map<String, String> data={
            "ipt_no": "",
            "ipt_date": "",
            "from_customer_no": "",
            "to_customer_no": "",
            "from_customer_name": "",
            "to_customer_name": "",
            "ipt_status":status,
            "email_id": email.toString(),
            "rowsPerPage": rowsPerPage.toString(),
            "pageNumber": page_no.toString()
         };
          loading.value=true;
         _api.getIptListHitApi(data, sessionManagement).then((value) {
            print(value);
            final jsonResponse=json.decode(value);
            if(jsonResponse is List){
               List<IptResponseModel> response=jsonResponse.map((e) =>
                   IptResponseModel.fromJson(e)).toList();
               if(response!=null && response.length>0 && response[0].condition=="True"){
                  loading.value=false;
               //   ipt_get_list.value=response;
                  if(page_no==0){
                     ipt_get_list.clear();
                  }
                  ipt_get_list.addAll(response);
                   total_rows=int.parse(ipt_get_list[0].totalrows!);
                     if(tag=="FromViewCart"){
                      Get.toNamed(RoutesName.iptItemCategoryGet);
                   }


               }else{
                  loading.value=false;
                  ipt_get_list.value=[];
                  print("Error");
               }
            }else {
               ipt_get_list.value=[];
               loading.value = false;
               Utils.sanckBarError('API Response Error!', jsonResponse.toString());
            }
         },).onError((error, stackTrace) {
            pending_amt.value='0';
            under_approval_amt.value='0';
            pending_shipment_amt.value='0';
            loading.value = false;
            print(error);
         },);

      }catch(e) {
         loading.value = false;
         print(e);
      }
   }




   IptHeaderCreate(){
      try{
         Map<String, String> data={
            "ipt_no": "",
            "from_customer_no":from_customer_no.toString(),
            "to_customer_no":to_customer_no.toString(),
            "email_id": email
         };
         loading.value=true;
         _api.createIptApiHit(data, sessionManagement).then((value) {
            final JsonResponse=json.decode(value);
            if(JsonResponse is List){
               List<IptHeaderCreateResponse> response =JsonResponse.map((e) =>IptHeaderCreateResponse.fromJson(e) ).toList();
              if(response!=null && response.length>0 && response[0].condition=="True"){
                 loading.value=false;
                 ipt_header_create.value=response;
                 ipt_no=ipt_header_create[0].iptNo!;
                 print("Ipt No........${ipt_no.toString()}");
                 Utils.sanckBarSuccess("Success Message",response[0].message.toString());
                 getIptHeaderList(0,'Pending','');
                 Get.toNamed(RoutesName.iptItemCategoryGet);
                 rowsPerPage=10;
                 iptItemCategoryGet(ipt_header_create[0].iptNo!);


              }else{
                 loading.value=false;
                 ipt_header_create.value=[];
                 Utils.sanckBarError("Error Message",response[0].message.toString());
              }

            }else{
               loading.value=false;
               ipt_header_create.value=[];
               Utils.sanckBarError('API Response Error!', JsonResponse.toString());
            }


         },).onError((error, stackTrace) {
            loading.value=false;
            ipt_header_create.value=[];
            print(error);

         },);

      }catch(e){
         print(e);
      }
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


   Future<Iterable<CustomersModel>> searchCustomer(String query) async {

      if (query == '') {
         return const Iterable<CustomersModel>.empty();
      }
      Map data = {
         'customer_no': '',
         'customer_name': query,
         'customer_type': 'customer',
         "email_id": email.toString(),
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
               ipt_customer_list.value = response;

            } else {
               Utils.sanckBarException('False!', response[0].message!);
               ipt_customer_list.value = [];
            }
         } else {
            Utils.sanckBarException('False!', jsonResponse.message);
            ipt_customer_list.value = [];


         }
      } catch (e) {
         Utils.sanckBarException('Exception!', e.toString());
         ipt_customer_list.value = [];
      }
      return ipt_customer_list;
   }


   iptItemCategoryGet(String ipt_no){
      try{
         Map<String, String> data={
            "ipt_no": ipt_no.toString(),
            "email_id": email
         };
         loading.value=true;
         _api.getIPtItemCategoryApiHit(data, sessionManagement).then((value) {
            final JsonResponse=json.decode(value);

            if(JsonResponse is List){
               List<itemCategoryResponse> response =JsonResponse.map((e) =>
                   itemCategoryResponse.fromJson(e)).toList();

               if(response!=null && response.length>0 && response[0].condition=="True"){
                  loading.value=false;
                  ipt_item_category_list.value=response;
                  searchResult.value=response;
               }
               else{
                  loading.value=false;
                  ipt_item_category_list.value = [];
               }
            }
            else{
               loading.value=false;
               Utils.sanckBarError(
                   'API Error',
                   JsonResponse["message"] == null
                       ? 'Invalid response format'
                       : JsonResponse["message"]);
               ipt_item_category_list.value = [];
            }
         },).onError((error, stackTrace) {
            loading.value=false;
            ipt_item_category_list.value = [];
         },
         );

      }catch(e){
         print(e);

      }
   }
   IptHeaderDetails(String ipt_no,String tag){
      ipt_header_create.value=[];
      try{
         Map<String, String> data={
            "ipt_no":ipt_no,
            "email_id": email
         };
         loading.value=true;
         _api.createIptApiHit(data, sessionManagement).then((value) {
            print(value);
            final JsonResponse=json.decode(value);
            if(JsonResponse is List){
               List<IptHeaderCreateResponse> response =JsonResponse.map((e) =>IptHeaderCreateResponse.fromJson(e) ).toList();
               if(response!=null && response.length>0 && response[0].condition=="True"){
                  loading.value=false;
                  ipt_header_create.value=response;
                  ipt_no=ipt_header_create[0].iptNo!;
                  print("Ipt No........${ipt_no.toString()}");

                  Utils.sanckBarSuccess("Success Message",response[0].message.toString());
                  if(tag=='CART'){
                     print(tag);
                     Get.toNamed(RoutesName.iptViewCartScreen);
                  }
                  else{
                     print(tag);
                     Get.toNamed(RoutesName.iptItemCategoryGet);
                     iptItemCategoryGet(ipt_header_create[0].iptNo!);
                  }

               }else{
                  loading.value=false;
                  ipt_header_create.value=[];
                  Utils.sanckBarError("Error Message",response[0].message.toString());
               }

            }else{
               loading.value=false;
               ipt_header_create.value=[];
               Utils.sanckBarError('API Response Error!', JsonResponse.toString());
            }


         },).onError((error, stackTrace) {
            loading.value=false;
            ipt_header_create.value=[];
            print(error);

         },);

      }catch(e){
         print(e);
      }
   }
   getIptItemGroupGet(String orderNo,String category_code,String tag) {
      this.loading.value = true;
      Map<String, String> data ={
         "ipt_no": orderNo,
         "email_id": email,
         "category_code":category_code
      };
      _api.getIPtItemGroupApiHit(data, sessionManagement).then((value) {
         print(value);

         try {
            final jsonResponse = json.decode(value);
            if (jsonResponse is List) {
               List<ItemGroupResponse> response = jsonResponse.map((data) => ItemGroupResponse.fromJson(data))
                   .toList();
               if (response != null && response.length > 0 && response[0].condition == 'True') {
                  loading.value = false;
                  ipt_item_group_list.value = response;
                  search_group_result.value=response;
                  print("category......"+response[0].categorycode!);
                  if(tag=='screen'){
                     Get.toNamed(RoutesName.iptItemVerietyGetDetails);
                  }
               } else {
               //   Utils.sanckBarError('Message False!',response[0]!);
                  loading.value = false;
                  ipt_item_group_list.value = [];
               }
            } else {
               ipt_item_group_list.value=[];
               loading.value = false;
               Utils.sanckBarError('API Response Error!', jsonResponse.toString());
            }
         } catch (e) {
            Utils.sanckBarException('Exception!', e.toString());
            ipt_item_group_list.value=[];
            loading.value = false;
            printError();
            print(e);
         }
      }).onError((error, stackTrace) {
         ipt_item_group_list.value=[];
         print(error);
         loading.value = false;
      });
   }
   void resetAllNewIptFields(){
      isShowDropDown.value=false;
      selected_customer.value=new CustomersModel();
      from_customers_controller.clear();
      to_customers_controller.clear();
      isShowDropDown.value=true;
      isShowfrom_CustomerDetails.value = false;
      isShowto_CustomerDetails.value = false;
   }


   IptItemLineInsert(String orderNo,String itemNo,int qty,String lot_no) {
      Map<String, String> data ={
         "ipt_no": orderNo,
         "item_no": itemNo,
         "lot_no":lot_no,
         "qty":qty.toString() ?? '',
         "email_id":email
      };

     // print("${data}");

      loading.value = true;
      _api.IptLineInsertApiHit(data, sessionManagement).then((value) {
         print(value);
         try {
            final jsonResponse = json.decode(value);
            if (jsonResponse is List) {
               List<IptHeaderCreateResponse> response =
               jsonResponse.map((data) => IptHeaderCreateResponse.fromJson(data)).toList();
               if (response!=null && response.length>0 && response[0].condition == 'True') {
                  loading.value = false;
                  ipt_header_create.value=response;
                  print(response);
                  print("Froup Dode........${ipt_item_get_list[0].imageurl}");

                  getIptItem(ipt_header_create[0].iptNo!,category_code!,group_code!,"");

                  getIptItemGroupGet(ipt_header_create[0].iptNo!,category_code!,"");
               //   iptItemCategoryGet(ipt_header_create[0].iptNo.toString());

                  Utils.sanckBarSuccess('Success Message!', 'Order Line Delete Successfully');

                  /// todo for refresh item category list

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
   getLotNo(String ipt_no, String item_no){
      print('code......'+item_no);
      Map data = {
         "email_id": email,
         "ipt_no": ipt_no ,
         "item_no":item_no
      };
      _api.IptLotNoApiHit(data, sessionManagement).then((value) {
         try {
            final jsonResponse = json.decode(value);
            if (jsonResponse is List) {
               List<LotNoModel> response =
               jsonResponse
                   .map((data) => LotNoModel.fromJson(data))
                   .toList();
               if (response[0].condition == 'True') {
                  get_lot_no_list.value = response;
                  print(get_lot_no_list);

               } else {
                  get_lot_no_list.value = [];
                  Utils.sanckBarError('Consignee!', response[0].message.toString());
               }
            } else {
               get_lot_no_list.value = [];
               Utils.sanckBarError('API Error', jsonResponse);
            }
         } catch (e) {
            get_lot_no_list.value = [];
            printError();
         }
      }).onError((error, stackTrace) {
         print(error);
         get_lot_no_list.value = [];
      });
   }
   IptHeaderComplete(String IptNo,flag) {
      Map<String, String> data ={
         "ipt_no": IptNo,
         "email_id":email
      };
      loading.value = true;
      _api.IptHeaderCompleteApiHit(data, sessionManagement).then((value) {
         print(value);
         try {
            final jsonResponse = json.decode(value);
            if (jsonResponse is List) {
               List<IptHeaderCreateResponse> response =
               jsonResponse.map((data) => IptHeaderCreateResponse.fromJson(data)).toList();
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
                                 Text('Ipt Confirmed !',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.blackColor,
                                        fontSize: AllFontSize.twentee,
                                        fontWeight: FontWeight.w700
                                    ),
                                 ),
                                 SizedBox(height: 10,),
                                 Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Text("Your Ipt,(${response[0].iptNo!}) has been completed.",
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
                                       getIptHeaderList(pageNumber,selectedFlag.value,"");
                                      // getOrderHeader('Pending',0,'list_page');
                                       Get.toNamed(RoutesName.iptHeaderList);

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

   getApproverList(String status,String flag){
      try{
         Map<String, String >data={
            "filter_date": filter_date_controller.text.isNotEmpty?filter_date_controller.text:"",
            "filter_created_by": ipt_emp_controller.text.isNotEmpty?ipt_emp_controller.text:"",
            "email_id": email,
            "approve_status": status
         };

         loading.value=true;
         _api.IptApproverApiHit(data, sessionManagement).then((value) {
            print(value);

            final JsonResponse=json.decode(value);

            if(JsonResponse is List){
               List<IptApproverModel> response=JsonResponse.map((e) =>
                   IptApproverModel.fromJson(e)).toList();

               if(response !=null && response.length>0 && response[0].condition=="True"){
                  loading.value=false;
                  ipt_approver_list.value=response;
                  pending_count=response[0].pendingcount.toString();
                  approve_count=response[0].approvedcount.toString();
                  rejected_count=response[0].rejectedcount.toString();
                  if(flag=="Go To List"){
                     Get.toNamed(RoutesName.iptApproverScreen);
                  }
               }else{
                  print("Error");
                  loading.value=false;
                  ipt_approver_list.value=[];
                  pending_count=response[0].pendingcount.toString();
                  approve_count=response[0].approvedcount.toString();
                  rejected_count=response[0].rejectedcount.toString();
               }


            }else{
               loading.value = false;
               Utils.sanckBarError('API Response Error', JsonResponse);
            }



         },).onError((error, stackTrace) {
            loading.value = false;
            print(error);
         },);
      }catch(e){
         loading.value = false;
         pending_count="0";
         approve_count="0";
         rejected_count="0";
         print(e);
      }
   }
   getEmployeeMasterApi(String filter_login) {
      this.loading.value = true;
      Map data =
      {
         'email_id': email
      };
      _api.getEmployeeApiHit(data, sessionManagement).then((value) {
         try {
            List<EmpMasterResponse> emp_masterResponse =
            (json.decode(value) as List)
                .map((i) => EmpMasterResponse.fromJson(i))
                .toList();
            if (emp_masterResponse!=null && emp_masterResponse.length>0 && emp_masterResponse[0].condition== "True") {
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
      });
   }
   getIptApproverDetails(String ipt_no){

      try{
         Map<String , String >data={
            "ipt_no": ipt_no.toString(),
            "email_id": email
         };
         loading.value=true;
         _api.createIptApiHit(data, sessionManagement).then((value) {
            print(value);
            final JsonResponse=json.decode(value);
            if(JsonResponse is List){
               List<IptHeaderCreateResponse> response =
               JsonResponse.map((e) =>IptHeaderCreateResponse.fromJson(e) ).toList();
               if(response!=null && response.length>0 && response[0].condition=="True"){
                  loading.value=false;
                  approver_details_list.value=response;
                  Get.toNamed(RoutesName.iptApproverviewScreen);


               }else{
                  loading.value=false;
                  approver_details_list.value=[];
               }
            }else{
               loading.value=false;
               approver_details_list.value=[];
               Utils.sanckBarError('API Response Error', JsonResponse);
            }
         },).onError((error, stackTrace) {
            loading.value=false;
            approver_details_list.value=[];
            print(error);
         },);
      }catch(e){
         print(e);
      }
   }
   iptApproverLineUpdate(String ipt_no,String item_no,String lot_no, String qty){
      Map<String, String> data={
         "ipt_no":  ipt_no.toString(),
         "item_no": item_no.toString(),
         "lot_no": lot_no.toString() ,
         "qty": qty.toString(),
         "email_id": email
      };
      loading.value=true;
      _api.approvarLineUpadateApiHit(data, sessionManagement).then((value) {
         final JsonResponse=json.decode(value);

         if(JsonResponse is List){
            List<IptHeaderCreateResponse> response=JsonResponse.map((e)
            =>IptHeaderCreateResponse.fromJson(e)).toList();
            if(response!=null && response.length>0 && response[0].condition=="True"){
               loading.value=false;
               approver_details_list.value=response;
              // approvar_line_update_list.value=response;
               Utils.sanckBarSuccess('Success', response[0].message.toString());

            }else{
               loading.value=false;
               Utils.sanckBarError('Error', response[0].message.toString());
            }


         }
         else{
            loading.value=false;
            Utils.sanckBarError('API Response Error', JsonResponse);
         }

      },).onError((error, stackTrace) {
         loading.value=false;
           print(error);

      },);













   }
   iptApproveMarkRejected(String Ipt_no,String approve_status,String reason){
      try{
         Map<String, String> data={
            "ipt_no": Ipt_no,
            "approve_status": approve_status,
            "approve_by": email,
            "reject_reason": reason
         };
         print(data);
         loading.value=true;
         _api.approvarCompleteRejectedApiHit(data, sessionManagement).then((value) {
            print(value);
            final JsonResponse=json.decode(value);
            if(JsonResponse is List){
               List<ApiDefaultEntity> response=JsonResponse.map((e) =>
                   ApiDefaultEntity.fromJson(e)).toList();
               if(response!=null && response.length>0 && response[0].condition=="True"){
                  loading.value=false;
                  Utils.sanckBarSuccess('Success Message : ', response[0].message);
                  getApproverList(selection_type,approve_flag);
                  Get.toNamed(RoutesName.iptApproverScreen);

               }else{
                  loading.value=false;
                  Utils.sanckBarError('Error Message : ', response[0].message);


               }
            }else{
               loading.value=false;
               Utils.sanckBarError('Api  Response Error : ', JsonResponse);
            }

         },).onError((error, stackTrace) {
            loading.value=false;
            print(error);

         },);

      }catch(e){
         print(e);
      }










   }


}