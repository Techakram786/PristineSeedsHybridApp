import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pristine_seeds/models/customer_request/customer_type_model.dart';
import 'package:pristine_seeds/models/customer_request/sale_person_model.dart';
import 'package:pristine_seeds/models/customer_request/vender_type_model.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/collection/collection_res.dart';
import '../../models/customer_request/customer_create_model.dart';
import '../../models/customer_request/customer_request_approver_model.dart';
import '../../models/customer_request/customer_request_list_model.dart';
import '../../models/dash_board/emp_master_response.dart';
import '../../models/orders/states_model.dart';
import '../../models/planting/season_model.dart';
import '../../models/product_on_ground/pog_approval_reject_modal.dart';
import '../../repository/customer_request_repository/customer_request_repo.dart';
import '../../repository/event_management_repo/Event_management_repo.dart';
import '../../resourse/appUrl/app_url.dart';
import 'package:http/http.dart' as http;
import '../../utils/app_utils.dart';

class CustomerViewModel extends GetxController{
    final _api=CustomerRequestRepository();
    final _api_upload_discard = EventManagementRepository();
    SessionManagement sessionManagement=SessionManagement();
    RxBool isLoading=false.obs;
    String email='';
   RxString flag="Create".obs;
   RxString request_no="".obs;
   RxString status="Pending".obs;

    String uploadImageFlag ='';
    String buttonText ='';
    List<String> imageUrls=[];
    List<String> selectedImageUrls=[];
    RxList<String> upLoadLocalImagesList = <String>[].obs;
    RxInt selectedindex=0.obs;
    final ImagePicker _picker_checkout = ImagePicker();

    RxBool isDropDown=true.obs;

    RxBool isReadOnly=false.obs;
    RxBool isShowDocDropDown=true.obs;

    String selection_type="";


    String StateCode="";
    String StateName="";

    RxBool isshowBottom=false.obs;

    RxString pending_count="0".obs,approvel_count="0".obs,rejected_count="0".obs;


    List<String> gstCustomerTypeList=['Registered','Unregistered','Export/IMport', 'Exempted','E-Commerce'];
    List<String> countryTypeList=['INDIA'];

    RxList<CustomerRequestListResponse> customer_request_list=<CustomerRequestListResponse>[].obs;

    RxList<CustomerTypeResponse> Customer_type_list=<CustomerTypeResponse>[].obs;
    RxList<VendarTypeResponse> vender_type_list=<VendarTypeResponse>[].obs;
    RxList<StateModel> state_list = <StateModel>[].obs;
    RxList<SalePersonResponse> sale_person_list = <SalePersonResponse>[].obs;
    RxList<CustomerRequestCreateResponse> customer_req_create_list = <CustomerRequestCreateResponse>[].obs;
    RxList<CustomerRequestCreateResponse> customer_req_deatails_list = <CustomerRequestCreateResponse>[].obs;

    RxList<CustomerRequestApproverResponse> customer_request_approver_list=<CustomerRequestApproverResponse>[].obs;
    RxList<EmpMasterResponse> employess_List=<EmpMasterResponse>[].obs;



    final name_controller = TextEditingController();
    final address_controller = TextEditingController();
    final contact_controller = TextEditingController();
    final contact_no_controller = TextEditingController();
    final sale_person_controller = TextEditingController();
    final country_region_controller = TextEditingController();
    final post_code_controller = TextEditingController();
    final email_controller = TextEditingController();
    final mobile_no_controller = TextEditingController();
    final registration_no_controller = TextEditingController();
    final registration_type_controller = TextEditingController();
    final gst_customer_type_controller = TextEditingController();
    final pan_no_controller = TextEditingController();
    final state_code_controller = TextEditingController();
    final zone_controller = TextEditingController();
    final district_controller = TextEditingController();
    final reagion_controller = TextEditingController();
    final taluka_controller = TextEditingController();
    final customer_type_controller = TextEditingController();
    final vendor_type_controller = TextEditingController();
    final territory_type_controller = TextEditingController();
    final seed_licence_controller = TextEditingController();

    final status_controller = TextEditingController();

    final request_nocontroller = TextEditingController();

    final employee_name_controller = TextEditingController();
    final filter_date_controller = TextEditingController();
    var remarks_controller = TextEditingController();

    @override
    void onInit() async  {

        email=await sessionManagement.getEmail() ?? "";


        print("yyyyyyyyyyyyyyyyy"+flag.value);
        getCustomerRequestList(status.value);

        getCustomerType();
        getVendarType();
        getState();
        //getSalesPerson();
        getEmployeeMasterApi(" ");

        getCustomerApparverList();



  }

