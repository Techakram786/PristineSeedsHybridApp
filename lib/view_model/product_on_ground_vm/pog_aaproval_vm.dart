
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/back_button.dart';
import '../../components/default_button.dart';
import '../../components/default_button_red.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/dash_board/emp_master_response.dart';
import '../../models/product_on_ground/pog_approval_modal.dart';
import '../../models/product_on_ground/pog_approval_reject_modal.dart';
import '../../repository/product_on_ground_repository/product_on_ground_repo.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../session_management/session_management_controller.dart';

class ProductOnGroundApprovalVm extends GetxController{
  SessionManagement sessionManagement = SessionManagement();

  final _api = ProductOnGroundRepository();
  RxBool loading = false.obs;
  RxBool isshowBottom=false.obs;
  String email_id='';


  String pending_count = "", like_count = "", dislike_count = "";
  String selection_type = "";
  RxList<ProductOnGroundApprovalModal> pogApprovalList= <ProductOnGroundApprovalModal>[].obs;
  RxList<EmpMasterResponse> employess_List= <EmpMasterResponse>[].obs;
  var filter_date_controller = TextEditingController();
  var typeAheadControllerEmployee = TextEditingController();
  var remarks_controller = TextEditingController();


  @override
  void onInit() async{
    email_id = await sessionManagement.getEmail() ?? '';
    getEmployeeMasterApi('');
    getApprovalList();
  }

