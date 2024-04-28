import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pristine_seeds/models/seed_dispatch/production_lot_no_model.dart';
import 'package:http/http.dart' as http;

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/orders/customers_model.dart';
import '../../models/planting/season_model.dart';
import '../../models/planting/supervisor_modal.dart';
import '../../models/seed_dispatch/item_category_mst_get_modal.dart';
import '../../models/seed_dispatch/item_group_category_modal.dart';
import '../../models/seed_dispatch/item_master_modal.dart';
import '../../models/seed_dispatch/seed_dispatch_header_get_Modal.dart';
import '../../models/seed_dispatch/seed_dispatch_line_get.dart';
import '../../models/seed_dispatch/seed_dispatch_modal.dart';
import '../../repository/event_management_repo/Event_management_repo.dart';
import '../../repository/planting_repository/planting_creation_repo.dart';
import '../../repository/seed_dispatch_repository/seed_dispatch_create_repo.dart';
import '../../resourse/appUrl/app_url.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../session_management/session_management_controller.dart';

class SeedDispatch_VM extends GetxController{
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading = false.obs;
  RxBool button_loading = false.obs;
  final _api = seedDispatchCreationRepository();
  final _api_planting = plantingCreationRepository();
  RxInt status=0.obs;

  RxBool reset_field_ui=false.obs;
  RxBool isShowDocDropDown=true.obs;

  RxString customer_name=''.obs;

  RxList<SeedDispatchGetHeaderModal> seed_dispatch_get_header_list = <SeedDispatchGetHeaderModal>[].obs;
  RxList<SeedDispatLocationchModal> seed_dispatch_location_list = <SeedDispatLocationchModal>[].obs;
  RxList<SeasonGetModel> season_list = <SeasonGetModel>[].obs;
  RxList<CustomersModel> organizer_list = <CustomersModel>[].obs;
  RxList<CustomersModel> farmer_list = <CustomersModel>[].obs;
  RxList<ItemCategoryMstGetModal> item_ctg_mstget_list = <ItemCategoryMstGetModal>[].obs;
  RxList<ItemGroupCategory> item_group_ctg__list = <ItemGroupCategory>[].obs;
  RxList<ItemMasterModal> item_list = <ItemMasterModal>[].obs;
  RxList<String> got_list = <String>['Yes','No'].obs;
  RxList<SeedDispatchLineHeaderModal> seed_dispatch_header_line_list = <SeedDispatchLineHeaderModal>[].obs;

  Rx<SeedDispatLocationchModal> selected_location=new SeedDispatLocationchModal().obs;

  Rx<CustomersModel> selected_organizer=new CustomersModel().obs;
  Rx<ItemCategoryMstGetModal> selected_category=new ItemCategoryMstGetModal().obs;
  Rx<ItemGroupCategory> selected_group_category=new ItemGroupCategory().obs;
  Rx<ItemMasterModal> selected_item_category=new ItemMasterModal().obs;
  Rx<SuperVisorModal> selected_supervisor=new SuperVisorModal().obs;

  RxList<ProductionLotModel> lot_no_List =<ProductionLotModel>[].obs;


  Rx<SeasonGetModel> selected_season=new SeasonGetModel().obs;


  String email_id = "";
  String farmer_name="";

  int total_rows=0;
  int pageNumber=0;
  int rowsPerPage=10;

  //todo for header
  var date_controller = TextEditingController();
  var seed_dispatch_location_controller = TextEditingController();
  var season_controller = TextEditingController();
  var organizer_controller = TextEditingController();
  var supervisor = TextEditingController();
  var transporter = TextEditingController();
  var truck_no = TextEditingController();
  var camp_at = TextEditingController();
  var reference_no = TextEditingController();
  var remarks = TextEditingController();
  var fright_amount_controller = TextEditingController();

  //todo for line
  var dispatchNo_controller = TextEditingController();
  var farmer_code_controller = TextEditingController();
  //var lot_no_controller=TextEditingController();