  getCustomerRequestList(String status){

      print(status.toString());
      Map<String, String> data={
      "request_no": request_nocontroller.text==""?"":request_nocontroller.text,
      "name": name_controller.value.text==""?"":name_controller.value.text,
      "status": status,
      "email_id": email
        };
        try{
            isLoading.value=true;
            _api.getCustomerRequestListHitApi(data, sessionManagement).then((value) {
                print(value);
                final JsonResponse=json.decode(value);
                if( JsonResponse is List){
                    List<CustomerRequestListResponse> response=JsonResponse.map((data) =>
                        CustomerRequestListResponse.fromJson(data)).toList();
                    if(response!=null && response.length>0 && response[0].condition=='True'){
                        isLoading.value=false;
                        customer_request_list.value=response;
                        print('jhjhf...${customer_request_list.length}');
                        print('reponse..${response.length}');
                    }else{
                        isLoading.value=false;
                        customer_request_list.value=[];
                    }
                }
            },).onError((error, stackTrace) {
               print(error);
               customer_request_list.value=[];
            },);

        }catch(e){
            print(e);
            isLoading.value=false;
            customer_request_list.value=[];
        }

    }

    customerRequestCreate(){
      print('hgfdf...${gst_customer_type_controller.text}');
      if(name_controller.text.isEmpty){
        Utils.sanckBarError('Message : ', 'Please Enter Name');
        return;
      }else if(address_controller.text.isEmpty){
        Utils.sanckBarError('Message : ', 'Please Enter Address');
        return;
      }else if(contact_controller.text.isEmpty){
        Utils.sanckBarError('Message : ', 'Please Enter Contact');
        return;
      }else if(country_region_controller.text.isEmpty){
        Utils.sanckBarError('Message : ', 'Please Enter Country Region');
        return;
      }else if(post_code_controller.text.isEmpty){
        Utils.sanckBarError('Message : ', 'Please Enter Post Code');
        return;
      }else if(email_controller.text.isEmpty){
        Utils.sanckBarError('Message : ', 'Please Enter Email');
        return;
      }else if(state_code_controller.text.isEmpty){
        Utils.sanckBarError('Message : ', 'Please Enter State Code');
        return;
      }else if (customer_type_controller.text.isEmpty){
        Utils.sanckBarError('Message : ', 'Please Enter Customer Type');
        return;
      }else if(seed_licence_controller.text.isEmpty){
        Utils.sanckBarError('Message : ', 'Please Enter Seed Licence No');
        return;
      }else{
        isLoading.value=true;
        Map<String, String> data={
          "name":name_controller.value.text ,
          "address": address_controller.value.text,
          "contact": contact_controller.value.text,
          "phone_no": contact_no_controller.value.text,
          "sales_person_code": sale_person_controller.value.text,
          "country_region_code": 'IN',
          "post_code":post_code_controller.value.text,
          "email": email_controller.value.text,
          "mobile_phone_no":mobile_no_controller.value.text,
          "gst_registraction_no":registration_no_controller.value.text,
          "gst_registraction_type": registration_type_controller.value.text,
          "gst_customer_type": gst_customer_type_controller.value.text,
          "pan_no": pan_no_controller.value.text,
          "state_code": StateCode,
          "zone": zone_controller.value.text,
          "district": district_controller.value.text,
          "region":reagion_controller.value.text,
          "taluka": taluka_controller.value.text,
          "customer_type": customer_type_controller.value.text,
          "vendor_type": vendor_type_controller.value.text,
          "territory_type": territory_type_controller.value.text,
          "seed_license_no": seed_licence_controller.value.text,
          "created_by": email.toString()
        };
        try{
          _api.createCustomerRequestHitApi(data, sessionManagement).then((value) {
            print(value);
            final JsonResponse=json.decode(value);
            if( JsonResponse is List){
              List<CustomerRequestCreateResponse> response=JsonResponse.map((data) =>
                  CustomerRequestCreateResponse.fromJson(data)).toList();
              if(response!=null && response.length>0 && response[0].condition=='True'){
                isLoading.value=false;
                customer_req_create_list.value=response;
                Utils.sanckBarSuccess('Success',customer_req_create_list[0].message.toString());
                resetAllFields();
               // flag.value="Update";
                request_no.value=customer_req_create_list[0].requestNo!;
                //viewCustomerApiHitListDetails(request_no.value);
              //  viewRequestDetails(customer_req_create_list);
                //viewCustomerApiHitListDetails(request_no.value);
               // getCustomerRequestList(status.value);
                //resetAllFields();
                print("Status...${status.value}");
                getCustomerRequestList(status.value);
                Get.toNamed(RoutesName.customerRequestList);
              }else{
                isLoading.value=false;
                Utils.sanckBarError('Error',customer_req_create_list[0].message.toString());
                customer_request_list.value=[];
              }
            }
          },).onError((error, stackTrace) {
            print(error);
            customer_request_list.value=[];
          },);

        }catch(e){
          print(e);
          isLoading.value=false;
          customer_request_list.value=[];
        }
      }
    }
    getCustomerType(){
      try{
        Map<String, String> data = {
        };
        isLoading.value=true;
        _api.getCustomerType(data, sessionManagement).then((value){
          try {
            final jsonResponse = json.decode(value);
            if (jsonResponse is List) {
              List<CustomerTypeResponse> response =
              jsonResponse.map((data) => CustomerTypeResponse.fromJson(data)).toList();
              if (response[0].condition == 'True') {
                isLoading.value=false;
                print('response of header line list $response');
                Customer_type_list.value = response;
                print(Customer_type_list[0].customerType);

              } else {
                isLoading.value=false;
                Customer_type_list.value = [];
                //Utils.sanckBarError('False Message!', response[0].message.toString());
              }
            } else {
              isLoading.value=false;
              Customer_type_list.value = [];
              Utils.sanckBarError('API Response', jsonResponse);
              print(jsonResponse);
            }
          } catch (e) {
            isLoading.value=false;
            Customer_type_list.value = [];
            print(e);
            Utils.sanckBarError('Exception!',e.toString() );
          }
        }).onError((error, stackTrace) {
          Utils.sanckBarError('API Error',error.toString() );
          print(error);
        });
      }catch(e){
        print(e);
      }
    }