  getApprovalList() {
    print('approve..$selection_type');
    loading.value = true;
    Map<String, String> data={
      "created_by": typeAheadControllerEmployee.text.toString()??'',
      "email": email_id??'',
      "status": selection_type??'',
      "filter_date": filter_date_controller.text.toString()??'',
    };

    _api.productOnGroundApprovalApiHit(data, sessionManagement).then((value){
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ProductOnGroundApprovalModal> response =
          jsonResponse.map((data) => ProductOnGroundApprovalModal.fromJson(data)).toList();
          if (response.length > 0 && response != null && response[0].condition == 'True') {
            pogApprovalList.value=response;
            pending_count = pogApprovalList[0].pendingcount!;
            like_count = pogApprovalList[0].approvedcount!;
            dislike_count = pogApprovalList[0].rejectedcount!;
            loading.value = false;
          } else {
            pogApprovalList.value = response;
            pending_count = pogApprovalList[0].pendingcount!;
            like_count = pogApprovalList[0].approvedcount!;
            dislike_count = pogApprovalList[0].rejectedcount!;
            /* loading.value = false;
            Utils.sanckBarError('False Message!', response[0].message.toString());*/
          }
        } else {
          loading.value = false;
          Utils.sanckBarError('API Response', jsonResponse);
        }
      } catch (e) {
        pogApprovalList.value = [];
        pending_count = "0";
        like_count = "0";
        dislike_count = "0";
        /* loading.value = false;
        print(e);
        Utils.sanckBarError('Exception!', e.toString());*/
      }
    }).onError((error, stackTrace) {
      pogApprovalList.value = [];
      pending_count = "0";
      like_count = "0";
      dislike_count = "0";
      Utils.sanckBarError('Api Exception onError', error.toString());
    }).whenComplete(()  {
      this.loading.value = false;
      /*if(flag=='GOTO_LIST'){
        Get.offAllNamed(RoutesName.productOnGroundApproval);
      }*/
    });
  }
  getEmployeeMasterApi(String filter_login) {
    this.loading.value = true;
    print('employee...${email_id}');
    Map data = {'email_id': email_id};
    _api.getEmployeeTeamEmail(data, sessionManagement).then((value) {
      try {
        List<EmpMasterResponse> emp_masterResponse =
        (json.decode(value) as List)
            .map((i) => EmpMasterResponse.fromJson(i))
            .toList();
        if (emp_masterResponse[0]?.condition.toString() == "True") {
          employess_List.value = emp_masterResponse;
        } else {
          employess_List.value = [];
        }
      } catch (e) {
        employess_List.value = [];
      }
    }).onError((error, stackTrace) {
      employess_List.value = [];
      Utils.sanckBarError('Api Exception onError', error.toString());
    }).whenComplete(() {
      this.loading.value = false;
      this.getApprovalList();
    });
  }



 void markApproveReject(String pogcode, String text, String status) {
    this.loading.value = true;
    Map<String, String> data = {
      "pog_code": pogcode,
      "status": status,
      "reason": text,
      "email_id": "vaishali.singh@pristinebs.co.in"
    };
    _api.getPogApprovalRejectApiHit(data, sessionManagement).then((value) {
      try {
        List<ProductOnGroundApproveRejectModal> emp_masterResponse =
        (json.decode(value) as List)
            .map((i) => ProductOnGroundApproveRejectModal.fromJson(i))
            .toList();
        if (emp_masterResponse[0]?.condition.toString() == "True") {
          Utils.sanckBarSuccess('Success', emp_masterResponse[0].message.toString());
        } else {
          Utils.sanckBarError('False Message!', emp_masterResponse[0].message.toString());
          loading.value = false;
        }
      } catch (e) {
        loading.value = false;
        print(e);
        Utils.sanckBarError('Exception!', e.toString());
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.sanckBarError('Api Exception onError', error.toString());
    });
  }

/*  Future<void> showBottomSheetOpen(context, ProductOnGroundApprovalModal item) async {
    Size size=Get.size;
    showModalBottomSheet(context: context,
        builder: (BuildContext context) {
      return  Container(
        width: double.infinity,
        height: size.height/2,
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                    *//*onTap: (){
                      Navigator.pop(context);
                    },*//*
                    child: CircleBackButton(
                      press: () {
                        //Get.toNamed(RoutesName.homeScreen);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      "POG Details",
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Center(child: Divider(height: 1,color: AllColors.primaryDark1,)),
            // Obx(() {
            //  return
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Zone :",
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.sisxteen,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(' ${item.zone!}',
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w300

                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Emp Name:",
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.sisxteen,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      ' ${item.empname!}',
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w300

                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Season :",
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.sisxteen,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      '${item.season!}',
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w300
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Category Code :",
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.sisxteen,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      '${item.categorycode!}',
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w300
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Item Group Code :",
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.sisxteen,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      ' ${item.itemgroupcode!}',
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w300
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Item No :",
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.sisxteen,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      ' ${item.itemno!}',
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w300
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Customer/Distributor :",
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontSize: AllFontSize.sisxteen,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    Spacer(),
                                      Container(
                                         width: size.width*.3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Tooltip(
                                            message:item.customerordistributor ?? '' ,
                                            child: Text(
                                                ' ${item.customerordistributor ?? ''}',
                                                style: GoogleFonts.poppins(
                                                    color: AllColors.primaryDark1,
                                                    fontSize: AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w300
                                                ),
                                              overflow: TextOverflow.ellipsis,
                                              ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "POG Qty :",
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.sisxteen,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      ' ${item.pogqty!}',
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w300
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Remark :",
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.sisxteen,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      ' ${item.remarks!}',
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w300

                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
              ),
            ),

            Container(
              child: Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child:  Visibility(
                  visible:  (selection_type == "Approved" || selection_type == "Rejected") ?
                  isshowBottom.value ==true :  isshowBottom.value == false,
                  child: Container(
                    // padding: EdgeInsets.only(bottom: 80),
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * .4,
                          child: DefaultButton(
                            text: "Approve",
                            press: () {
                              showApproveDialog(context,item.pogcode!);
                            },
                            //  loading: viewCartController.loading.value,
                          ),
                        ),
                        Container(
                          width: size.width * .4,
                          child: DefaultButtonRed(
                            text: "Reject",
                            press: () {
                              showRemarkDialog(context, item);

                            },
                            //loading: viewCartController.loading.value,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ),
            ),
            //  })
          ],
        ),

      );
    },);
  }*/


  void showRemarkDialog(context, ProductOnGroundApprovalModal item) {
    remarks_controller.clear();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Reject...",style: TextStyle(color: AllColors.primaryDark1,)),
          content: TextFormField(
            cursorColor: AllColors.primaryDark1,
            controller:remarks_controller,
            decoration: InputDecoration(labelText: "Enter Remarks",labelStyle: TextStyle(color: AllColors.primaryDark1,),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AllColors.primaryDark1,)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AllColors.primaryDark1,))


            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cancel button pressed
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor,)),
            ),
            TextButton(
              onPressed: () {
                if(remarks_controller.text.isNotEmpty){
                  markApproveReject(item.pogcode!, remarks_controller.text,'Rejected');
                  Navigator.of(context).pop();
                  Get.offAllNamed(RoutesName.productOnGroundApproval);
                }
                else
                  Utils.sanckBarError('Remark!', 'Please Enter Remarks');
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1,)),
            ),
          ],
        );
      },
    );
  }

  void showApproveDialog(context, String pogCode) {
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Approve...",style: TextStyle(color: AllColors.primaryDark1,)),
          content:Text('Do you want to approve?',style: TextStyle(color: AllColors.primaryDark1),),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor,)),
            ),
            TextButton(
              onPressed: () {
               markApproveReject(pogCode, '','Approved');
                Navigator.of(context).pop();
                Get.offAllNamed(RoutesName.productOnGroundApproval);
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1,)),
            ),
          ],
        );
      },
    );
  }

}