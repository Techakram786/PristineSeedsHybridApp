
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/seed_dispatch/seed_dispatch_line_get.dart';
import '../../resourse/routes/routes_name.dart';
import '../../view_model/seed_dispatch_vm/seed_dispatch_vm.dart';

class SeedDispatchLineDetailScreen extends StatelessWidget{
  SeedDispatchLineDetailScreen({super.key});
  final SeedDispatch_VM seedDispatch_VM_Controller = Get.put(SeedDispatch_VM());
  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async  {
        Get.toNamed(RoutesName.seedDispatchList);
        //Navigator.pop(context);
        return true;

      },
      child:Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          width: double.infinity,
          height: size.height,
          child: Column(
            children: [
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
                            seedDispatch_VM_Controller.seedDispatchHeaderGetRefressUi('',0);
                            Get.toNamed(RoutesName.seedDispatchList);
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Seed Dispatch Note "/*(${seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].dispatchNo != null ? seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].dispatchNo.toString() : ''})*/,
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
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

                      label: Text(seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].status == 1 ?'View':'Upload',
                          style: GoogleFonts.poppins(
                            color: AllColors.customDarkerWhite,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w600,
                          )),
                      avatar: Icon(Icons.camera_alt_outlined, color: AllColors.customDarkerWhite),
                      onPressed: () {
                        List<Lines?>? line_list =seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].lines;
                        print(line_list);

                        seedDispatch_VM_Controller.showLineImagesPopup(context);

                      }, //Text
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Visibility(
                  visible: seedDispatch_VM_Controller.loading.value,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.primaryliteColor,
                  ),
                );
              }),
              Container(
                padding:
                EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 1.0,
                      offset: Offset(0.0, 0.00))
                ], color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [
                        Text(
                          'Dispatch No.: ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text(
                          seedDispatch_VM_Controller
                              .seed_dispatch_header_line_list[0].dispatchNo
                              .toString(),
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryliteColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                      ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [
                        Text(
                          'Supervisor: ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text(
                          seedDispatch_VM_Controller
                              .seed_dispatch_header_line_list[0].supervisor
                              .toString(),
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryliteColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                      ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Date: ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Tooltip(
                          message:  seedDispatch_VM_Controller
                              .seed_dispatch_header_line_list[0].date
                              .toString(),
                          child: Container(
                            width: size.width*.5,
                            child: Text(
                              textAlign: TextAlign.end,
                              seedDispatch_VM_Controller
                                  .seed_dispatch_header_line_list[0].date
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryliteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Transporter: ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text(
                          seedDispatch_VM_Controller
                              .seed_dispatch_header_line_list[0].transporter
                              .toString(),
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryliteColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Truck No.: ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Tooltip(
                          message: seedDispatch_VM_Controller
                              .seed_dispatch_header_line_list[0].truckNumber
                              .toString(),
                          child: Container(
                            width: size.width * .5,
                            child: Text(
                              seedDispatch_VM_Controller
                                  .seed_dispatch_header_line_list[0].truckNumber
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryliteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Organizer Code: ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Tooltip(
                          message: seedDispatch_VM_Controller.
                          seed_dispatch_header_line_list[0].organizerCode.toString(),
                          child: Container(
                            width: size.width*.5,
                            child: Text(
                              seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].organizerCode.toString(),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryliteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Organizer Name: ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Tooltip(
                          message: seedDispatch_VM_Controller.
                          seed_dispatch_header_line_list[0].organizerName.toString(),
                          child: Container(
                            width: size.width*.5,
                            child: Text(
                              seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].organizerName.toString(),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryliteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Freight Amount: ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Tooltip(
                          message: seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].frightamount.toString(),
                          child: Container(
                            width: size.width * .5,
                            child: Text(
                              seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].frightamount.toString(),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryliteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx((){
                        return Visibility(
                          visible: seedDispatch_VM_Controller.seed_dispatch_header_line_list.isNotEmpty &&
                              seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].status! <= 0
                              ? true
                              : false,

                          child: ActionChip(
                            elevation: 1,
                            tooltip: "Discard Header",
                            backgroundColor: AllColors.grayColor,
                            avatar: Icon(Icons.delete, color: AllColors.redColor),
                            shape: StadiumBorder(
                                side: BorderSide(color: AllColors.redColor)),
                            label: Text('Discard',
                                style: GoogleFonts.poppins(
                                  color: AllColors.redColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600,
                                )
                            ),
                            onPressed: () {
                              showConfirmDiscardDialog(context,"Do You Want To Discard Header?","Header Discard",seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].dispatchNo);
                            },
                          ),
                        );
                      }),

                      Obx(() {
                        return Visibility(
                          visible: seedDispatch_VM_Controller.seed_dispatch_header_line_list.isNotEmpty &&
                              seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].lines!.length > 0 &&
                              seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].status! <= 0
                              ? true
                              : false,
                          child: ActionChip(
                            elevation: 1,
                            tooltip: "Header Complete",
                            backgroundColor: AllColors.grayColor,
                            avatar: Icon(Icons.post_add,
                                color: AllColors.primaryDark1),
                            shape: StadiumBorder(
                                side: BorderSide(
                                    color: AllColors.primaryliteColor)),
                            label: Text('Complete',
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600,
                                )),
                            onPressed: () {
                              showConfirmCompleteDialog(context,"Do You Want To Complete(${seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].dispatchNo})?","Complete seed Dispatch",seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].dispatchNo);

                            },
                          ),);
                      }),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 2,
                color: AllColors.primaryliteColor,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(' Dispatch Line Details: ',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w600,
                          )),
                      Obx(() {
                        return Visibility(
                            visible: seedDispatch_VM_Controller.seed_dispatch_header_line_list.isNotEmpty &&
                                seedDispatch_VM_Controller
                                    .seed_dispatch_header_line_list[0].status! < 1 ? true : false,
                            child: ActionChip(
                              elevation: 1,
                              tooltip: "Add Dispatch Line",
                              backgroundColor: AllColors.grayColor,
                              avatar: Icon(Icons.add,
                                  color: AllColors.primaryDark1),
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: AllColors.primaryliteColor)),
                              label: Text('Add Line',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600,
                                  )),
                              onPressed: () {
                                seedDispatch_VM_Controller
                                    .resetAllLineFields();
                              //  seedDispatch_VM_Controller.getOrganizers();
                                seedDispatch_VM_Controller.getItemCategoryMst();
                                seedDispatch_VM_Controller.getProductionLotNo();
                               // seedDispatch_VM_Controller.getFarmer();

                                Get.toNamed(RoutesName.seedDispatchLineCreate);
                              },
                            ));
                      }),
                    ],
                  ),
                ),
              ),
              Obx(() {
                return
                  bindListLayout();
              }),
            ],
          )),
    ) ,



    );




  }
  showConfirmDiscardDialog(BuildContext context,String message,String flag,String? planting_no) {
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
                // Cancel button pressed
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor),),
            ),
            TextButton(
              onPressed: () {
                seedDispatch_VM_Controller.discardHeader();
                Navigator.of(context).pop();
              },
              child: Text("Ok",style: TextStyle(color: AllColors.primaryDark1),),
            ),
          ],
        );
      },
    );
  }

  Widget bindListLayout() {
    if (seedDispatch_VM_Controller.seed_dispatch_header_line_list.isEmpty ||
        seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].lines ==
            null ||
        seedDispatch_VM_Controller
            .seed_dispatch_header_line_list[0].lines!.isEmpty) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(
            'No Records Found.',
            style: TextStyle(fontSize: 20, color: AllColors.primaryColor),
          ),
        ),
      );
    }
    else {
      Size size = Get.size;
      return Expanded(
        child: Container(
          //height: size.height - 170,
          child: ListView.separated(
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) => Divider(
                height: 2,
                color: AllColors.primaryDark1,
              ),
              itemCount: seedDispatch_VM_Controller
                  .seed_dispatch_header_line_list[0].lines!.length,
              itemBuilder: (context, index) {
                return BindListView(context, index, seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].dispatchNo);
              }),
        ),
      );
    }
  }
  Widget BindListView(context, int position, String? dispatchNo) {
    return InkWell(
      child: ListTile(
        onTap: () {

          seedDispatch_VM_Controller.openBottomSheetDialog(context,position);
          //seedDispatch_VM_Controller.deleteLine(context,positio);

        },
        subtitle: Row(
          children: [
            Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border:
                    Border.all(color: AllColors.primaryDark1, width: 1)),
                child: bindImage(position)),
            SizedBox(width: size.width * .01),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Line No: ${ seedDispatch_VM_Controller
                      .seed_dispatch_header_line_list[0].lines![position].lineNo.toString()}',
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  width: size.width * .5,
                  child: Text(
                      'Farmer Code: ${ seedDispatch_VM_Controller
                          .seed_dispatch_header_line_list[0].lines![position].farmerCode ?? ''}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w500,
                        fontSize: AllFontSize.fourtine,
                      )),
                ),
                Text(
                    'Lot No: ${ seedDispatch_VM_Controller
                        .seed_dispatch_header_line_list[0].lines![position].lotNumber.toString() ?? ''}',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.fourtine,
                    )),
                /* Text(
                    'Sowing Date: ${(plantingLineDetailsPageController.planting_header_list[0].lines![position].sowingDateMale) != null ? plantingLineDetailsPageController.planting_header_list[0].lines![position].sowingDateMale :plantingLineDetailsPageController.planting_header_list[0].lines![position].sowingDateOther}',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.fourtine,
                    )),*/
              ],
            ),
          ],
        ),

        trailing: Visibility(
          visible: seedDispatch_VM_Controller
              .seed_dispatch_header_line_list[0].status! < 1 ? true : false,
          child: GestureDetector(onTap: () {
            showConfirmDiscardLineDialog(context,"Do You Want To Discard Line?","Line Discard",seedDispatch_VM_Controller.seed_dispatch_header_line_list[0].dispatchNo,seedDispatch_VM_Controller
                .seed_dispatch_header_line_list[0].lines![position].lineNo.toString());
          },child: Icon(Icons.delete, color: AllColors.redColor)),
        ),
      ),
    );
  }

  showConfirmDiscardLineDialog(BuildContext context,String message,String flag,String? dispatchNo, String lineNo) {
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
                // Cancel button pressed
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor),),
            ),
            TextButton(
              onPressed: () {
                seedDispatch_VM_Controller.deleteLine(context,dispatchNo,lineNo);
                Navigator.of(context).pop();
                // Navigator.of(context).pop();
              },
              child: Text("Ok",style: TextStyle(color: AllColors.primaryDark1),),
            ),
          ],
        );
      },
    );
  }

  Widget bindImage(int position) {
    if (seedDispatch_VM_Controller
        .seed_dispatch_header_line_list[0].lines![position].farmerName !=
        null &&
        seedDispatch_VM_Controller
            .seed_dispatch_header_line_list[0].lines![position].farmerName !=
            "")
      return CircleAvatar( // Set the desired radius
        backgroundColor: AllColors.whiteColor,
        backgroundImage: AssetImage('assets/images/leaves_img.png'),
        /*child: Text(
    plantingLineDetailsPageController
        .planting_header_list[0].lines![position].organizerName![0]
        .toString(),
    style: GoogleFonts.poppins(
        color: AllColors.primaryDark1, // Text color
        fontWeight: FontWeight.w700,
        fontSize: 40),
  ),*/
      );
    else
      return CircleAvatar(

        backgroundColor: AllColors.primaryliteColor,
        /* child: Text(
          'NO',
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1, // Text color
            fontWeight: FontWeight.w700,
          ),
        ),*/
      );
  }

  showConfirmCompleteDialog(BuildContext context,String message,String flag,String? dispatchNo) {
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
                // Cancel button pressed
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor),),
            ),
            TextButton(
              onPressed: () {
                seedDispatch_VM_Controller.seedDispatchHeaderComplete(dispatchNo);
                Navigator.of(context).pop();
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1),),
            ),
          ],
        );
      },
    );
  }

}