    getVendarType(){
      try{
        Map<String, String> data = {
        };
        isLoading.value=true;
        _api.getVenderType(data, sessionManagement).then((value){
          try {
            final jsonResponse = json.decode(value);
            if (jsonResponse is List) {
              List<VendarTypeResponse> response =
              jsonResponse.map((data) => VendarTypeResponse.fromJson(data)).toList();
              if (response[0].condition == 'True') {
                isLoading.value=false;
                print('response of header line list $response');
                vender_type_list.value = response;
                print(vender_type_list[0].vendorType);
                // Get.toNamed(RoutesName.seedDispatchLineCreate);

              } else {
                isLoading.value=false;
                vender_type_list.value = [];
                //Utils.sanckBarError('False Message!', response[0].message.toString());
              }
            } else {
              isLoading.value=false;
              vender_type_list.value = [];
              Utils.sanckBarError('API Response', jsonResponse);
              print(jsonResponse);
            }
          } catch (e) {
            isLoading.value=false;
            vender_type_list.value = [];
            print(e);
            Utils.sanckBarError('Exception!',e.toString() );
          }
        }).onError((error, stackTrace) {
          Utils.sanckBarError('API Error',error.toString() );
          print(error);
        });
      }catch(e){
        print(e);
      }
    }

    getState(){
      try{
        Map<String, String> data  = {};
        _api.StateListApiHit(data, sessionManagement).then((value) {
          isLoading.value=true;
          try {
            final jsonResponse = json.decode(value);
            if (jsonResponse is List) {
              List<StateModel> response =
              jsonResponse.map((data) => StateModel.fromJson(data)).toList();
              if (response[0].condition == 'True') {
                isLoading.value=false;
                state_list.value = response;
                // getOrganizers();

              } else {
                isLoading.value=false;
                state_list.value = [];
              }
            } else {
              isLoading.value=false;
              state_list.value = [];
              Utils.sanckBarError('API Response', jsonResponse);
            }
          } catch (e) {
            isLoading.value=false;
            state_list.value = [];
            printError();
          }
        }).onError((error, stackTrace) {
          isLoading.value=false;
          Utils.sanckBarError('API Error',error.toString() );
          print(error);
          state_list.value = [];
        });
      }catch(e){
        print(e);
      }




    }


    customerRequestUpdate(){
      try{
        Map<String , String > data ={
          "request_no":request_no.value ,
          "name": name_controller.value.text,
          "address": address_controller.value.text,
          "contact": contact_controller.value.text,
          "phone_no": contact_no_controller.value.text,
          "sales_person_code": sale_person_controller.value.text,
          "country_region_code":'IN',
          "post_code": post_code_controller.value.text,
          "email":email_controller.value.text,
          "mobile_phone_no": mobile_no_controller.value.text,
          "gst_registraction_no":registration_no_controller.value.text,
          "gst_registraction_type": registration_type_controller.value.text,
          "gst_customer_type": gst_customer_type_controller.value.text,
          "pan_no": pan_no_controller.value.text,
          "state_code": StateCode,
          "zone": zone_controller.value.text,
          "district": district_controller.value.text,
          "region": reagion_controller.value.text,
          "taluka": taluka_controller.value.text,
          "customer_type": customer_type_controller.value.text,
          "vendor_type": vendor_type_controller.value.text,
          "territory_type": territory_type_controller.value.text,
          "seed_license_no":seed_licence_controller.value.text,
          "created_by": email.toString()
        };
        isLoading.value=true;
        _api.CustomerRequestUpdateHitApi(data, sessionManagement).then((value) {
          print(value);
          final JsonResponse=json.decode(value);
          if(JsonResponse is List){
            List<CustomerRequestCreateResponse> response=JsonResponse.map((data) =>
                CustomerRequestCreateResponse.fromJson(data)).toList();
            if(response !=null && response.length>0 && response[0].condition =="True"){
              isLoading.value=false;
              customer_req_create_list.value=response;
              Utils.sanckBarSuccess('Success',customer_req_create_list[0].message.toString());
              /*Get.toNamed(RoutesName.customerRequestList);
              getCustomerRequestList(status.value);*/
              /*if(flag.value=="Update"){
                resetAllFields();;
              }*/

            }else{
              isLoading.value=false;
              Utils.sanckBarError("Error", response[0].message.toString());
            }
          }

        },).onError((error, stackTrace) {
          isLoading.value=false;
          print(error);

        },);
      }catch(e){
        print(e);
      }
    }

