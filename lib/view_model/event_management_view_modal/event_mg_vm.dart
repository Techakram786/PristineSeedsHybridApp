import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';
import 'package:http/http.dart' as http;
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../models/event_management_modal/event_header_line_modal.dart';
import '../../models/event_management_modal/event_type_modal.dart';
import '../../models/event_management_modal/get_event_management_modal.dart';
import '../../models/orders/customers_model.dart';
import '../../models/seed_dispatch/item_category_mst_get_modal.dart';
import '../../models/seed_dispatch/item_group_category_modal.dart';
import '../../repository/event_management_repo/Event_management_repo.dart';
import '../../repository/seed_dispatch_repository/seed_dispatch_create_repo.dart';
import '../../resourse/appUrl/app_url.dart';
import '../../utils/app_utils.dart';
import '../session_management/session_management_controller.dart';

class EventManagementViewModal extends GetxController{
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading = false.obs;
  RxBool reset_field_ui=false.obs;
  RxBool complete_field=false.obs;
  RxBool isShowDocDropDown=true.obs;

  final _api = EventManagementRepository();
  final _api_plant = seedDispatchCreationRepository();
  RxList<EventManagementGetModal> event_mng_get_list = <EventManagementGetModal>[].obs;
  RxList<EventTypeModal> enent_type_list = <EventTypeModal>[].obs;
  RxList<ItemCategoryMstGetModal> item_ctg_mstget_list = <ItemCategoryMstGetModal>[].obs;
  RxList<ItemGroupCategory> item_group_ctg__list = <ItemGroupCategory>[].obs;
  RxList<CustomersModel> farmer_list = <CustomersModel>[].obs;
  RxList<EventHeaderLineMngModal> event_line_header_list = <EventHeaderLineMngModal>[].obs;

  Rx<ItemCategoryMstGetModal> selected_category=new ItemCategoryMstGetModal().obs;
  Rx<ItemGroupCategory> selected_group_category=new ItemGroupCategory().obs;
  Rx<EventTypeModal> selected_event_type=new EventTypeModal().obs;
  Rx<CustomersModel> selected_farmer_code=new CustomersModel().obs;



  String email_id = "";
  //todo for pagination....................
  ScrollController scrollController = ScrollController();
  int total_rows=0;
  int pageNumber=0;
  int rowsPerPage=10;
  RxDouble total=0.0.obs;
  RxDouble Amount=0.0.obs;
  RxString status = "Pending".obs;
  //RxString status = "0".obs;

  //todo for header
  var date_controller = TextEditingController();
  var desc_controller = TextEditingController();
  var event_type_controller = TextEditingController();
  var budget_controller = TextEditingController();
  var item_category_code_controller = TextEditingController();
  var item_group_code_controller = TextEditingController();
  var farmer_code_controller = TextEditingController();
  var expected_farmer_controller = TextEditingController();
  var expected_dealer_controller = TextEditingController();
  var expected_distributer_controller = TextEditingController();
  var cover_villages_controller = TextEditingController();
  var expenseController = TextEditingController();


  //todo for searching
  RxString current_date = "".obs;
  var event_code_controller = TextEditingController();

  var actual_farmers_controller = TextEditingController();
  var actual_dealers_controller = TextEditingController();
  var actual_distributers_controller = TextEditingController();

  RxBool isAddExpense = false.obs;
  RxInt isExpend_line_posion = (-1).obs;
  RxBool isExpend = false.obs;
  int expense_current_index = -1.obs;
  final ImagePicker _picker = ImagePicker();
  RxString inFront_image_path = ''.obs;
  final ImagePicker _picker_checkout = ImagePicker();
  RxString outFront_image_path = ''.obs;
  RxBool isImageSet = true.obs;

