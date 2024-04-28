import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../models/api_default_entity.dart';
import '../../models/check_in/check_in_response.dart';
import '../../models/checkin_approver/check_in_approve_entity.dart';
import '../../models/dash_board/emp_master_response.dart';
import '../../repository/check_in_approver_repo/CheckInRepository.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../session_management/session_management_controller.dart';

class CheckInApproverViewModel extends GetxController {
  final _api = CheckInApproverRepository();
  RxBool loading = false.obs;
  SessionManagement sessionManagement = SessionManagement();
  String Email_id = "";
  List<EmpMasterResponse> employess_List = [];
  var typeAheadControllerEmployee = TextEditingController();

  var filter_date_controller = TextEditingController();
  var remarks_controller = TextEditingController();
  String selection_type = "";
  List<CheckInApproveEntity> approver_list_data = [];
  RxList<CheckInResponse> checkIn_list_response = <CheckInResponse>[].obs;
  RxBool isapprove_reject_button=false.obs;

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
      this.getApprovalList();
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

  String pending_count = "0",
      like_count = "0",
      dislike_count = "0";

  getApprovalList() {
    this.loading.value = true;
    Map data = {
      'email_id': Email_id,
      'filter_date': filter_date_controller.text.toString(),
      'filter_created_by': typeAheadControllerEmployee.text.toString(),
      'approve_status': selection_type
    };
    _api.GetApproverData(data, sessionManagement).then((value) {
      try {
        List<CheckInApproveEntity> approver_list = (json.decode(value) as List)
            .map((i) => CheckInApproveEntity.fromJson(i))
            .toList();
        if (approver_list[0].condition.toString() == "True") {
          approver_list_data = approver_list;
          pending_count = approver_list_data[0].pendingCount;
          like_count = approver_list_data[0].likeCount;
          dislike_count = approver_list_data[0].dislikeCount;
        } else {
          approver_list_data = [];
          pending_count = approver_list[0].pendingCount;
          like_count = approver_list[0].likeCount;
          dislike_count = approver_list[0].dislikeCount;
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
    }).whenComplete(() => {this.loading.value = false});
  }

  markApproveReject(String document_no, String doctype, String approve_status,
      String remarks) {
    this.loading.value = true;
    Map data = {
      'document_no': document_no,
      'document_type': doctype,
      'approve_status': approve_status,
      'approve_by': Email_id,
      'remark': remarks
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
          this.getApprovalList();
          if(selection_type==''){
            Get.toNamed(RoutesName.checkInApproverScreen);
          }
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

  Future<void> currentRunningCheckInData(BuildContext context, String doc_no) async {
    loading.value = true;
    print(doc_no);
    Map data = {
      'document_no': doc_no,
      'created_by': Email_id,
    };

    _api.currentRunningCheckInDataApiHit(data, sessionManagement).then((value) {
      try {
        List<CheckInResponse> response_list = (json.decode(value) as List)
            .map((i) => CheckInResponse.fromJson(i))
            .toList();
        if (response_list != null && response_list.length > 0 &&
            response_list[0].condition.toString() == "True") {
          checkIn_list_response.value = response_list;
          loading.value = false;
          Get.toNamed(RoutesName.checkInApproverHeaderViewScreen);

        } else {
          checkIn_list_response.value = [];
          loading.value = false;
        }
      } catch (e) {
        checkIn_list_response.value = [];
        loading.value = false;
        Utils.sanckBarException('Exception', e.toString());
      }
    }).onError((error, stackTrace) {
      checkIn_list_response.value = [];
      loading.value = false;
      Utils.sanckBarError('Api Exception onError', error.toString());
    });
  }

  void showHeaderImagesPopup(BuildContext context) {
    Size size = Get.size;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        RxInt selectedindex=0.obs;
        List<String> imageUrls = [];
        try{
          if(checkIn_list_response[0].checkInImages!.frontImage!.isNotEmpty && !checkIn_list_response[0].checkInImages!.frontImage!.contains('image/no_image_placeholder.png') ){
            imageUrls.add(checkIn_list_response[0].checkInImages!.frontImage!);
          }
          if(checkIn_list_response[0].checkInImages!.backImage!.isNotEmpty && !checkIn_list_response[0].checkInImages!.backImage!.contains('image/no_image_placeholder.png')){
            imageUrls.add(checkIn_list_response[0].checkInImages!.backImage!);
          }
          if(checkIn_list_response[0].checkOutImages!.frontImage!.isNotEmpty && !checkIn_list_response[0].checkOutImages!.frontImage!.contains('image/no_image_placeholder.png') ){
            imageUrls.add(checkIn_list_response[0].checkOutImages!.frontImage!);
          }
          if(checkIn_list_response[0].checkOutImages!.backImage!.isNotEmpty && !checkIn_list_response[0].checkOutImages!.backImage!.contains('image/no_image_placeholder.png') ){
            imageUrls.add(checkIn_list_response[0].checkOutImages!.backImage!);
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
                  title: Text('Header Images', style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700
                  ),),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  /*actions: [
                    IconButton(
                      icon: Icon(Icons.cancel, color: AllColors.primaryDark1,),
                      onPressed: () {
                        Navigator.of(context).pop(); // Dismiss the dialog
                      },
                    ),
                  ],*/
                ),
                SizedBox(height: size.height*.2,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Obx((){
                          return Container(
                            width: size.width * .97,
                            height: size.height * .5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(8)),
                                border: Border.all(
                                    color: AllColors.primaryliteColor, width: .5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Image.network(
                                (imageUrls.length>0 && imageUrls!=null && imageUrls.isNotEmpty)
                                    ? imageUrls[selectedindex.value]
                                    : 'https://dev4.pristinefulfil.com/assets/images/vendor_panel_img/mylogo.png',
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
                              ),
                            ),
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0,bottom: 6.0),
                          child: Divider(color: AllColors.primaryliteColor,height: 1,),
                        ),//
                        SizedBox(height: 20),
                        Container(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imageUrls.length,
                            itemBuilder: (BuildContext context, int index) {
                              //return BindListView(context,imageUrls!, index);
                              if(imageUrls.length<=0 && imageUrls==null){
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text('No Records Found.',style: TextStyle(
                                      fontSize: 20,
                                      color: AllColors.primaryColor
                                  ),),
                                );
                              }
                              else{
                                return Container(
                                  width: 100,
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.blueGrey, width: 0.5),
                                  ),
                                  child: InkWell(
                                    onTap: (){
                                      selectedindex.value=index;
                                      print(selectedindex.value);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Image.network(
                                        imageUrls[index],
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
                                          /* return Center(
                                            child: Text('Failed to load image'), // Show an error message if image loading fails
                                          );*/
                                          return Container(child: Image.asset("assets/images/no_file.png"));
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              }

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

  void showLineImagesPopup(BuildContext context,List<Lines> linesList,int position) {
    Size size = Get.size;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        RxInt selectedindex=0.obs;
        List<String> imageUrls = [];
        try{
          if(linesList[position].image_url!.isNotEmpty){
            imageUrls.add(linesList[position].image_url!);
          }
          if(linesList[position].imageUrl2!.isNotEmpty){
            imageUrls.add(linesList[position].imageUrl2!);
          }
          if(linesList[position].imageUrl3!.isNotEmpty){
            imageUrls.add(linesList[position].imageUrl3!);
          }
          if(linesList[position].imageUrl4!.isNotEmpty){
            imageUrls.add(linesList[position].imageUrl4!);
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
                  title: Text('Line Images', style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700
                  ),),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  /* actions: [
                    IconButton(
                      icon: Icon(Icons.cancel, color: AllColors.primaryDark1,),
                      onPressed: () {
                        Navigator.of(context).pop(); // Dismiss the dialog
                      },
                    ),
                  ],*/
                ),
                SizedBox(height: size.height*.2,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Obx((){
                          return Container(
                            width: size.width * .97,
                            height: size.height * .5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              border: Border.all(color: AllColors.primaryliteColor, width: .5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Image.network(
                                (imageUrls.length > 0 && imageUrls != null && imageUrls.isNotEmpty)
                                    ? imageUrls[selectedindex.value]
                                    : 'https://dev4.pristinefulfil.com/assets/images/vendor_panel_img/mylogo.png',
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
                                  return Center(
                                    child: Text('Failed to load image'), // Show an error message if image loading fails
                                  );
                                },
                              ),
                            ),
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0,bottom: 6.0),
                          child: Divider(color: AllColors.primaryliteColor,height: 1,),
                        ),//
                        SizedBox(height: 20),
                        Container(
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: imageUrls.length,
                              itemBuilder: (BuildContext context, int index) {
                                //return BindListView(context,imageUrls!, index);
                                return Container(
                                  width: 100,
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.blueGrey, width: 0.5),
                                  ),
                                  child: InkWell(
                                    onTap: (){
                                      selectedindex.value=index;
                                      print(selectedindex.value);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Image.network(
                                        imageUrls[index],
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
                                          return Center(
                                            child: Text('Failed to load image'), // Show an error message if image loading fails
                                          );
                                        },

                                      ),
                                    ),
                                  ),
                                );
                              }
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


}