    customerRequestComplete(){
      try{
        Map<String, String> data ={
          "request_no": request_no.value,
          "email_id": email.toString()
        };
        isLoading.value=true;
        _api.CustomerRequestCompleteHitApi(data, sessionManagement).then((value) {
          final jsonResponse=json.decode(value);
          if(jsonResponse is List){
            List<CustomerRequestCreateResponse> response=jsonResponse.map((e) =>
                CustomerRequestCreateResponse.fromJson(e) ).toList();
            if(response!=null && response.length>0 && response[0].condition=="True"){
              isLoading.value=false;
              name_controller.clear();
              Utils.sanckBarSuccess("Message", response[0].message.toString());
              Get.toNamed(RoutesName.customerRequestList);
              getCustomerRequestList(status.value);
            }else{
              isLoading.value=false;
              Utils.sanckBarError("Error", response[0].message.toString());
            }
          }
        },).onError((error, stackTrace) {
          isLoading.value=false;
          print(error);
        },);
      }catch(e){
        print(e);
      }
    }



    viewRequestDetails(List<CustomerRequestCreateResponse> response){
      if(flag=="Update" || flag=="View" ){
        //customer_req_create_imageList.add(customer_request_list);
        //Get.toNamed(RoutesName.customerRequestCreate);
        name_controller.text=response[0].name!;
        address_controller.text=response[0].address!;
        contact_controller.text=response[0].contact!;
        contact_no_controller.text=response[0].phoneNo!;
        sale_person_controller.text=response[0].salesPersonCode!;
        customer_type_controller.text=response[0].customerType!;
        vendor_type_controller.text=response[0].vendorType!;
        state_code_controller.text=response[0].stateName!;
        StateCode=response[0].stateCode.toString();
       // state_code_controller.text=StateName;
       //state_code_controller.text=StateName;
        country_region_controller.text=response[0].countryRegionCode!;
        post_code_controller.text=response[0].postCode!;
        email_controller.text=response[0].email!;
        mobile_no_controller.text=response[0].mobilePhoneNo!;
        registration_no_controller.text=response[0].gstRegistractionNo!;
        registration_type_controller.text=response[0].gstRegistractionType!;
        gst_customer_type_controller.text=response[0].gstCustomerType!;
        pan_no_controller.text=response[0].panNo!;
        zone_controller.text=response[0].zone!;
        district_controller.text=response[0].district!;
        reagion_controller.text=response[0].region!;
        taluka_controller.text=response[0].taluka!;
        territory_type_controller.text=response[0].territoryType!;
        seed_licence_controller.text=response[0].seedLicenseNo!;
      }
    }


