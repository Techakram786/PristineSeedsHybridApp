import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/event_management_modal/event_approval_modal.dart';
import '../../models/event_management_modal/event_header_line_modal.dart';
import '../../repository/event_management_repo/Event_management_repo.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../session_management/session_management_controller.dart';

class EventApprovalViewModal extends GetxController {
  SessionManagement sessionManagement = SessionManagement();

  final _api = EventManagementRepository();
  RxBool loading = false.obs;
  String pending_count = "0";
  String rejected_count = "0";
  String approved_count = "0";
  var filter_date_controller = TextEditingController();
  var remarks_controller = TextEditingController();
  var typeAheadControllerEmployee = TextEditingController();
  String email_id = "";
  String selection_type='';

  List<EventApprovalModal> approver_list_data = [];
  RxList<EventHeaderLineMngModal> event_line_header_list = <EventHeaderLineMngModal>[].obs;
  Future<void> currentEventData(String doc_no) async {
    loading.value = true;

    Map data = {
    "event_code": doc_no,
    "email": email_id,
    };
    //print('print event code...........${eventCode}');


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
    Get.toNamed(RoutesName.eventAprovalHeaderLineDetail);
    } else {
    loading.value=false;
    event_line_header_list.value = [];
    //Utils.sanckBarError('False Message!', 'response is null'response[0].message.toString());
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
  Future<void> onInit() async {
    super.onInit();
    email_id = await sessionManagement.getEmail() ?? '';
    getApprovalList();
  }

  getApprovalList() {
    loading.value = true;
    Map<String, String> data = {
      "email": email_id,
      "filter_date": filter_date_controller.text.toString().isEmpty?"":filter_date_controller.text.toString(),
      "filter_created_by": typeAheadControllerEmployee.text.toString().isEmpty?"":typeAheadControllerEmployee.text.toString(),
      "approve_status": selection_type
    };
    print("Selection Type........"+selection_type);
    //print('data-----------${data}');
    _api.getEventManagementApprover(data, sessionManagement).then((value) {
      print("value---------${value}");
      try {
        List<EventApprovalModal> approver_list = (json.decode(value) as List)
            .map((i) => EventApprovalModal.fromJson(i))
            .toList();
       // print("approvelist---------------${approver_list[0].eventcode}");
        if (approver_list!=null && approver_list.length>0 && approver_list[0].condition == "True") {
          print("sUCCESS");
          approver_list_data = approver_list;
          pending_count=approver_list_data[0].pendingcount!;
          approved_count=approver_list_data[0].approvecount!;
          rejected_count=approver_list_data[0].rejectedcount!;
        } else {
          print("False..");
          approver_list_data = [];
          pending_count=approver_list[0].pendingcount!;
          //print(approver_list[0].pendingcount);
          approved_count=approver_list[0].approvecount!;
          //print(approver_list[0].approvecount);
          rejected_count=approver_list[0].rejectedcount!;
          //print(approver_list[0].rejectedcount);

        }
      } catch (e) {
        print("Exception...${e}");
        approver_list_data = [];
        pending_count = "0";
        approved_count = "0";
        rejected_count = "0";
      }
    }).onError((error, stackTrace) {
      print("Error...${error}");
      approver_list_data = [];
      pending_count = "0";
      approved_count = "0";
      rejected_count = "0";
      Utils.sanckBarError('Api Exception onError', error.toString());
    }).whenComplete(() => {loading.value = false});
  }
  List<String> imageUrls = [];
  List<HeaderImage?>? headerImag=[];
  RxInt selectedindex=0.obs;
  RxInt headeriindex=0.obs;
  void showLineImagesPopup(BuildContext context, List<EventHeaderLineMngModal?> linesList,int position, String tag) {
    Size size = Get.size;
    imageUrls = [];
    headerImag=[];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        try{
          if(tag=='View')
            {
              if(linesList[0]!.headerimages!.isNotEmpty)
              {
                headerImag=linesList[0]!.headerimages;
              }
            }
          else
            {

              if(linesList[0]!.lines![position]!.imageurl1!.isNotEmpty){
                imageUrls.add(linesList[0]!.lines![position]!.imageurl1!);
              }
              if(linesList[0]!.lines![position]!.imageurl2!.isNotEmpty){
                imageUrls.add(linesList[0]!.lines![position]!.imageurl2!);
              }
              if(linesList[0]!.lines![position]!.imageurl3!.isNotEmpty){
                imageUrls.add(linesList[0]!.lines![position]!.imageurl3!);
              }
              if(linesList[0]!.lines![position]!.imageurl4!.isNotEmpty){
                imageUrls.add(linesList[0]!.lines![position]!.imageurl4!);
              }

            }

         /* if(linesList[position]!.imageurl2!.isNotEmpty){
            imageUrls.add(linesList[position]!.imageurl2!);
          }*/
         /* if(linesList[position]!.imageurl3!.isNotEmpty){
            imageUrls.add(linesList[position]!.imageurl3!);
          }
          if(linesList[position]!.imageurl4!.isNotEmpty){
            imageUrls.add(linesList[position]!.imageurl4!);
          }*/
        }catch(e){
          print(e);
        }
        RxString tagg=''.obs;
        if(tag=="View")
          {
            tagg.value='Header';
          }
        else
          {
            tagg.value='Line';
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
                  title: Text('$tagg Images', style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700
                  ),),
                  backgroundColor: Colors.transparent,
                  elevation: 0,

                ),
                SizedBox(height: size.height*.2,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            width: size.width * .97,
                            height: size.height * .5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              border: Border.all(color: AllColors.primaryliteColor, width: .5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: imgaes(context, tag),
                              /*Image.network(
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
                              ),*/
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0,bottom: 6.0),
                          child: Divider(color: AllColors.primaryliteColor,height: 1,),
                        ),//
                        SizedBox(height: 20),
                        Visibility(
                          visible: tag=='View'?false:true,
                          child: Container(
                            height: 100,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: imageUrls.length,
                                itemBuilder: (BuildContext context, int index) {
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
                        ),
                        Visibility(
                          visible: tag=='View'?true:false,
                          child: Container(
                            height: 100,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: headerImag!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  HeaderImage? currentImage = headerImag![headeriindex.value];
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
                                          currentImage!.fileurl!,
                                          //headerImag![index],
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

  void markApproveReject(String event_code, String status) {
    loading.value = true;
    Map data={
      "event_code": event_code,
      "event_status": status,
      "reason": remarks_controller.text,
      "email": email_id
    };
    _api.eventApprovalRejected(data, sessionManagement).then((value) {
      print("value---------${value}");
      try {
        List<EventHeaderLineMngModal> approver_list = (json.decode(value) as List)
            .map((i) => EventHeaderLineMngModal.fromJson(i))
            .toList();
        // print("approvelist---------------${approver_list[0].eventcode}");
        if (approver_list!=null && approver_list.length>0 && approver_list[0].condition == "True") {
          Utils.sanckBarSuccess('Success!', approver_list[0].message.toString());
          selection_type=status;
          getApprovalList();
          //selection_type=event_line_header_list[0].status!;
          Get.toNamed(RoutesName.eventApproval);

        } else {
          print("False..");
         // approver_list_data = [];
            Utils.sanckBarSuccess('Success!', approver_list[0].message.toString());

        }
      } catch (e) {
        print("Exception...${e}");
      //  approver_list_data = [];


      }
    }).onError((error, stackTrace) {
      print("Error...${error}");
    //  approver_list_data = [];

      Utils.sanckBarError('Api Exception onError', error.toString());
    }).whenComplete(() => {loading.value = false});


  }



 Widget imgaes(context, String tag) {
   //HeaderImage? currentImage = headerImag![headeriindex.value];
    if(tag=='View')
      {
                return Image.network(
                  (headerImag!.length>0 && headerImag!.isNotEmpty  ) ? headerImag![0]!.fileurl!:'https://dev4.pristinefulfil.com/assets/images/vendor_panel_img/mylogo.png', // Use the actual URL from your HeaderImage object
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
                );


      }
    else
      {
       return Image.network(
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
                              );
      }
 }

}