  var farmer_name_controller = TextEditingController();
  var lotNo_controller = TextEditingController();
  var category_code_controller = TextEditingController();
  var category_group_controller = TextEditingController();
  var item_no_controller = TextEditingController();
  var quantity_controller = TextEditingController();
  var no_of_bags_controller = TextEditingController();
  var remarks_controller = TextEditingController();
  var moisture_perc_controller = TextEditingController();
  var harvest_acreage_controller = TextEditingController();
  var got_controller = TextEditingController();

  var company_bags_controller = TextEditingController();
  var farmer_bags_controller = TextEditingController();


  void resetAllHeaderFields(){
    this.reset_field_ui.value=true;
    date_controller.clear();
    seed_dispatch_location_controller.clear();
    season_controller.clear();
    organizer_controller.clear();
    supervisor.clear();
    transporter.clear();
    truck_no.clear();
    camp_at.clear();
    reference_no.clear();
    remarks.clear();
    fright_amount_controller.clear();

    this.reset_field_ui.value=false;
  }
  Future seedDispatchHeaderGetRefressUi(String flag,int status) async{
    pageNumber=0;
    total_rows=0;
    seed_dispatch_get_header_list.value=[];
    seedDispatchHeaderGet(pageNumber,flag,status);
  }
  seedDispatchHeaderGet(int pageNumber,String flag,int status){
    Map data = {
      "created_by": email_id,
      "email_id": email_id,
      "status":status,
      "rowsPerPage": rowsPerPage,
      "pageNumber": pageNumber
    };
    loading.value=true;
    _api.seedDispatchHeaderGet(data, sessionManagement).then((value){
      try{
        final jsonResponse = json.decode(value);
        if( jsonResponse is List){
          List<SeedDispatchGetHeaderModal> response = jsonResponse.map((data) => SeedDispatchGetHeaderModal.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value=false;
            print("we get response successfully");
            List<SeedDispatchGetHeaderModal> my_current_list=[];

            my_current_list.addAll(seed_dispatch_get_header_list);
            my_current_list.addAll(response);
            seed_dispatch_get_header_list.value=[];
            seed_dispatch_get_header_list.value=my_current_list;
            print('length of list ${seed_dispatch_get_header_list.length}');
            total_rows=int.parse(response[0].totalrows!);
            if(flag!=null && flag.isNotEmpty && flag=='GO_TO_LIST_PAGE'){
              Get.offAllNamed(RoutesName.seedDispatchList);
            }
          } else {
            loading.value=false;
            seed_dispatch_get_header_list.value = [];
            //Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        }
      }
      catch (e) {
        loading.value=false;
        seed_dispatch_get_header_list.value = [];
        Utils.sanckBarError('Exception!',e.toString() );
      }
    });
  }
  seeDispatchLocationGet(){
    Map<String, String> data = {};
    _api.getSeedDispatchLocation(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<SeedDispatLocationchModal> response =
          jsonResponse.map((data) => SeedDispatLocationchModal.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            seed_dispatch_location_list.value = response;
            //print('location list response ${seed_dispatch_get_header_list.length}');
            seasonMstGet();
            //  Get.toNamed(RoutesName.seedDispatchHeaderCreate);

          } else {
            seed_dispatch_location_list.value = [];
            //Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          //print('location list does not responseresponse');
          seed_dispatch_location_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
        }
      } catch (e) {
        //print('location list does not responseresponse.....'+e.toString());
        seed_dispatch_location_list.value = [];
        printError();
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('API Error',error.toString() );
      print(error);
      seed_dispatch_location_list.value = [];
    });
  }
  seasonMstGet(){
    Map data = {
      'season_code':'',
      'season_name': ''
    };
    _api_planting.seasonMstGet(data, sessionManagement).then((value) {
      loading.value=true;
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<SeasonGetModel> response =
          jsonResponse.map((data) => SeasonGetModel.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value=false;
            season_list.value = response;
            //getOrganizers();

          } else {
            loading.value=false;
            season_list.value = [];
            Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          loading.value=false;
          season_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        season_list.value = [];
        printError();
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      Utils.sanckBarError('API Error',error.toString() );
      print(error);
      season_list.value = [];
    });
  }

  RxList<SuperVisorModal> supervisor_list = <SuperVisorModal>[].obs;
  getSupervisor(){
    Map<String, String> data = {
      "email_id": email_id,
    };
    loading.value=true;
    _api_planting.getSupervisor(data, sessionManagement).then((value){
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<SuperVisorModal> response =
          jsonResponse.map((data) => SuperVisorModal.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value=false;
            print('response of supervisor list $response');
            supervisor_list.value = response;

          } else {
            loading.value=false;
            supervisor_list.value = [];
            Utils.sanckBarError('False Message!','supervisor not found');
          }
        } else {
          loading.value=false;
          supervisor_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
          print(jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        supervisor_list.value = [];
        print(e);
        Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('API Error',error.toString() );
      print(error);
    });
  }
  getProductionLotNo(){
    Map<String , String > data={
      "production_lot_no":lotNo_controller.text.isEmpty?"":lotNo_controller.text.toLowerCase(),
      "email":"",
    };
    _api.getproductionApi(data, sessionManagement).then((value) {
      loading.value=true;
      print(value);
      try{
        final jsonResponse=json.decode(value);
        if(jsonResponse is List){
          List<ProductionLotModel> response=jsonResponse.map((e) =>
              ProductionLotModel.fromJson(e)).toList();
          if(response!=null && response[0].condition=='True'){
            loading.value=false;
            lot_no_List.value=response;
          }
        }else{
          loading.value=false;
          lot_no_List.value=[];

        }
      }catch(e){
        loading.value=false;
        lot_no_List.value=[];
      }
    },).onError((error, stackTrace) {
      loading.value=false;
      print(error);
      lot_no_List.value=[];
    },);

  }

  @override
  void onInit() async {
    super.onInit();
    email_id = await sessionManagement.getEmail() ?? '';
    print('email is $email_id');
    seedDispatchHeaderGet(pageNumber,'',status.value);
  }



  //todo seedDispatch header create
  seedDispatchHeaderCreate(){
    if(date_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select date.');
      return;
    }
    if(selected_location.value.locationname!=seed_dispatch_location_controller.text){
      Utils.sanckBarError('Error : ', 'Please Select Location.');
      return;
    }
    if(season_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Season.');
      return;
    }
    if(organizer_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Organizer.');
      return;
    }

    if(supervisor.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please select supervisor');
      return;
    }
    if(transporter.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please fill transporter.');
      return;
    }
    if(truck_no.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please fill truck no.');
      return;
    }
    if(camp_at.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please fill camp at.');
      return;
    }
    if(reference_no.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please fill references no.');
      return;
    }
    if(remarks.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please fill remarks.');
      return;
    }
    if(fright_amount_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please fill fright amount.');
      return;
    }

    Map data = {
      "refrence_no": reference_no.text,
      "document_type": "",
      "date": date_controller.text,
      "location_name": seed_dispatch_location_controller.text,
      "location_code": selected_location.value.locationid,
      "supervisor": supervisor.text,
      "transporter": transporter.text,
      "organizer_code": selected_organizer.value.customerNo,
      "organizer_name": organizer_controller.text,
      "truck_number": truck_no.text,
      "season_code": selected_season.value.seasonCode,
      "camp_at": camp_at.text,
      "remarks": remarks.text,
      "fright_amount": fright_amount_controller.text,
      "created_by": email_id
    };
    loading.value=true;
    button_loading.value = true;
    _api.seedDispatchHeaderCreate(data, sessionManagement).then((value) {
      print(value);
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<SeedDispatchLineHeaderModal> response =
          jsonResponse.map((data) => SeedDispatchLineHeaderModal.fromJson(data)).toList();
          if (response.length>0 && response[0].condition == 'True') {
            Utils.sanckBarSuccess('Success Message!',response[0].message.toString());
            loading.value=false;
            button_loading.value = false;
            seed_dispatch_header_line_list.value = response;
            dispatchNumber =seed_dispatch_header_line_list[0].dispatchNo!;
            resetAllHeaderFields();
            this.seedDispatchHeaderGetRefressUi('',0);
            Get.toNamed(RoutesName.seedDispatchLineDetail);
          } else {
            loading.value=false;
            button_loading.value = false;
            seed_dispatch_header_line_list.value = [];
            Utils.sanckBarError('Response condition false!',response[0].message.toString());
          }
        } else {
          loading.value=false;
          button_loading.value = false;
          seed_dispatch_header_line_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
          print(jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        button_loading.value = false;
        seed_dispatch_header_line_list.value = [];
        print(e);
        Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      button_loading.value = false;
      Utils.sanckBarError('API Error Exception',error.toString() );
      print(error);
      seed_dispatch_header_line_list.value = [];
    });
  }
  //todo seedDispatch line create
  late int selectGot ;
  seedDispatchLineCreate(){
    if(lotNo_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please fill lot no.');
      return;
    }
    if(farmer_code_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select farmer code.');
      return;
    }
    if(farmer_name_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select farmer name.');
      return;
    }
    if(category_code_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select category code.');
      return;
    }
    if(category_group_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please select group category');
      return;
    }
    if(item_no_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please select item no.');
      return;
    }
    if(quantity_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please fill quantity.');
      return;
    }
    if(no_of_bags_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please fill no of bags.');
      return;
    }
    if(remarks_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please fill remarks.');
      return;
    }
    if(got_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please select got.');
      return;
    }
    if(farmer_bags_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please fill farmer bags.');
      return;
    }
    if(company_bags_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please fill company bags.');
      return;
    }
    Map data = {
      "dispatch_no": dispatchNumber,
      "farmer_code": farmer_code_controller.text,
      "farmer_name": farmer_name,
      "lot_number": lotNo_controller.text,
      "category_code": category_code_controller.text,
      "category_group_code": category_group_controller.text,
      "item_no": item_no_controller.text,
      "quantity": quantity_controller.text,
      "number_of_bags": no_of_bags_controller.text,
      "remarks": remarks_controller.text,
      "moisture_prcnt": moisture_perc_controller.text,
      "harvested_acreage": harvest_acreage_controller.text,
      "got":got_controller.text=='Yes'?1:0,
      "company_bags": company_bags_controller.text,
      "farmer_bags": farmer_bags_controller.text
    };
    print('date.........${data}');
    loading.value=true;
    button_loading.value=true;
    _api.seedDispatchLineCreate(data, sessionManagement).then((value) {
      print(value);
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<SeedDispatchLineHeaderModal> response =
          jsonResponse.map((data) => SeedDispatchLineHeaderModal.fromJson(data)).toList();
          if (response.length>0 /*&& response.isNotEmptyresponse[0].condition == 'True'*/) {
            Utils.sanckBarSuccess('Success Message!',response[0].message.toString());
            loading.value=false;
            button_loading.value=false;
            seed_dispatch_header_line_list.value = response;
            resetAllHeaderFields();
            //this.plantingHeaderGetRefressUi('','');
            Get.toNamed(RoutesName.seedDispatchLineDetail);
          } else {
            loading.value=false;
            button_loading.value=false;
            seed_dispatch_header_line_list.value = [];
            Utils.sanckBarError('Response condition false!',response[0].message.toString());
          }
        } else {
          loading.value=false;
          button_loading.value=false;
          seed_dispatch_header_line_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
          print(jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        button_loading.value=false;
        seed_dispatch_header_line_list.value = [];
        print(e);
        Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      button_loading.value=false;
      Utils.sanckBarError('API Error Exception',error.toString() );
      print(error);
      seed_dispatch_header_line_list.value = [];
    });
  }

  late String dispatchNumber;
  seedDispatchHeaderLineDetail(String dispatchNo) {
    seed_dispatch_header_line_list.value = [];
    dispatchNumber = dispatchNo;
    Map<String, String> data = {
      "dispatch_no":dispatchNo
    };
    //print('Disssppppp.......... ${dispatchNo}');
    loading.value=true;
    _api.seedDispatchLineGet(data, sessionManagement).then((value){
      //print(value);
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<SeedDispatchLineHeaderModal> response = jsonResponse.map((data) => SeedDispatchLineHeaderModal.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value=false;
            //print('response of header line list $response');
            seed_dispatch_header_line_list.value = response;
            //print('Disss.......... ${seed_dispatch_header_line_list.length}');
            //print(response[0].supervisor);
            Get.toNamed(RoutesName.seedDispatchLineDetail);

          } else {
            loading.value=false;
            seed_dispatch_header_line_list.value = [];
            Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          loading.value=false;
          seed_dispatch_header_line_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
          //print('error response----------------${jsonResponse}');
        }
      } catch (e) {
        loading.value=false;
        seed_dispatch_header_line_list.value = [];
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
    _api.getItemCategory(data, sessionManagement).then((value){
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ItemCategoryMstGetModal> response =
          jsonResponse.map((data) => ItemCategoryMstGetModal.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value=false;
            print('response of header line list $response');
            item_ctg_mstget_list.value = response;
            print(item_ctg_mstget_list[0].categoryCode);
            Get.toNamed(RoutesName.seedDispatchLineCreate);

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
    _api.getItemGroupCategory(data, sessionManagement).then((value){
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
  getItem(String group_code){
    item_list.value = [];
    Map data = {
      "item_no": "",
      "name": "",
      "category_code": category_code_controller.text,
      "group_code": group_code,
      "crop_type": "",
      "gst_group_code": "",
      "hsn_code": "",
      "active": -1,
      "rowsPerPage": 10,
      "pageNumber": 0
    };
    loading.value=true;
    _api.getItemMaster(data, sessionManagement).then((value){
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ItemMasterModal> response =
          jsonResponse.map((data) => ItemMasterModal.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value=false;
            print('response of header line list $response');
            item_list.value = response;
            print(item_list[0].itemNo);
            //Get.toNamed(RoutesName.seedDispatchLineCreate);

          } else {
            loading.value=false;
            item_list.value = [];
            //Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          loading.value=false;
          item_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
          print(jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        item_list.value = [];
        print(e);
        Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('API Error',error.toString() );
      print(error);
    });
  }
  void resetAllLineFields() {
    this.reset_field_ui.value=true;
    lotNo_controller.clear();
    farmer_code_controller.clear();
    farmer_name_controller.clear();
    category_code_controller.clear();
    category_group_controller.clear();
    item_no_controller.clear();
    quantity_controller.clear();
    no_of_bags_controller.clear();
    remarks_controller.clear();
    harvest_acreage_controller.clear();
    got_controller.clear();
    moisture_perc_controller.clear();
    farmer_bags_controller.clear();
    company_bags_controller.clear();
    item_group_ctg__list.value=[];
    item_list.value=[];

  }
  discardHeader(){
    seed_dispatch_header_line_list.value = [];
    Map<String, String> data = {
      "dispatch_no": dispatchNumber,
      "email_no": email_id
    };
    loading.value=true;
    _api.discardHeaderApi(data, sessionManagement).then((value){
      print(value);
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<SeedDispatchLineHeaderModal> response = jsonResponse.map((data) => SeedDispatchLineHeaderModal.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            Utils.sanckBarSuccess('Success!', response[0].message.toString());
            seedDispatchHeaderGetRefressUi('',0);
            Get.toNamed(RoutesName.seedDispatchList);

          } else {
            loading.value=false;
            seed_dispatch_header_line_list.value = [];
            Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          loading.value=false;
          seed_dispatch_header_line_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
          print(jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        seed_dispatch_header_line_list.value = [];
        print(e);
        //Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('API Error',error.toString() );
      print(error);
    });
  }

  deleteLine(context, String? dispatchNo, String lineNo) {

    Map data = {
      "dispatch_no": dispatchNo,
      "line_no": lineNo,
      "email_no": email_id
    };
    loading.value=true;
    _api.discardLineApi(data, sessionManagement).then((value){
      print(value);
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<SeedDispatchLineHeaderModal> response = jsonResponse.map((data) => SeedDispatchLineHeaderModal.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            Utils.sanckBarSuccess('Success !', response[0].message.toString());
            print('line is deleted');
            print('dispached...${dispatchNo}');
            //Get.toNamed(RoutesName.seedDispatchLineDetail);
            seedDispatchHeaderLineDetail(dispatchNo!);
            print("Stetusss.....${seed_dispatch_header_line_list[0].status}");

          } else {
            loading.value=false;
            seed_dispatch_header_line_list.value = [];
            Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          loading.value=false;
          seed_dispatch_header_line_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
          print(jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        seed_dispatch_header_line_list.value = [];
        print(e);
        //Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      //Utils.sanckBarError('API Error',error.toString() );
      print(error);
    });
  }
  seedDispatchHeaderComplete(String? dispatchNo){
    Map data = {
      "dispatch_no": dispatchNo,
      "email_id": email_id
    };

    if(!loading.value){
      loading.value=true;
      _api.completeHeaderApi(data, sessionManagement).then((value) {
        try {
          final jsonResponse = json.decode(value);
          if (jsonResponse is List) {
            List<SeedDispatchLineHeaderModal> response =
            jsonResponse.map((data) => SeedDispatchLineHeaderModal.fromJson(data)).toList();
            if (response[0].condition == 'True') {
              Utils.sanckBarSuccess('Success Message!', response[0].message.toString());
              loading.value=false;
              seedDispatchHeaderGetRefressUi('GO_TO_LIST_PAGE',0);
            } else {
              loading.value=false;
              Utils.sanckBarError('False Message!', response[0].message.toString());
            }
          } else {
            loading.value=false;
            Utils.sanckBarError('API Response', jsonResponse);
            print(jsonResponse);
          }
        } catch (e) {
          loading.value=false;
          print(e);
          Utils.sanckBarError('Exception!',e.toString());
        }
      }).onError((error, stackTrace) {
        loading.value=false;
        Utils.sanckBarError('API Error Exception',error.toString() );
      });
    }

  }
  openBottomSheetDialog(BuildContext context,int position){
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(child: Icon(Icons.cancel,color: AllColors.primaryliteColor,),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 87.0),
                      child: Text('Line Details',style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.twentee,
                          fontWeight: FontWeight.w700),
                        //textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            /*  Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActionChip(
                    elevation: 1,
                    tooltip: "Geo Location",
                    backgroundColor: AllColors.grayColor,
                    // avatar: Icon(Icons.location_pin, color: AllColors.primaryDark1),
                    shape: StadiumBorder(
                        side: BorderSide(color: AllColors.primaryDark1)),
                    label: Text('Geo Location',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                  ),
                  Obx(() {
                    return  Visibility(
                      visible:planting_header_list[0].status!<=0 ? true : false,
                      child: ActionChip(
                        elevation: 1,
                        tooltip: "Delete",
                        backgroundColor: AllColors.grayColor,
                        //avatar: Icon(Icons.delete, color: AllColors.primaryDark1),
                        shape: StadiumBorder(
                            side: BorderSide(color: AllColors.redColor)),
                        label: Text('Delete',
                            style: GoogleFonts.poppins(
                              color: AllColors.redColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        onPressed: () {
                          plantingHeaderLineDiscard('Line Discard',planting_header_list[0].code,planting_header_list[0].lines![position].lineNo.toString(),context);
                        },
                      ),
                    );
                  }),
                  ActionChip(
                    elevation: 1,
                    tooltip: "Location",
                    backgroundColor: AllColors.grayColor,
                    // avatar: Icon(Icons.location_pin, color: AllColors.primaryDark1),
                    shape: StadiumBorder(
                        side: BorderSide(color: AllColors.primaryDark1)),
                    label: Text('Location',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                    onPressed: () {
                      planting_no.value=planting_header_list[0].code!;
                      planting_line_no.value=planting_header_list[0].lines![position].lineNo.toString();
                      mapAllCoordinates.value=planting_header_list[0].lines![position].mapAllCordinate!=null?
                      planting_header_list[0].lines![position].mapAllCordinate!:"";
                      mapShowingAreaInAcres.value=planting_header_list[0].lines![position].mapSowingAreaInAcres.toString();
                      Get.toNamed(RoutesName.add_geo_location_with_map);
                    },
                  ),
                ],),
            ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: 2,
                color: AllColors.primaryliteColor,
              ),
            ) ,

            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Line No.:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(seed_dispatch_header_line_list[0].lines![position].lineNo.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Lot No. ',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(seed_dispatch_header_line_list[0].lines![position].lotNumber.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Farmer Name:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(seed_dispatch_header_line_list[0].lines![position].farmerName.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Farmer Code:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(seed_dispatch_header_line_list[0].lines![position].farmerCode?? '',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Category Code:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(seed_dispatch_header_line_list[0].lines![position].categoryCode.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Category  Group Code:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(seed_dispatch_header_line_list[0].lines![position].itemgroupcode?? '',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Item No.:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(seed_dispatch_header_line_list[0].lines![position].itemNo?? '',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Quantity:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(seed_dispatch_header_line_list[0].lines![position].quantity.toString()?? '',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('No. Of Bags:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(seed_dispatch_header_line_list[0].lines![position].numberOfBags.toString()?? '',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Company Bags:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(seed_dispatch_header_line_list[0].lines![position].companybags.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Farmer Bags:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(seed_dispatch_header_line_list[0].lines![position].farmerbags.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Moisture Percentage:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(seed_dispatch_header_line_list[0].lines![position].moisturePrcnt.toString()?? '',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Harvest Acreage:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(seed_dispatch_header_line_list[0].lines![position].harvestedAcreage.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Got Type:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(seed_dispatch_header_line_list[0].lines![position].got==1?"Yes":"No",
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Remarks:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(seed_dispatch_header_line_list[0].lines![position].remarks.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
            // Add more ListTile widgets for additional options if needed
          ],
        );
      },
    );
  }

  //todo for add image
  String uploadImageFlag ='';
  String buttonText ='';
  List<String> imageUrls=[];
  List<String> selectedImageUrls=[];
  RxList<String> upLoadLocalImagesList = <String>[].obs;
  RxInt selectedindex=0.obs;
  final ImagePicker _picker_checkout = ImagePicker();

  void showLineImagesPopup(BuildContext context) {
    Size size = Get.size;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        selectedImageUrls=[];
        imageUrls = [];
        try{
          if(seed_dispatch_header_line_list[0].headerimages!.isNotEmpty){
            for(int i=0;i<seed_dispatch_header_line_list[0].headerimages!.length;i++){
              imageUrls.add(seed_dispatch_header_line_list[0].headerimages![i]!.fileurl!);
              selectedImageUrls.add(seed_dispatch_header_line_list[0].headerimages![i]!.fileurl!);
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
                  title: Text('Dispatch Images', style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700
                  ),),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    Row(
                      children: [Visibility(
                        visible:seed_dispatch_header_line_list[0].status == 1? false:true,
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
                        if (seed_dispatch_header_line_list[0].status == 1) {
                        } else {
                          upLoadImage(context);
                        }
                      },
                      child: Visibility(
                        visible: seed_dispatch_header_line_list[0].status == 1 || buttonText=='Discard All'?false:true,
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
                                child: upLoadImageSection(
                                    imageUrls[index], uploadImageFlag),
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
  Future upLoadImage(BuildContext context) async {
    var image = null;
    try {
      image = await _picker_checkout.pickImage(source: ImageSource.camera, imageQuality: 60);
      upLoadLocalImagesList.add(image.path.toString());
      //update();
      Navigator.of(context).pop();
      showLineImagesPopup(context);
      // upLoadImageSection(upLoadLocalImagesList.length-1, image.path);
      //print('image path from list...........${upLoadLocalImagesList}');

    } catch (e) {
     // Utils.sanckBarError("Image Exception!", e.toString());
    }
  }
  Widget upLoadImageSection(String? path, String? flag) {
    print('updatedd------------path${flag}');
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

  final _api_upload_discard = EventManagementRepository();


  Future<void> upLoadApi(BuildContext context)async {
    final server_uri = Uri.parse(AppUrl.eventUploadImage);
    final clint_request = http.MultipartRequest('POST', server_uri);
    var fields = <String, String>{
      "process_type":'DispatchNote',
      "document_no": seed_dispatch_header_line_list[0].dispatchNo.toString(),
    };
    clint_request.fields.addAll(fields);
    for(int i=0;i<upLoadLocalImagesList.length;i++){
      clint_request.files.add(await http.MultipartFile.fromPath(
          'files',
          upLoadLocalImagesList[i].toString()));
      print(upLoadLocalImagesList[i]);
    }
    loading.value = true;

    _api_upload_discard.eventManagementExpenseInsert(clint_request, sessionManagement).then((value) {
      print("print___value_____${value}");
      final jsonResponse = json.decode(value);
      if (jsonResponse is List) {
        List<SeedDispatchLineHeaderModal> response_data =
        jsonResponse.map((data) => SeedDispatchLineHeaderModal.fromJson(data)).toList();

        if (/*response_data!=null && response_data.length >0 &&*/ response_data[0].condition == 'True') {
          loading.value = false;
          imageUrls=[];
          selectedImageUrls=[];
          upLoadLocalImagesList.value=[];
          print('upload-----------------${seed_dispatch_header_line_list[0].dispatchNo.toString()}');
          seedDispatchHeaderLineDetail(seed_dispatch_header_line_list[0].dispatchNo.toString());
          Navigator.of(context).pop();
          Utils.sanckBarSuccess(
              'Message!', seed_dispatch_header_line_list[0].message.toString());
        } else {
          print("Errror.....${response_data[0].message}");
          loading.value = false;
          Utils.sanckBarError(
              'False Message!', response_data[0].message.toString());
        }

      } else {

        loading.value = false;
        Utils.sanckBarError(
            'API Error', jsonResponse["message"] == null ? 'Invalid response format' : jsonResponse["message"]);
      }
    }).onError((error, stackTrace) {
      print("print___error_____${error}");
      loading.value = false;
      //Utils.sanckBarError('Error!', "Api Response Error");
    });
  }
  discardApi(BuildContext context){
    Map data = {
      "process_type": "DispatchNote",
      "document_no": seed_dispatch_header_line_list[0].dispatchNo,
    };
    loading.value = true;
    //print("Event Code..............${seed_dispatch_header_line_list[0].dispatchNo}");
    _api_upload_discard.imageDiscardApi(data, sessionManagement).then((value) {
      final jsonResponse = json.decode(value);
      if (jsonResponse is List) {
        List<SeedDispatchLineHeaderModal> api_response =
        jsonResponse.map((data) => SeedDispatchLineHeaderModal.fromJson(data)).toList();
        if (api_response[0].condition == 'True') {
          loading.value = false;
          imageUrls=[];
          selectedImageUrls=[];
          upLoadLocalImagesList.value=[];
          seedDispatchHeaderLineDetail(seed_dispatch_header_line_list[0].dispatchNo.toString());
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
      //Utils.sanckBarError('Error!', "Api Response Error");
    });
  }


 /* getOrganizers(){
    Map data = {
      "customer_no": "",
      "customer_name": "",
      "customer_type": "Organizer",
      "state_code": "",
      "latitude": "",
      "longitude": "",
      "email_id": email_id,
      "row_per_page": 10,
      "page_number": 0
    };
    _api.getCustomersApiHit(data, sessionManagement).then((value) {
      loading.value=true;
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<CustomersModel> response =
          jsonResponse.map((data) => CustomersModel.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value=false;
            organizer_list.value = response;
          } else {
            loading.value=false;
            organizer_list.value = [];
            Utils.sanckBarError('Organizer not found!', response[0].message.toString());
          }
        } else {
          loading.value=false;
          organizer_list.value = [];
          Utils.sanckBarError('API Error', jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        organizer_list.value = [];
        printError();
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      print(error);
      organizer_list.value = [];
    });
  }*/

  Future<Iterable<CustomersModel>> searchOrganizer(String text) async {

    if (text == '') {
      return const Iterable<CustomersModel>.empty();
    }
    Map data = {
      "customer_no": "",
      "customer_name": text,
      "customer_type": "Organizer",
      "state_code": "",
      "latitude": "",
      "longitude": "",
      "email_id": email_id,
      "row_per_page": 10,
      "page_number": 0
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
          organizer_list.value = response;

        } else {
          Utils.sanckBarException('False!', response[0].message!);
          organizer_list.value= [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        organizer_list.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      organizer_list.value = [];
    }
    return  organizer_list.value;
  }




  /*getFarmer(){
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
    _api.getCustomersApiHit(data, sessionManagement).then((value) {
      loading.value=true;
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
            Utils.sanckBarError('Farmer not found!', response[0].message.toString());
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
      "customer_name": '',
      "customer_type": "Farmer",
      "state_code": "",
      "latitude": "",
      "longitude": "",
      "email_id": email_id,
      "row_per_page": 10,
      "page_number": 0
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