  Future eventMngGetRefressUi(String s) async{
    status.value=s;
    pageNumber=0;
    total_rows=0;
    event_mng_get_list.value=[];
    eventMngHeaderGet(pageNumber);

  }
  eventMngHeaderGet(int pageNumber){
    print("hi..........event");
    Map data = {
      "filter_email_id": "",
      "event_code": event_code_controller.text.isNotEmpty ? event_code_controller.text:'',
      "event_date":  date_controller.text.isNotEmpty ? date_controller.text:'',
      "event_type": event_type_controller.text.isNotEmpty ? event_type_controller.text:'',
      "item_category_code": item_category_code_controller.text.isNotEmpty ? item_category_code_controller.text:'',
      "item_group_code": item_group_code_controller.text.isNotEmpty ? item_group_code_controller.text:'',
      "farmer_code": farmer_code_controller.text.isNotEmpty ? farmer_code_controller.text:'',
      "rowsPerPage": 10,
      "pageNumber": pageNumber,
      "status": status.value.isEmpty?'':status.value,
      "email":email_id
    };
    loading.value=true;
    _api.eventManagementGet(data, sessionManagement).then((value){
      print("Radhhaaa-----------${value}");
      try{
        final jsonResponse = json.decode(value);
        if( jsonResponse is List){
          List<EventManagementGetModal> response = jsonResponse.map((data) => EventManagementGetModal.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value=false;
          //  Utils.sanckBarSuccess('Success Message!', response[0].toString());
            print("we get response successfully");
            this.isAddExpense.value = false;
            this.isAddExpense.value = true;
            this.isExpend.value=false;
            List<EventManagementGetModal> my_current_list=[];
            my_current_list.addAll(response);
            event_mng_get_list.value=[];
            event_mng_get_list.value=my_current_list;
            print('length of list ${event_mng_get_list.length}');
            total_rows=int.parse(response[0].totalrows!);

          } else {
            loading.value=false;
            event_mng_get_list.value = [];
            //Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        }
      }
      catch (e) {
        loading.value=false;
        event_mng_get_list.value = [];
        Utils.sanckBarError('Exception!',e.toString() );
      }
    });
  }
  getEventType(){
    enent_type_list.value = [];
    Map<String, String> data = {
      "email":email_id
    };
    loading.value=true;
    _api.getEventType(data, sessionManagement).then((value){
      print(value);
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<EventTypeModal> response = jsonResponse.map((data) => EventTypeModal.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value=false;
            enent_type_list.value = response;
            getItemCategoryMst();
            //getfarmerss();
            Get.toNamed(RoutesName.createEventMng);

          } else {
            loading.value=false;
            enent_type_list.value = [];
            //Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          loading.value=false;
          enent_type_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
          print(jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        enent_type_list.value = [];
        print(e);
        Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('API Error',error.toString() );
      print(error);
    });
  }
  getItemCategoryMst(){
    item_ctg_mstget_list.value = [];
    Map<String, String> data = {
    };
    loading.value=true;
    _api_plant.getItemCategory(data, sessionManagement).then((value){
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ItemCategoryMstGetModal> response =
          jsonResponse.map((data) => ItemCategoryMstGetModal.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value=false;
            item_group_ctg__list.value=[];
            print('response of header line list $response');
            item_ctg_mstget_list.value = response;
            print(item_ctg_mstget_list[0].categoryCode);


          } else {
            loading.value=false;
            item_ctg_mstget_list.value = [];
            //Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          loading.value=false;
          item_ctg_mstget_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
          print(jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        item_ctg_mstget_list.value = [];
        print(e);
        Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('API Error',error.toString() );
      print(error);
    });
  }
  getGroupItemCategory(String category_code){
    item_group_ctg__list.value = [];
    Map<String, String> data = {
      "category_code": category_code
    };
    loading.value=true;
    _api_plant.getItemGroupCategory(data, sessionManagement).then((value){
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ItemGroupCategory> response =
          jsonResponse.map((data) => ItemGroupCategory.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value=false;
            print('response of header line list $response');
            item_group_ctg__list.value = response;
            print(item_group_ctg__list[0].groupcode);
            //Get.toNamed(RoutesName.seedDispatchLineCreate);
          } else {
            loading.value=false;
            item_group_ctg__list.value = [];
            //Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          loading.value=false;
          item_group_ctg__list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
          print(jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        item_group_ctg__list.value = [];
        print(e);
        Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('API Error',error.toString() );
      print(error);
    });
  }


  createEventMng(String flag, String eventCode){
    Map data = {};
    if(flag =="create header"){
      String village = villageList.join(';');
      //print(village);
      if(date_controller.text.isEmpty){
        Utils.sanckBarError('Error : ', 'Please fill date.');
        return;
      }
      if(desc_controller.text.isEmpty){
        Utils.sanckBarError('Error : ', 'Please fill description.');
        return;
      }
      if(event_type_controller.text.isEmpty){
        Utils.sanckBarError('Error : ', 'Please Select Event type.');
        return;
      }
      if(budget_controller.text.isEmpty){
        Utils.sanckBarError('Error : ', 'Please fill budget');
        return;
      }
      if(item_category_code_controller.text.isEmpty){
        Utils.sanckBarError('Error : ', 'Please select category code.');
        return;
      }
     /* if(item_group_code_controller.text.isEmpty){
        Utils.sanckBarError('Error : ', 'Please select category code.');
        return;
      }*/
      if(farmer_code_controller.text.isEmpty){
        Utils.sanckBarError('Error : ', 'Please Select farmer code.');
        return;
      }

      if(expected_farmer_controller.text.isEmpty){
        Utils.sanckBarError('Error : ', 'Please fill expected farmer.');
        return;
      }
      if(villageList.isEmpty){
        Utils.sanckBarError('Error : ', 'Please enter minimum one village.');
        return;
      }
      if(expected_dealer_controller.text.isEmpty){
        Utils.sanckBarError('Error : ', 'Please fill expected dealer.');
        return;
      }

      if(expected_distributer_controller.text.isEmpty){
        Utils.sanckBarError('Error : ', 'Please fill expected distributer');
        return;
      }

      /*Map*/ data = {
        "email":email_id ,
        "event_desc": desc_controller.text,
        "event_date": date_controller.text,
        "event_type": event_type_controller.text,
        "event_budget": budget_controller.text,
        "item_category_code": item_category_code_controller.text,
        "item_group_code": item_group_code_controller.text,
        "farmer_code": farmer_code_controller.text,
        "expected_farmers": expected_farmer_controller.text,
        "expected_dealers": expected_dealer_controller.text,
        "expected_distributer": expected_distributer_controller.text,
        "event_cover_villages":village,
      };
    }
    else{
      /*Map */data = {
        "event_code": eventCode,
        "email": email_id,
      };
      //print('print event code...........${eventCode}');
    }

    loading.value=true;
    _api.eventManagementCreate(data, sessionManagement).then((value) {
      print(value);
      try {
        final jsonResponse = json.decode(value);

        if (jsonResponse is List) {
          List<EventHeaderLineMngModal> response =
          jsonResponse.map((data) => EventHeaderLineMngModal.fromJson(data)).toList();
          if (response.length>0 && response[0].condition == 'True') {
            Utils.sanckBarSuccess('Success Message!', response[0].message.toString());
            loading.value=false;
            event_line_header_list.value = response;

            print(response.toString());
            print('print event code...........${event_line_header_list[0].eventcode}');

            resetAllcreateMngFields();
            Get.toNamed(RoutesName.eventLineDetail);
          } else {
            loading.value=false;
            event_line_header_list.value = [];
            Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          loading.value=false;
          event_line_header_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
          print(jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        event_line_header_list.value = [];
        print(e);
        Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      Utils.sanckBarError('API Error Exception',error.toString() );
      print(error);
      event_line_header_list.value = [];
    });
  }

  @override
  void onInit() async {
    super.onInit();
    email_id = await sessionManagement.getEmail() ?? '';
    current_date.value=await StaticMethod.getCurrentData();
    initCurrentLocationLatLant();
    getEventType();
    print('email is $email_id');
    eventMngHeaderGet(pageNumber);
  }
  @override
  void onClose(){
    this.scrollController.dispose();
  }

  void resetAllcreateMngFields() {
    this.reset_field_ui.value=true;
    event_code_controller.clear();
    date_controller.clear();
    desc_controller.clear();
    event_type_controller.clear();
    budget_controller.clear();
    item_category_code_controller.clear();
    item_group_code_controller.clear();
    farmer_code_controller.clear();
    expected_farmer_controller.clear();
    expected_dealer_controller.clear();
    expected_distributer_controller.clear();
    cover_villages_controller.clear();
    villageList.value = [];
    this.reset_field_ui.value=false;
  }

  RxList<String> villageList = <String>[].obs;
  void updateVillageList(String village) {
    List<String> enteredVillages = village.split(',');
    enteredVillages = enteredVillages.map((village) => village.trim()).toList();
    enteredVillages.removeWhere((village) => village.isEmpty);
    villageList.addAll(enteredVillages);
  }

  void removeVillage(String village) {
    // Remove the specified village from the list
    villageList.remove(village);
  }
  eventMngComplete() {
    print('longitude---------${currentLng}');
    print('latitude---------${currentLat}');
    Map data = {
      "event_code": event_line_header_list[0].eventcode,
      "actual_farmers": event_line_header_list[0].actualfarmers,
      "actual_distributers": event_line_header_list[0].actualdistributers,
      "actual_dealers": event_line_header_list[0].actualdealers,
      "latitude": currentLat.value,
      "longitude": currentLng.value,
      "email": email_id
    };
    print("Event Code....${event_line_header_list[0].eventcode}");
    _api.eventManagementComplete(data, sessionManagement).then((value) {

      final jsonResponse = json.decode(value);
      if (jsonResponse is List) {
        List<EventHeaderLineMngModal> api_response =
        jsonResponse.map((data) => EventHeaderLineMngModal.fromJson(data)).toList();
        if (api_response[0].condition == 'True') {
          loading.value = false;
          Utils.sanckBarSuccess('Message!', api_response[0].message.toString());
          this.isAddExpense.value = false;
          this.isAddExpense.value = true;
          this.isExpend.value=false;
          eventMngHeaderGet(pageNumber);

          Get.toNamed(RoutesName.eventMngGetList);
          //event_line_header_list.value = [];
        } else {
          loading.value = false;
          Utils.sanckBarError(
              'False Message!', api_response[0].message.toString());
        }
      } else {
        loading.value = false;
        Utils.sanckBarError(
            'API Error',
            jsonResponse["message"] == null
                ? 'Invalid response format'
                : jsonResponse["message"]);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.sanckBarError('Error!', "Api Response Error");
    });
  }
  Future getFrontImage(String flag,String path) async {
    print("Check.....Flag.."+flag.toString());
    print("Check.....path.."+path.toString());
    var image = null;
    try {
       if (flag == 'Expense') {
        image = await _picker_checkout.pickImage(
            source: ImageSource.camera, imageQuality: 60);
        if (image != null) {
          if(path=='image_one'){
            //file_path1.value = image.path.toString();
              isImageSet.value=false;
            event_line_header_list[0].lines![expense_current_index]!.local_image_path1=image.path.toString();
            isImageSet.value=true;
            print("path,.,.,,,., ,.,.${event_line_header_list[0].lines![expense_current_index]?.local_image_path1}");
          }
          else if(path=='image_two'){
             isImageSet.value=false;
            event_line_header_list[0].lines![expense_current_index]?.local_image_path2=image.path.toString();
            isImageSet.value=true;
          }
          else if(path=='image_three'){
            isImageSet.value=false;
            event_line_header_list[0].lines![expense_current_index]?.local_image_path3=image.path.toString();
             isImageSet.value=true;
          }
          else if(path=='image_four'){
              isImageSet.value=false;
            event_line_header_list[0].lines![expense_current_index]?.local_image_path4=image.path.toString();

              isImageSet.value=true;
          }

          this.isAddExpense.value = false;
          this.isAddExpense.value = true;

        } else {
          Utils.sanckBarError(
              "Image Error!", "You have not select any front image");
        }
      }
    } catch (e) {
      Utils.sanckBarError("Image Exception!", e.toString());
    }
  }
  RxDouble totalAmount = 0.0.obs ;
  RxDouble quantity = 0.0.obs;

  RxBool setAmt=false.obs;

  //todo expense line submit data......................
  Future<void> expense_line_save_DataApi(String quantity, int? lineno, String? expensetype, String? eventcode)async {
    final server_uri = Uri.parse(AppUrl.eventManagementExpenseInsert);
    final clint_request = http.MultipartRequest('POST', server_uri);
    var fields = <String, String>{
      "event_code":eventcode.toString(),
      "line_no": lineno.toString(),
      "expense_type": expensetype.toString(),
      "quantity":expenseController.text,
      "email":email_id
    };
    clint_request.fields.addAll(fields);
    if (event_line_header_list[0]
        .lines![expense_current_index]
        ?.local_image_path1 !=
        null &&
        event_line_header_list[0]
            .lines![expense_current_index]
            ?.local_image_path1 !=
            '') {
      clint_request.files.add(await http.MultipartFile.fromPath(
          'image1',
          event_line_header_list[0]
              .lines![expense_current_index]
              !.local_image_path1
              .toString()));
      print("tthtjhtjhtjhfjhgf....."+event_line_header_list[0]
          .lines![expense_current_index]
      !.local_image_path1
          .toString());
    }
    if (event_line_header_list[0]
        .lines![expense_current_index]
        ?.local_image_path2!=
        null &&
        event_line_header_list[0]
            .lines![expense_current_index]
            ?.local_image_path2 !=
            '') {
      clint_request.files.add(await http.MultipartFile.fromPath(
          'image2',
          event_line_header_list[0]
              .lines![expense_current_index]
              !.local_image_path2
              .toString()));
    }
    if (event_line_header_list[0]
        .lines![expense_current_index]
        ?.local_image_path3 !=
        null &&
        event_line_header_list[0]
            .lines![expense_current_index]
            ?.local_image_path3 !=
            '') {
      clint_request.files.add(await http.MultipartFile.fromPath(
          'image3',
          event_line_header_list[0]
              .lines![expense_current_index]
              !.local_image_path3
              .toString()));
    }
    if (event_line_header_list[0]
        .lines![expense_current_index]
        ?.local_image_path4 !=
        null &&
        event_line_header_list[0]
            .lines![expense_current_index]
            ?.local_image_path4 !=
            '') {
      clint_request.files.add(await http.MultipartFile.fromPath(
          'image4',
          event_line_header_list[0]
              .lines![expense_current_index]
              !.local_image_path4
              .toString()));

    }
    print('Imagenfnfdbfdfjvbfjv'+event_line_header_list[0]
        .lines![expense_current_index]
    !.local_image_path1
        .toString());
    loading.value = true;
    //--hit api
    _api.eventManagementExpenseInsert(clint_request, sessionManagement).then((value) {
      final jsonResponse = json.decode(value);
      print("valueeeee...."+value);
      if (jsonResponse is List) {
        List<EventHeaderLineMngModal> response_data =
        jsonResponse.map((data) => EventHeaderLineMngModal.fromJson(data)).toList();

        if (response_data[0].condition == 'True') {
          event_line_header_list.value = response_data;
          loading.value = false;
          this.isAddExpense.value = false;
          this.isAddExpense.value = true;
          this.isExpend.value=false;
          Utils.sanckBarSuccess(
              'Message!', event_line_header_list[0].message.toString());
        } else {
          loading.value = false;
          Utils.sanckBarError(
              'False Message!', response_data[0].message.toString());
        }

      } else {
        loading.value = false;
        Utils.sanckBarError(
            'API Error',
            jsonResponse["message"] == null
                ? 'Invalid response format'
                : jsonResponse["message"]);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.sanckBarError('Error!', "Api Response Error");
    });
  }

  Widget GetImageSection(int index, String? path, String? imageUrl) {
    if (path != null && path.isNotEmpty) {
      print(path);
      return ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Image.file(
          File(path.toString()),
          fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
        ),
      );
    } else if (imageUrl != null && imageUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Image.network(
          imageUrl.toString(),
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

  String uploadImageFlag ='';
  String buttonText ='';
  List<String> imageUrls=[];
  List<String> selectedImageUrls=[];
  RxList<String> upLoadLocalImagesList = <String>[].obs;
  RxInt selectedindex=0.obs;
  void showLineImagesPopup(BuildContext context) {
    Size size = Get.size;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        selectedImageUrls=[];
        imageUrls = [];
        try{
          if(event_line_header_list[0].headerimages!.isNotEmpty){
            for(int i=0;i<event_line_header_list[0].headerimages!.length;i++){
              imageUrls.add(event_line_header_list[0].headerimages![i]!.fileurl!);
              selectedImageUrls.add(event_line_header_list[0].headerimages![i]!.fileurl!);

            }
            uploadImageFlag ='urlimage';
          }else{
            imageUrls.addAll(upLoadLocalImagesList);
            selectedImageUrls.addAll(upLoadLocalImagesList);
            uploadImageFlag='localimage';
          }
          if(uploadImageFlag=='urlimage'){
            buttonText='Discard All';
          }
          else if( uploadImageFlag=='localimage'){
            buttonText='Upload';
          }
        }catch(e){
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
                  title: Text('Event Images', style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700
                  ),),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    Row(
                      children: [
                        Visibility(visible:event_line_header_list[0].status ==
                            'Completed' ||
                            event_line_header_list[0].status ==
                                'Rejected' ||
                            event_line_header_list[0].status ==
                                'Approved'? false:true,
                        child: Container(
                          //padding: EdgeInsets.only(right: 0,bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [ActionChip(
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
                                if(buttonText=='Upload'){
                                  print('upload-----------------');
                                  if(upLoadLocalImagesList.isNotEmpty){
                                    upLoadApi(context);
                                  }
                                }else{
                                  discardApi(context);
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
                    visible: loading.value,
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
                Container(
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (event_line_header_list[0].status ==
                            'Completed' ||
                            event_line_header_list[0].status ==
                                'Rejected' ||
                            event_line_header_list[0].status ==
                                'Approved') {
                        } else {
                          upLoadImage(context);
                        }
                      },

                      child: Visibility(
                        visible: event_line_header_list[0].status ==
                            'Completed' ||
                            event_line_header_list[0].status ==
                                'Rejected' ||
                            event_line_header_list[0].status ==
                                'Approved' || buttonText=='Discard All'?false:true,
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
  }
  void _handleImageTap(int index) {
    selectedindex.value = index;
    print(selectedindex.value);
  }
  Future<void> upLoadApi(BuildContext context)async {
    final server_uri = Uri.parse(AppUrl.eventUploadImage);
    final clint_request = http.MultipartRequest('POST', server_uri);
    var fields = <String, String>{
      "process_type":'Event',
      "document_no": event_line_header_list[0].eventcode.toString(),
      //"files": upLoadLocalImagesList.value.toString(),
    };
    clint_request.fields.addAll(fields);
    for(int i=0;i<upLoadLocalImagesList.length;i++){
      clint_request.files.add(await http.MultipartFile.fromPath(
          'files',
          upLoadLocalImagesList[i].toString()));
      print(upLoadLocalImagesList[i]);
    }
    loading.value = true;

    //--hit api
    _api.eventManagementExpenseInsert(clint_request, sessionManagement).then((value) {

      final jsonResponse = json.decode(value);
      if (jsonResponse is List) {
        List<EventHeaderLineMngModal> response_data =
        jsonResponse.map((data) => EventHeaderLineMngModal.fromJson(data)).toList();

        if (response_data!=null && response_data.length >0 && response_data[0].condition == 'True') {
         // event_line_header_list.value = response_data;
          loading.value = false;
          imageUrls=[];
          upLoadLocalImagesList.value=[];
          print('upload-----------------');
          createEventMng('',event_line_header_list[0].eventcode!);
          Navigator.of(context).pop();
         // this.isAddExpense.value = false;
         // this.isAddExpense.value = true;
         // this.isExpend.value=false;
          Utils.sanckBarSuccess(
              'Message!', event_line_header_list[0].message.toString());
        } else {
          print("Errror.....${response_data[0].message}");
          loading.value = false;
          Utils.sanckBarError(
              'False Message!', response_data[0].message.toString());
        }

      } else {

        loading.value = false;
        Utils.sanckBarError(
            'API Error',
            jsonResponse["message"] == null
                ? 'Invalid response format'
                : jsonResponse["message"]);
      }
    }).onError((error, stackTrace) {
      print(error);
      loading.value = false;
      Utils.sanckBarError('Error!', "Api Response Error");
    });
  }
  Future upLoadImage(BuildContext context) async {
    var image = null;
    try {
      image = await _picker_checkout.pickImage(source: ImageSource.camera, imageQuality: 60);
      upLoadLocalImagesList.add(image.path.toString());
      //update();
      Navigator.of(context).pop();
      showLineImagesPopup(context);
      // upLoadImageSection(upLoadLocalImagesList.length-1, image.path);
      print('image path from list...........${upLoadLocalImagesList}');

    } catch (e) {
      //Utils.sanckBarError("Image Exception!", e.toString());
    }
  }
  Widget upLoadImageSection(String? path, String? flag) {
    print('updatedd------------path${path}');
    if (flag=='localimage') {
      print(path);
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
      //print(path);
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

  discardApi(BuildContext context){
    Map data = {
      "process_type": "Event",
      "document_no": event_line_header_list[0].eventcode,
    };
    loading.value = true;
    print("Event Code..............${event_line_header_list[0].eventcode}");
    _api.imageDiscardApi(data, sessionManagement).then((value) {
      final jsonResponse = json.decode(value);
      if (jsonResponse is List) {
        List<EventHeaderLineMngModal> api_response =
        jsonResponse.map((data) => EventHeaderLineMngModal.fromJson(data)).toList();
        if (api_response[0].condition == 'True') {
          loading.value = false;
          imageUrls=[];
          upLoadLocalImagesList.value=[];
          createEventMng('',event_line_header_list[0].eventcode!);
          Navigator.of(context).pop();
          //event_line_header_list.value = [];
        } else {
          loading.value = false;
          print("Errror.....${api_response[0].message}");
          Utils.sanckBarError(
              'False Message!', api_response[0].message.toString());
        }
      } else {
        loading.value = false;
        Utils.sanckBarError(
            'API Error',
            jsonResponse["message"] == null
                ? 'Invalid response format'
                : jsonResponse["message"]);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.sanckBarError('Error!', "Api Response Error");
    });
  }

  RxDouble currentLat = 0.0.obs;
  RxDouble currentLng = 0.0.obs;
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


  /*getfarmerss(){
    Map data = {
      "customer_no": "",
      "customer_name": "",
      "customer_type": "Farmer",
      "state_code": "",
      "latitude": "",
      "longitude": "",
      "email_id": email_id,
      "row_per_page": 10,
      "page_number": 0
    };
    loading.value=true;
    _api_plant.getCustomersApiHit(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<CustomersModel> response =
          jsonResponse.map((data) => CustomersModel.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value=false;
            farmer_list.value = response;
          } else {
            loading.value=false;
            farmer_list.value = [];
            Utils.sanckBarError('farmer not found!', response[0].message.toString());
          }
        } else {
          loading.value=false;
          farmer_list.value = [];
          Utils.sanckBarError('API Error', jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        farmer_list.value = [];
        printError();
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      print(error);
      farmer_list.value = [];
    });
  }*/
  Future<Iterable<CustomersModel>> searchFarmer(String text) async {

    if (text == '') {
      return const Iterable<CustomersModel>.empty();
    }
    Map data = {
      "customer_no": text,
      "customer_name": "",
      "customer_type": "Farmer",
      "state_code": "",
      "latitude": "",
      "longitude": "",
      "email_id": email_id,
      "row_per_page": 10,
      "page_number": 0
    };


    String customer_response =await _api_plant.getCustomersApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(customer_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<CustomersModel> response =
        jsonResponse.map((data) => CustomersModel.fromJson(data)).toList();
        print('condition..'+response[0].condition.toString());
        if (response[0].condition == 'True') {
          print(jsonResponse);
          farmer_list.value = response;

        } else {
          Utils.sanckBarException('False!', response[0].message!);
          farmer_list.value= [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        farmer_list.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      farmer_list.value = [];
    }
    return  farmer_list.value;
  }
}