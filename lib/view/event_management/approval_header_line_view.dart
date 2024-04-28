import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/back_button.dart';
import '../../components/default_button.dart';
import '../../components/default_button_red.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../models/check_in/check_in_response.dart';
import '../../models/event_management_modal/event_header_line_modal.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../../view_model/event_management_view_modal/event_approval_view_modal.dart';
import '../../view_model/event_management_view_modal/event_mg_vm.dart';

class EventApproveHeaderLineDetails extends StatelessWidget {
  EventApproveHeaderLineDetails({super.key});

  final EventApprovalViewModal eventApprovalController =
  Get.put(EventApprovalViewModal());
  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    var orderDate = StaticMethod.dateTimeToDate(eventApprovalController.event_line_header_list[0].createdon!);
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: size.height,
          child: Column(
            children: [
              //todo header container
              Container(
                padding:
                EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 25),
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 0.55))
                ], color: Colors.white),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: size.height * 0.09,
                        child: CircleBackButton(
                          press: () {
                            Get.back();
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Header Details",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.twentee,
                        ),
                      ),
                    ),
                    Spacer(),
                    ActionChip(
                      elevation: 2,
                      padding: EdgeInsets.all(2),
                      backgroundColor: AllColors.primaryDark1,
                      shadowColor: Colors.black,
                      shape: StadiumBorder(
                          side: BorderSide(color: AllColors.primaryliteColor)),

                      label: Text('View',
                          style: GoogleFonts.poppins(
                            color: AllColors.customDarkerWhite,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w600,
                          )),
                      avatar: Icon(Icons.camera_alt_outlined, color: AllColors.customDarkerWhite),
                      onPressed: () {
                        if(eventApprovalController.event_line_header_list[0].headerimages!.isNotEmpty &&
                            eventApprovalController.event_line_header_list[0].headerimages!.length>0)
                          {
                            eventApprovalController.showLineImagesPopup(context, eventApprovalController.event_line_header_list, 0, "View");
                          }else{
                          Utils.sanckBarError('Images', 'No Image Uploaded.');
                        }

                      }, //Text
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Visibility(
                  visible: eventApprovalController.loading.value,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.primaryliteColor,
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Event Code :",
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.sisxteen,
                              fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            eventApprovalController.event_line_header_list[0].eventcode.toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Event Type :",
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.sisxteen,
                              fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            eventApprovalController.event_line_header_list[0].eventtype.toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Category Code :",
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.sisxteen,
                              fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            eventApprovalController.event_line_header_list[0].itemcategorycode.toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Budget :",
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.sisxteen,
                              fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            eventApprovalController.event_line_header_list[0].eventbudget.toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Actual Dealer :",
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.sisxteen,
                              fontWeight: FontWeight.w700),
                        ),

                        Spacer(),
                        Container(
                          width: size.width*.5,
                          child: Text(
                            overflow: TextOverflow.ellipsis, // Truncate long text with an ellipsis
                            maxLines: 1,
                            textAlign: TextAlign.end,
                              eventApprovalController.event_line_header_list[0].actualdealers.toString()?? '',
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Actual Distributor: ",
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.sisxteen,
                              fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            eventApprovalController.event_line_header_list[0].actualdistributers.toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Total Amount :",
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.sisxteen,
                              fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            eventApprovalController.event_line_header_list[0].totalexpenseamount.toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Event Create :",
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.sisxteen,
                              fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            eventApprovalController.event_line_header_list[0].createdon.toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 0.5,color: AllColors.primaryliteColor,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Total Expense:",
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.sisxteen,
                              fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        Obx(
                              () {
                            return Text(
                                eventApprovalController.event_line_header_list[0].totalexpenseamount.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w300),
                            );
                          },

                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(right: 8.0),
                          child: Text(
                            '',
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ],),
                    Divider(height: 0.5,color: AllColors.primaryliteColor,),
                  ],
                ),
              ),
              Divider(height: 0.5,color: AllColors.primaryliteColor,),
              Expanded(
                child: SingleChildScrollView(
                      child: Column(children: [
                        bindListLayout(),
                      ]
                      ),
                    ),

              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Visibility(
                  visible:  (eventApprovalController.selection_type == "Approved" || eventApprovalController.selection_type == "Rejected") ?
                  false:true,
                  child: Container(
                    // padding: EdgeInsets.only(bottom: 80),
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width*.4,
                          child:  DefaultButton(
                            text: "Approve",
                            press: () {
                              //
                              showConfirmCompleteDialog(context,"Do You Want To Approve?",eventApprovalController.event_line_header_list[0].eventcode!,"Approved");

                            },
                            //  loading: viewCartController.loading.value,
                          ),
                        ),
                        Container(
                          width:size.width*.4,
                          child: DefaultButtonRed(
                            text: "Reject",
                            press: () {
                              showRemarkDialog(context,eventApprovalController.event_line_header_list[0].eventcode!,"Rejected");

                            },
                            //loading: viewCartController.loading.value,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget bindListLayout() {
    List<Line?>? line_list =eventApprovalController.event_line_header_list[0].lines!;
    if(line_list==null || line_list!.isEmpty){
      return Container(
        padding: EdgeInsets.all(10),
        child: Text('No Records Found.',style: TextStyle(fontSize: 20, color: AllColors.primaryColor),),
      );
    }else{
      Size size = Get.size;
      return Container(
        // height: size.height*0.69,
        height: size.height*0.55,
        child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(
              height: .05,
              color: AllColors.primaryDark1,
            ),

            itemCount: line_list.length,
            itemBuilder: (context, index) {
              return BindListView(context,line_list, index);
            }),
      );
    }

  }

  Widget BindListView(context,List<Line?> linesList, int index) {
    return InkWell(
      child: ListTile(
        onTap: () {
          if(linesList[index]!.imagecount!>0){
            eventApprovalController.showLineImagesPopup(context,eventApprovalController.event_line_header_list,index, "");
          }
          else{
            Utils.sanckBarError('Images', 'This Item Has No Image');
          }
        },
        title: Text("Event Name : " +linesList[index]!.expensetype!,style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,fontWeight: FontWeight.w500
        ),),
        subtitle: Container(
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Amount: "+linesList[index]!.amount!.toString()!,
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w500,
                    fontSize: AllFontSize.twelve,
                  )),
              Text('Images: '+linesList[index]!.imagecount!.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w500,
                    fontSize: AllFontSize.twelve,
                  )),
            ],
          ),
        ),
        //leading: bindAvatar(line_list[0].lines!),
        trailing: Tooltip(
            message: 'Line Attachment',
            child: Icon(Icons.attachment,color: AllColors.primaryDark1,size: 25,)),




      ),
    );
  }


  void showRemarkDialog(BuildContext context, String event_code,String status) {
    //Navigator.pop(context);
    eventApprovalController.remarks_controller.clear();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please Enter Remarks...",style: TextStyle(color: AllColors.primaryDark1,
          fontSize: AllFontSize.sisxteen)),
          content: TextFormField(
            controller: eventApprovalController.remarks_controller,
            decoration: InputDecoration(labelText: "Remark",labelStyle: TextStyle(color: AllColors.primaryDark1,),
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
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor)),
            ),
            TextButton(
              onPressed: () {
                //Navigator.of(context).pop();
                if(eventApprovalController.remarks_controller.text.isNotEmpty){
                  eventApprovalController.markApproveReject(event_code,status,);
                }
                else
                  Utils.sanckBarError('Remark!', 'Please Enter Remarks');
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1)),
            ),
          ],
        );
      },
    );
  }

  showConfirmCompleteDialog(BuildContext context,String message, String event_code, String status){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm...",style: TextStyle(color: AllColors.primaryDark1)),
          content:   Text(
            message,
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor),),
            ),
            TextButton(
              onPressed: () {
                eventApprovalController.markApproveReject(event_code,status,);
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1),),
            ),
          ],
        );
      },
    );
  }


}