  /*  void showLineImagesPopup(BuildContext context) {
      Size size = Get.size;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          selectedImageUrls=[];
          imageUrls = [];
          print(selectedImageUrls.length);
          try{
            if(customer_req_deatails_list[0].headerImages!.isNotEmpty){
              for(int i=0;i<customer_req_deatails_list[0].headerImages!.length;i++){
                imageUrls.add(customer_req_deatails_list[0].headerImages![i]!.fileUrl!);
                selectedImageUrls.add(customer_req_deatails_list[0].headerImages![i]!.fileUrl!);
              }
              uploadImageFlag ='urlimage';
            }else{
              print("Urlll.....Image....${upLoadLocalImagesList}");
              imageUrls.addAll(upLoadLocalImagesList);
              selectedImageUrls.addAll(upLoadLocalImagesList);
              uploadImageFlag='localimage';

            }
            if(uploadImageFlag=='urlimage'){
              buttonText='Discard';
              print("fbdhgbdfgbdfgbbfdj");
            }
            else if( uploadImageFlag=='localimage'){
              buttonText='Upload';
            }
          }catch(e){
            print("Exception.....");
            print(e);
          }
          return Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    title: Text('Customer Images', style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.sisxteen,
                        fontWeight: FontWeight.w700
                    ),),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: [
                      Row(
                        children: [
                         Visibility(
                            visible: status.value=="Completed"?false:true,
                            child: Container(
                              //padding: EdgeInsets.only(right: 0,bottom: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ActionChip(
                                    elevation: 2,
                                    padding: EdgeInsets.all(0),
                                    backgroundColor: AllColors.primaryDark1,
                                    shadowColor: Colors.black,
                                    shape: StadiumBorder(
                                        side: BorderSide(color: AllColors.primaryliteColor)),
                                    label: Text( buttonText,
                                        style: GoogleFonts.poppins(
                                          color: AllColors.customDarkerWhite,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    onPressed: () {
                                      if(buttonText=="Upload"){
                                        upLoadImageApi(context);
                                      }else{
                                        disCardImageApi(context);
                                      }

                                    }, //Text
                                  ),],

                              ),
                            ),
                          ),

                          IconButton(
                            icon: Icon(Icons.cancel, color: AllColors.primaryDark1,),
                            onPressed: () {
                              // Get.toNamed(RoutesName.eventLineDetail);
                              Navigator.of(context).pop(); // Dismiss the dialog
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Obx(() {
                    return Visibility(
                      visible: isLoading.value,
                      child: LinearProgressIndicator(
                        backgroundColor: AllColors.primaryDark1,
                        color: AllColors.primaryliteColor,
                      ),
                    );
                  }),
                  Divider(
                    height: 2,
                    color: AllColors.primaryliteColor,
                  ),
                  SizedBox(height: 10),
                  Visibility(
                   visible: buttonText=="Discard" || status.value=="Completed"?false:true,
                    child: Container(
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                             upLoadImage(context);
                          },
                          child: Column(
                              children: [DottedBorder(
                                color: AllColors.primaryDark1,
                                strokeWidth: 2,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(8),
                                dashPattern: [20, 10, 20, 10],
                                child: Container(
                                  width: size.height * 0.1,
                                  height: size.height * 0.1,
                                  child: Icon(Icons.camera_alt_outlined,color: AllColors.primaryDark1,size: size.height * 0.1,),
                                ),
                              ),
                                SizedBox(height: 10,),
                                Text('Capture Image', style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twentee,
                                    fontWeight: FontWeight.w700
                                ),)]
                          ),
                        ),
                      ),
                    ),
                  ),
                  selectedImageUrls.isEmpty && status.value=='Completed'?Text('No Image Found' ,style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700
                  )):
                  Visibility(
                    visible:selectedImageUrls.isEmpty?false:true,
                    child: Obx((){
                      return
                        Container(
                          width: size.width * .98,
                          height: size.height * .5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: AllColors.primaryliteColor, width: .5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: upLoadBigImageSection(selectedImageUrls[selectedindex.value],uploadImageFlag),
                          ),
                        );
                    }),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                            child: Divider(color: AllColors.primaryliteColor, height: 1,),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: imageUrls.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    _handleImageTap(index);
                                  },
                                  child: Container(
                                    width: 100,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.blueGrey, width: 0.5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: upLoadImageSection(imageUrls[index], uploadImageFlag),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }*/


    void showLineImagesPopup(BuildContext context) {
      Size size = Get.size;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          selectedImageUrls = [];
          imageUrls = [];
          print(selectedImageUrls.length);
          try {
            if (customer_req_deatails_list[0].headerImages!.isNotEmpty) {
              for (int i = 0; i < customer_req_deatails_list[0].headerImages!.length; i++) {
                imageUrls.add(customer_req_deatails_list[0].headerImages![i]!.fileUrl!);
                selectedImageUrls.add(customer_req_deatails_list[0].headerImages![i]!.fileUrl!);
              }
              uploadImageFlag = 'urlimage';
            } else {
              imageUrls.addAll(upLoadLocalImagesList);
              selectedImageUrls.addAll(upLoadLocalImagesList);
              uploadImageFlag = 'localimage';
            }
            if (uploadImageFlag == 'urlimage') {
              buttonText = 'Discard All';
            } else if (uploadImageFlag == 'localimage') {
              buttonText = 'Upload';
            }
          } catch (e) {
            print(e);
          }
          return Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    title: Text(
                      'Customer Images',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.sisxteen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: [
                      Row(
                        children: [
                          Visibility(
                            visible: status.value == "Completed" ? false : true,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ActionChip(
                                    elevation: 2,
                                    padding: EdgeInsets.all(0),
                                    backgroundColor: AllColors.primaryDark1,
                                    shadowColor: Colors.black,
                                    shape: StadiumBorder(side: BorderSide(color: AllColors.primaryliteColor)),
                                    label: Text(
                                      buttonText,
                                      style: GoogleFonts.poppins(
                                        color: AllColors.customDarkerWhite,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (buttonText == "Upload") {
                                        upLoadImageApi(context);
                                      } else {
                                        disCardImageApi(context);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.cancel, color: AllColors.primaryDark1),
                            onPressed: () {
                              Navigator.of(context).pop(); // Dismiss the dialog
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Obx(() {
                    return Visibility(
                      visible: isLoading.value,
                      child: LinearProgressIndicator(
                        backgroundColor: AllColors.primaryDark1,
                        color: AllColors.primaryliteColor,
                      ),
                    );
                  }),
                  Divider(
                    height: 2,
                    color: AllColors.primaryliteColor,
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: buttonText == "Discard All" || status.value == "Completed" ? false : true,
                    child: Container(
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            upLoadImage(context);
                          },
                          child: Column(
                            children: [
                              DottedBorder(
                                color: AllColors.primaryDark1,
                                strokeWidth: 2,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(8),
                                dashPattern: [20, 10, 20, 10],
                                child: Container(
                                  width: size.height * 0.1,
                                  height: size.height * 0.1,
                                  child: Icon(Icons.camera_alt_outlined, color: AllColors.primaryDark1, size: size.height * 0.1),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Capture Image',
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.twentee,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: selectedImageUrls.isEmpty ? false : true,
                    child: Obx(() {
                      return Container(
                        width: size.width * .98,
                        height: size.height * .5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: AllColors.primaryliteColor, width: .5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: upLoadBigImageSection(selectedImageUrls[selectedindex.value], uploadImageFlag),
                        ),
                      );
                    }),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                            child: Divider(color: AllColors.primaryliteColor, height: 1),
                          ),
                          SizedBox(height: 10),
                          // Check if imageUrls is empty, display a message, else display images
                          imageUrls.isEmpty
                              ? Center(
                                child:Text( 'No Images found',
                                    style:GoogleFonts.poppins(
                                      fontSize: AllFontSize.eighteen,
                                      fontWeight: FontWeight.w700,
                                      color: AllColors.primaryDark1
                                    ),
                                 ),
                              )
                              : Container(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: imageUrls.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    _handleImageTap(index);
                                  },
                                  child: Container(
                                    width: 100,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.blueGrey, width: 0.5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: upLoadImageSection(imageUrls[index], uploadImageFlag),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }




    void _handleImageTap(int index) {
      selectedindex.value = index;
    }
    Future upLoadImage(BuildContext context) async {
      var image = null;
      try {
        image = await _picker_checkout.pickImage(source: ImageSource.camera, imageQuality: 60);
        upLoadLocalImagesList.add(image.path.toString());
        Navigator.of(context).pop();
        showLineImagesPopup(context);
        // upLoadImageSection(upLoadLocalImagesList.length-1, image.path);
        print('image path from list...........${upLoadLocalImagesList}');
      } catch (e) {
        //Utils.sanckBarError("Image Exception!", e.toString());
      }
    }
    Widget upLoadImageSection(String? path, String? flag) {
      if (flag=='localimage') {
        return ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Image.file(
            File(path.toString()),
            fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
          ),
        );
      } else if (flag=='urlimage') {
        return ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Image.network(
            path.toString(),
            fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
          ),
        );
      } else {
        return Icon(
          Icons.camera,
          size: 40,
          color: AllColors.primaryDark1,
        );
      }
    }

 Widget upLoadBigImageSection(String? path, String? flag) {
      if (flag=='localimage') {
        print("Path.........${path}");
        return ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Image.file(
            File(path.toString()),

            fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
          ),
        );
      } else if (flag=='urlimage') {
        return ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Image.network(
            (path!=null && path.isNotEmpty)
                ? imageUrls[selectedindex.value]
                : 'https://dev4.pristinefulfil.com/assets/images/vendor_panel_img/mylogo.png',
          //  path.toString(),
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child; // Return the image if it's fully loaded
              } else {
                return Center(
                  child: CircularProgressIndicator(color: AllColors.primaryDark1), // Show a progress indicator while loading
                );
              }
            },
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              // return Center(child: Text('Failed to load image'),
              return Container(child: Image.asset("assets/images/no_file.png"));
            },

            // Use BoxFit.cover to make the image fit
          ),
        );
      } else {
        return Icon(
          Icons.camera,
          size: 40,
          color: AllColors.primaryDark1,
        );
      }
    }

    viewCustomerApiHitListDetails(String requestno){
      try{
        Map<String, String > data ={
          "request_no": requestno.toString(),
        };
        isLoading.value=true;
        _api.createCustomerRequestHitApi(data, sessionManagement).then((value) {
          print(value);
          final JsonResponse=json.decode(value);
          if(JsonResponse is List){
            List<CustomerRequestCreateResponse> response=JsonResponse.map((data) =>
                CustomerRequestCreateResponse.fromJson(data)).toList();
            if(response !=null && response.length>0 && response[0].condition =="True"){
              isLoading.value=false;
            /*  if(flag=="Update"){
                Get.toNamed(RoutesName.customerRequestCreate);
              }*/
              Get.toNamed(RoutesName.customerRequestCreate);
              print("Stetsus..........${status.value}");
              customer_req_deatails_list.value=response;
             viewRequestDetails(response);

             // Utils.sanckBarSuccess('Success',customer_req_create_list[0].message.toString());
              //  Utils.sanckBarSuccess("Success", response[0].message.toString());
              //Get.toNamed(RoutesName.customerRequestList);
              //  getCustomerRequestList();

            }else{
              isLoading.value=false;
             // Utils.sanckBarError("Error", response[0].message.toString());
            }
          }

        },).onError((error, stackTrace) {
          isLoading.value=false;
          print(error);

        },);
      }catch(e){

      }
    }

     Future<void>upLoadImageApi(BuildContext context) async  {
     try{
       final server_uri = Uri.parse(AppUrl.eventUploadImage);
       final clint_request = http.MultipartRequest('POST', server_uri);
       var fields = <String, String>{
         "process_type":'CustomerRequest',
         "document_no": request_no.value,
       };

       clint_request.fields.addAll(fields);
       for(int i=0;i<upLoadLocalImagesList.length;i++){
         clint_request.files.add(await http.MultipartFile.fromPath(
             'files',
             upLoadLocalImagesList[i].toString()));
         print(upLoadLocalImagesList[i]);
       }
       isLoading.value = true;

       _api_upload_discard.eventManagementExpenseInsert(clint_request, sessionManagement).then((value) {
         print(value);
         final jsonResponse = json.decode(value);
         if (jsonResponse is List) {
           List<CustomerRequestCreateResponse> response_data =
           jsonResponse.map((data) => CustomerRequestCreateResponse.fromJson(data)).toList();

           if (response_data!=null && response_data.length >0 && response_data[0].condition == 'True') {
             isLoading.value = false;
             imageUrls=[];
             selectedImageUrls=[];
             upLoadLocalImagesList.value=[];
             viewCustomerApiHitListDetails(request_no.value);
             Navigator.of(context).pop();
             Utils.sanckBarSuccess('Message!', response_data[0].message.toString());
           } else {
             print("Errror.....${response_data[0].message}");
             isLoading.value = false;
             Utils.sanckBarError('False Message!', response_data[0].message.toString());
           }

         } else {

           isLoading.value = false;
           Utils.sanckBarError(
               'API Error',
               jsonResponse["message"] == null
                   ? 'Invalid response format'
                   : jsonResponse["message"]);
         }
       }).onError((error, stackTrace) {
         print(error);
         isLoading.value = false;
         Utils.sanckBarError('Error!', "Api Response Error");
       });
     }catch(e){
       print(e);

     }
    }

    disCardImageApi(BuildContext context){
      print("Requesttttttttt......."+request_no.value);
      Map<String, String> data={
        "process_type": "CustomerRequest",
        "document_no": request_no.value
      };

      try{
        isLoading.value=true;
        _api_upload_discard.imageDiscardApi(data, sessionManagement).then((value) {
          print(value);
          final jsonResponse=json.decode(value);

          if(jsonResponse is List){
            List<CustomerRequestCreateResponse> response=jsonResponse.map((e) =>
                CustomerRequestCreateResponse.fromJson(e)).toList();
            if(response!=null && response.length>0 && response[0].condition=="True"){
              isLoading.value=false;
              imageUrls=[];
              selectedImageUrls=[];
              upLoadLocalImagesList.value=[];
              Utils.sanckBarSuccess("Success Message", response[0].message.toString());
              viewCustomerApiHitListDetails(request_no.value);
              Navigator.of(context).pop();
            }else{
              isLoading.value=false;
              print("Else");
              Utils.sanckBarError("False Messsge",response[0].message.toString());
            }
          }
        },).onError((error, stackTrace) {
          isLoading.value=false;
          print(error);
        },);
      }catch(e){
        print(e);
      }
    }



    getCustomerApparverList(){
      Map<String, String> data={
          "email": email,
          "filter_date": filter_date_controller.text.isNotEmpty?filter_date_controller.text:"",
          "filter_created_by": employee_name_controller.text.isNotEmpty?employee_name_controller.text:"",
          "approve_status": selection_type
      };
      print(data);
      isLoading.value=true;
      try{
        _api.CustomerRequestApperverHitApi(data, sessionManagement).then((value) {
          final JsonResponse = json.decode(value);
          if (JsonResponse is List) {
            List<CustomerRequestApproverResponse> response = JsonResponse.map((
                e) =>
                CustomerRequestApproverResponse.fromJson(e)).toList();
            if (response != null && response.length > 0 && response[0].condition == "True") {
              isLoading.value = false;
              customer_request_approver_list.value=response;
              pending_count.value=response[0].pendingCount!;
              approvel_count.value=response[0].approvedCount!;
              rejected_count.value=response[0].rejectedCount!;
              print("fdgbfngbfbgnfbgbfmngnmd......."+pending_count.value);
              print(response);

            } else {
              isLoading.value = false;
              customer_request_approver_list.value=[];
              pending_count.value=response[0].pendingCount!;
              approvel_count.value=response[0].approvedCount!;
              rejected_count.value=response[0].rejectedCount!;
              print(response.toString());

            }
          }
        },).onError((error, stackTrace) {
            isLoading.value = false;
            customer_request_approver_list.value=[];
              print(error);


        },).whenComplete(() {
          isLoading.value = false;
        },);
      }catch(e){
        print(e);
        customer_request_approver_list.value=[];
        isLoading.value = false;
        pending_count.value="0";
       approvel_count.value="0";
        rejected_count.value="0";
      }
    }

    getEmployeeMasterApi(String filter_login) {
      isLoading.value = true;
      Map data = {'email_id': email};
      _api.getEmployeeTeamEmail(data, sessionManagement).then((value) {
        try {
          List<EmpMasterResponse> emp_masterResponse =
          (json.decode(value) as List)
              .map((i) => EmpMasterResponse.fromJson(i))
              .toList();
          if (emp_masterResponse!=null && emp_masterResponse.length>0 && emp_masterResponse[0].condition== "True") {
            isLoading.value = false;
            employess_List.value = emp_masterResponse;
          } else {
            isLoading.value = false;
            employess_List.value = [];
          }
        } catch (e) {
          isLoading.value = false;
          employess_List.value = [];
        }
      }).onError((error, stackTrace) {
        employess_List.value = [];
        Utils.sanckBarError('Api Exception onError', error.toString());
      }).whenComplete(() {
        isLoading.value = false;
        getCustomerApparverList();
      });
    }


    void markApproveReject(String request_no, String remark, String status) {
       isLoading.value = true;
      Map<String, String> data = {
        "request_no": request_no,
        "status":status,
        "approve_remark":remark.isEmpty? "":remark,
        "email_id": email
      };
      _api.customerRejectedApproveApiHit(data, sessionManagement).then((value) {
        try {
          List<ProductOnGroundApproveRejectModal> emp_masterResponse =
          (json.decode(value) as List)
              .map((i) => ProductOnGroundApproveRejectModal.fromJson(i))
              .toList();
          if (emp_masterResponse!=null && emp_masterResponse.length>0 && emp_masterResponse[0].condition == "True") {
            isLoading.value = false;
            Utils.sanckBarSuccess('Success', emp_masterResponse[0].message.toString());

          } else {
            Utils.sanckBarError('False Message!', emp_masterResponse[0].message.toString());
            isLoading.value = false;
          }
        } catch (e) {
          isLoading.value = false;
          print(e);
          Utils.sanckBarError('Exception!', e.toString());
        }
      }).onError((error, stackTrace) {
        isLoading.value = false;
        Utils.sanckBarError('Api Exception onError', error.toString());
      });
    }




    resetAllFields(){
      name_controller.clear();
      address_controller.clear();
      contact_controller.clear();
      contact_no_controller.clear();
      sale_person_controller.clear();
      customer_type_controller.clear();
      vendor_type_controller.clear();
      state_code_controller.clear();
      country_region_controller.clear();
      post_code_controller.clear();
      email_controller.clear();
      mobile_no_controller.clear();
      registration_no_controller.clear();
      registration_type_controller.clear();
      gst_customer_type_controller.clear();
      pan_no_controller.clear();
      zone_controller.clear();
      district_controller.clear();
      reagion_controller.clear();
      taluka_controller.clear();
      territory_type_controller.clear();
      seed_licence_controller.clear();
      isDropDown.value=false;
      isDropDown.value=true;
    }



    /*getSalesPerson(){
      try{
        Map<String, String> data  = {
          "code": "",
          "name": "",
          "row_per_page": "10",
          "page_number": "0"
        };
        _api.getSalePerson(data, sessionManagement).then((value) {
          print(value);
          isLoading.value=true;
          try {
            final jsonResponse = json.decode(value);
            if (jsonResponse is List) {
              List<SalePersonResponse> response =
              jsonResponse.map((data) => SalePersonResponse.fromJson(data)).toList();
              if (response[0].condition == 'True') {
                isLoading.value=false;
                sale_person_list.value = response;
                // getOrganizers();

              } else {
                print('False.....' );
                isLoading.value=false;
                sale_person_list.value = [];
              }
            } else {
              isLoading.value=false;
              sale_person_list.value = [];
              Utils.sanckBarError('API Response', jsonResponse);
            }
          } catch (e) {
            print(e);
            isLoading.value=false;
            sale_person_list.value = [];
            printError();
          }
        }).onError((error, stackTrace) {
          isLoading.value=false;
          Utils.sanckBarError('API Error',error.toString() );
          print(error);
          sale_person_list.value = [];
        });
      }catch(e){

      }

    }*/



    Future<Iterable<SalePersonResponse>> searchSalePerson(String text) async {

      if (text == '') {
        return const Iterable<SalePersonResponse>.empty();
      }
      Map<String, String> data  = {
        "code": "",
        "name": text,
        "row_per_page": "10",
        "page_number": "0"
      };


      String salePerson =await   _api.getSalePerson(data, sessionManagement);
      try {
        final jsonResponse = json.decode(salePerson);

        if (jsonResponse is List) {
          print(jsonResponse);
          List<SalePersonResponse> response =
          jsonResponse.map((data) => SalePersonResponse.fromJson(data)).toList();
          print('condition..'+response[0].condition.toString());
          if (response[0].condition == 'True') {
            print(jsonResponse);
            sale_person_list.value = response;

          } else {
            Utils.sanckBarException('False!', response[0].message!);
            sale_person_list.value= [];
          }
        } else {
          Utils.sanckBarException('False!', jsonResponse.message);
          sale_person_list.value = [];
        }
      } catch (e) {
        Utils.sanckBarException('Exception!', e.toString());
        sale_person_list.value = [];
      }
      return    sale_person_list.value;
    }
}