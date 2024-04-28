import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/back_button.dart';
import '../../components/default_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/event_management_modal/event_header_line_modal.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../../view_model/event_management_view_modal/event_mg_vm.dart';

class EventLineDetails extends StatelessWidget {
  EventLineDetails({super.key});

  var date = '';
  final EventManagementViewModal event_mng_vm =
      Get.put(EventManagementViewModal());
  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()  async {
        event_mng_vm
            .eventMngHeaderGet(event_mng_vm.pageNumber);
        Get.toNamed(RoutesName.eventMngGetList);


            return true;
      },
        child: Scaffold(
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
                                event_mng_vm
                                    .eventMngHeaderGet(event_mng_vm.pageNumber);
                                Get.toNamed(RoutesName.eventMngGetList);
                              },
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "Event Management" /*(${event_mng_vm.event_line_header_list.isNotEmpty ? event_mng_vm.event_line_header_list[0].eventcode.toString() : ''})*/,
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            )),
                        Spacer(),
                        ActionChip(
                          elevation: 2,
                          padding: EdgeInsets.all(2),
                          backgroundColor: AllColors.primaryDark1,
                          shadowColor: Colors.black,
                          shape: StadiumBorder(
                              side: BorderSide(color: AllColors.primaryliteColor)),

                          label: Text( event_mng_vm.event_line_header_list[0].status ==
                              'Completed' ||
                              event_mng_vm.event_line_header_list[0].status ==
                                  'Rejected' ||
                              event_mng_vm.event_line_header_list[0].status ==
                                  'Approved'?'View':'Upload',
                              style: GoogleFonts.poppins(
                                color: AllColors.customDarkerWhite,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w600,
                              )),
                          avatar: Icon(Icons.camera_alt_outlined, color: AllColors.customDarkerWhite),
                          onPressed: () {
                            List<Line?>? line_list =event_mng_vm.event_line_header_list[0].lines!;

                            event_mng_vm.showLineImagesPopup(context);
                            //event_mng_vm.showLineImagesPopup(context,line_list);

                          }, //Text
                        ),
                      ],

                    ),
                  ),
                  Obx(() {
                    return Visibility(
                      visible: event_mng_vm.loading.value,
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
                              'Event Code: ',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Text(
                              event_mng_vm.event_line_header_list.isNotEmpty
                                  ? event_mng_vm
                                  .event_line_header_list[0].eventcode
                                  .toString()
                                  : '',
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryliteColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Category Code: ',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Text(
                              event_mng_vm.event_line_header_list.isNotEmpty
                                  ? event_mng_vm
                                  .event_line_header_list[0].itemcategorycode
                                  .toString()
                                  : '',
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryliteColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Budget: ',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Tooltip(
                              message:
                              event_mng_vm.event_line_header_list.isNotEmpty
                                  ? event_mng_vm
                                  .event_line_header_list[0].eventbudget
                                  .toString()
                                  : '',
                              child: Container(
                                width: size.width * .5,
                                child: Text(
                                  textAlign: TextAlign.end,
                                  event_mng_vm.event_line_header_list.isNotEmpty
                                      ? event_mng_vm
                                      .event_line_header_list[0].eventbudget
                                      .toString()
                                      : '',
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
                        Visibility(
                          visible: event_mng_vm.status.value=="Pending"?false:true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Actual Dealer: ',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Tooltip(
                                message:
                                event_mng_vm.event_line_header_list.isNotEmpty
                                    ? event_mng_vm
                                    .event_line_header_list[0].actualdealers
                                    .toString()
                                    : '',
                                child: Container(
                                  width: size.width * .5,
                                  child: Text(
                                    event_mng_vm.event_line_header_list.isNotEmpty
                                        ? event_mng_vm
                                        .event_line_header_list[0].actualdealers
                                        .toString()
                                        : '',
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
                        ),
                        Visibility(
                          visible: event_mng_vm.status.value=="Pending"?false:true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Actual Distributer: ',
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Tooltip(
                                message: event_mng_vm
                                    .event_line_header_list[0].actualdistributers
                                    .toString(),
                                child: Container(
                                  width: size.width * .5,
                                  child: Text(
                                    event_mng_vm
                                        .event_line_header_list[0].actualdistributers
                                        .toString(),
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
                        ),
                       /* Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Total expense amount ',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Tooltip(
                              message: event_mng_vm
                                  .event_line_header_list[0].totalexpenseamount
                                  .toString(),
                              child: Container(
                                width: size.width * .5,
                                child: Obx(
                                      () {
                                    return Text(
                                      event_mng_vm.event_line_header_list[0]
                                          .totalexpenseamount
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryliteColor,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w600),
                                    );
                                  },
                                  // child:
                                ),
                              ),
                            )
                          ],
                        ),*/
                      ],
                    ),
                  ),
                  /*Divider(
                height: 2,
                color: AllColors.primaryliteColor,
              ),*/
                  SizedBox(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        return Visibility(
                          visible: false,
                          child: Checkbox(
                            value: event_mng_vm.isAddExpense.value,
                            activeColor: AllColors.primaryDark1,
                            onChanged: (value) {
                              event_mng_vm.isAddExpense.value = value ?? false;
                            },
                          ),
                        );
                      }),
                     /* Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          'Add Event Expenses',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700),
                        ),
                      ),*/
                      SizedBox(
                        width: size.width * .6,
                      ),
                      Obx(
                            () {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Visibility(
                                visible: (event_mng_vm
                                    .event_line_header_list[0].status ==
                                    'Completed' ||
                                    event_mng_vm
                                        .event_line_header_list[0].status ==
                                        'Rejected' ||
                                    event_mng_vm
                                        .event_line_header_list[0].status ==
                                        'Approved')
                                    ? false
                                    : true,
                                child: DefaultButton(
                                  text: "Complete",
                                  press: () {
                                    if(event_mng_vm.event_line_header_list[0]
                                        .lines![positionLine]!.imagecount!<=0)
                                      {
                                        Utils.sanckBarError('Image Error', 'Please Upload Image in Vehicle');
                                      }
                                    else
                                      {
                                        showCompletekDialog(context);

                                      }
                                    print('Image ......${event_mng_vm.event_line_header_list[0]
                                        .lines![positionLine]!.imagecount!}');
                                    //event_mng_vm.eventMngComplete();
                                    //showCompletekDialog(context);
                                  },
                                  loading: event_mng_vm.loading.value,
                                ),
                              ),
                            ),
                          );
                        },
                        //  child:
                      ),
                      SizedBox(
                        width: size.width * .02,
                      )
                    ],
                  ),
                  Obx(() {
                    return Visibility(
                      visible: event_mng_vm.isAddExpense.value,
                      child: Column(
                        children: [
                          Divider(
                            color: AllColors.blackColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Expenses",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AllFontSize.fourtine,
                                  ),
                                ),
                                if (event_mng_vm.event_line_header_list.isNotEmpty)
                                  Text(
                                    '\u{20B9} ${event_mng_vm.event_line_header_list[0].totalexpenseamount! > 0 ? event_mng_vm.event_line_header_list[0].totalexpenseamount.toString() : "0.0"}',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.lightblackColor,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Divider(
                            color: AllColors.blackColor,
                          ),
                        ],
                      ),
                    );
                  }),
                  /*Obx(
                () =>*/
                  Visibility(
                    visible: true,
                    child: Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => Divider(
                          height: 0,
                          color: AllColors.whiteColor,
                        ),
                        itemCount: event_mng_vm.event_line_header_list[0].lines!.length,
                        itemBuilder: (context, index) => itemsWidget(index),
                      ),
                    ),
                  ),
                  // ),
                ],
              )),
        ),
    );








  }
 int positionLine=0;
  Widget itemsWidget(int index) {
    if(event_mng_vm.event_line_header_list[0].lines![index]!.expensetype=='Vehicle')
      {
        positionLine=index;
      }
    TextEditingController expenseController = TextEditingController();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width * .5,
                        child: Tooltip(
                          message: event_mng_vm.event_line_header_list[0]
                              .lines![index]!.expensetype
                              .toString(),
                          child: Text(
                            event_mng_vm.event_line_header_list[0]
                                .lines![index]!.expensetype
                                .toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Obx(
                        () {
                          return Text(
                              'Qty :${event_mng_vm.event_line_header_list[0].lines![index]!.quantity.toString()}',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700));
                        },
                        // child:
                      )
                    ],
                  ),
                  Container(
                      child: Obx(
                        () {
                          return Text(
                            '\u{20B9} ${event_mng_vm.event_line_header_list.isNotEmpty && event_mng_vm.event_line_header_list[0].lines != null && index >= 0 && index < event_mng_vm.event_line_header_list[0].lines!.length && event_mng_vm.event_line_header_list[0].lines![index]!.amount! > 0 ? event_mng_vm.event_line_header_list[0].lines![index]!.amount.toString() : "0.0"}',
                            style: GoogleFonts.poppins(
                              color: AllColors.lightblackColor,
                              fontSize: AllFontSize.sisxteen,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        },
                        //child:
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: SizedBox(
                      //width: size.width * 0.2,
                      child: Row(
                        children: [
                          Icon(
                            Icons.attachment,
                            size: 20,
                            color: AllColors.lightblackColor,
                          ),
                          SizedBox(width: size.width * .01),
                          Obx(
                            () {
                              return Text(
                                  event_mng_vm.event_line_header_list[0]
                                      .lines![index]!.imagecount
                                      .toString()
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                      color: AllColors.lightblackColor,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700));
                            },
                            //  child:
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              if (index != event_mng_vm.isExpend_line_posion.value) {
                event_mng_vm.isExpend.value = true;
              } else {
                event_mng_vm.isExpend.value = !event_mng_vm.isExpend.value;
              }
              event_mng_vm.isExpend_line_posion.value = index;
              event_mng_vm.expense_current_index = index;
              event_mng_vm.expenseController.text = event_mng_vm
                  .event_line_header_list[0].lines![index]!.quantity
                  .toString();

              event_mng_vm.total.value =
                  (double.parse(event_mng_vm.expenseController.text));
              //print('Double,,,,,,,${event_mng_vm.total}');

              event_mng_vm.Amount.value = (event_mng_vm.total.value *
                  event_mng_vm
                      .event_line_header_list[0].lines![index]!.rateunitcost!);
            },
          ),
          Obx(() {
            return Visibility(
              visible: (event_mng_vm.isExpend.value &&
                      event_mng_vm.isExpend_line_posion.value == index)
                  ? true
                  : false,
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            // Adjust the height of the line as needed
                            color: Colors.black, // Change the color of the line
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: Text(
                            "Files",
                            style: GoogleFonts.poppins(
                                fontSize: AllFontSize.sisxteen,
                                // Adjust the font size
                                fontWeight: FontWeight.w700,
                                color: AllColors
                                    .lightblackColor // Adjust the font weight
                                ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            // Adjust the height of the line as needed
                            color: Colors.black, // Change the color of the line
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Completed' ||
                                    event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Rejected' ||
                                    event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Approved') {
                                } else {
                                  event_mng_vm.expense_current_index = index;
                                  event_mng_vm.getFrontImage(
                                      'Expense', 'image_one');
                                }
                              },
                              child: DottedBorder(
                                color: Colors.grey,
                                strokeWidth: 2,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(8),
                                dashPattern: [10, 5, 10, 5],
                                child: Container(
                                  width: size.height * 0.1,
                                  height: 70,
                                  child: Visibility(
                                    visible: event_mng_vm.isImageSet.value,
                                    child: event_mng_vm.GetImageSection(
                                        index,
                                        event_mng_vm.event_line_header_list[0]
                                            .lines![index]!.local_image_path1,
                                        event_mng_vm.event_line_header_list[0]
                                            .lines![index]!.imageurl1),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * .04),
                            GestureDetector(
                              onTap: () async {
                                if (event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Completed' ||
                                    event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Rejected' ||
                                    event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Approved') {
                                } else {
                                  event_mng_vm.expense_current_index = index;
                                  event_mng_vm.getFrontImage(
                                      'Expense', 'image_two');
                                }
                              },
                              child: DottedBorder(
                                color: Colors.grey,
                                strokeWidth: 2,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(8),
                                dashPattern: [10, 5, 10, 5],
                                child: Container(
                                  width: size.height * 0.1,
                                  height: 70,
                                  //child: GetImageSection(index,checkInpageController.file_path2.value,checkInpageController.image_url1.value),
                                  child: Visibility(
                                    visible: event_mng_vm.isImageSet.value,
                                    child: event_mng_vm.GetImageSection(
                                        index,
                                        event_mng_vm.event_line_header_list[0]
                                            .lines![index]!.local_image_path2,
                                        event_mng_vm.event_line_header_list[0]
                                            .lines![index]!.imageurl2),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * .04),
                            GestureDetector(
                              onTap: () async {
                                if (event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Completed' ||
                                    event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Rejected' ||
                                    event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Approved') {
                                } else {
                                  event_mng_vm.expense_current_index = index;
                                  event_mng_vm.getFrontImage(
                                      'Expense', 'image_three');
                                }
                              },
                              child: DottedBorder(
                                color: Colors.grey,
                                strokeWidth: 2,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(8),
                                dashPattern: [10, 5, 10, 5],
                                child: Container(
                                  width: size.height * 0.1,
                                  height: 70,
                                  child: Visibility(
                                    visible: event_mng_vm.isImageSet.value,
                                    child: event_mng_vm.GetImageSection(
                                        index,
                                        event_mng_vm.event_line_header_list[0]
                                            .lines![index]!.local_image_path3,
                                        event_mng_vm.event_line_header_list[0]
                                            .lines![index]!.imageurl3),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * .04),
                            GestureDetector(
                              onTap: () async {
                                if (event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Completed' ||
                                    event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Rejected' ||
                                    event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Approved') {
                                } else {
                                  event_mng_vm.expense_current_index = index;
                                  event_mng_vm.getFrontImage(
                                      'Expense', 'image_four');
                                }
                              },
                              child: DottedBorder(
                                color: Colors.grey,
                                strokeWidth: 2,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(8),
                                dashPattern: [10, 5, 10, 5],
                                child: Container(
                                  width: size.height * 0.1,
                                  height: 70,
                                  child: Visibility(
                                    visible: event_mng_vm.isImageSet.value,
                                    child: event_mng_vm.GetImageSection(
                                        index,
                                        event_mng_vm.event_line_header_list[0]
                                            .lines![index]!.local_image_path4,
                                        event_mng_vm.event_line_header_list[0]
                                            .lines![index]!.imageurl4),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * .13,
                          child: TextFormField(
                            readOnly: (event_mng_vm
                                            .event_line_header_list[0].status ==
                                        "Completed" ||
                                    event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Rejected' ||
                                    event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Approved')
                                ? true
                                : false,
                            keyboardType: TextInputType.number,
                            controller: event_mng_vm.expenseController,

                            //initialValue: expenseController.toString(),
                            onChanged: (value) {
                              if (value.isEmpty) {
                                event_mng_vm.Amount.value = 0.0;
                              } else {
                                event_mng_vm.Amount.value =
                                    double.tryParse(value)! *
                                        event_mng_vm.event_line_header_list[0]
                                            .lines![index]!.rateunitcost!;
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.two,
                                  horizontal: AllFontSize.one),
                              hintText: 'Quan',
                              hintStyle: GoogleFonts.poppins(
                                  color: AllColors.lightblackColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: AllFontSize.sisxteen),
                              labelStyle: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontWeight: FontWeight.w700,
                                  fontSize: AllFontSize.sisxteen),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AllColors
                                        .primaryDark1), // Change the color to green
                              ),
                            ),
                            cursorColor: AllColors.primaryDark1,
                          ),
                        ),
                        Container(
                          child: Text(
                              '* ${event_mng_vm.event_line_header_list[0].lines![index]!.rateunitcost}  = ',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700)),
                        ),
                        Container(
                          width: 100,
                          child: Obx(() {
                            return Text(
                              event_mng_vm.Amount.value.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),
                            );
                          }),
                        ),
                        //Spacer(),
                        Container(
                          width: 100,
                          child: Visibility(
                            visible: (event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Completed' ||
                                    event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Rejected' ||
                                    event_mng_vm
                                            .event_line_header_list[0].status ==
                                        'Approved')
                                ? false
                                : true,
                            child: DefaultButton(
                              text: "Save",
                              press: () {
                                event_mng_vm.expense_line_save_DataApi(
                                    event_mng_vm.expenseController.text,
                                    event_mng_vm.event_line_header_list[0]
                                        .lines![index]!.lineno,
                                    event_mng_vm.event_line_header_list[0]
                                        .lines![index]!.expensetype,
                                    event_mng_vm
                                        .event_line_header_list[0].eventcode);
                              },
                              //loading: checkInpageController.loading.value,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
            // }
            //  return Text("Invalid index: $index");
          }),
        ],
      ),
    );
  }

  showCompletekDialog(BuildContext context) {
    //Navigator.pop(context);
    event_mng_vm.actual_farmers_controller.clear();
    event_mng_vm.actual_dealers_controller.clear();
    event_mng_vm.actual_distributers_controller.clear();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          // Set the shape to make it full-screen
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // Set the content of the dialog
          child: Container(
            // Set the dimensions of the dialog
            height: size.height * 0.4,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Fill Actual Detail',
                  style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      // Adjust the font size
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1),
                ),
                TextFormField(
                  controller: event_mng_vm.actual_farmers_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter farmers",
                    labelStyle: TextStyle(color: AllColors.primaryDark1),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AllColors.primaryDark1)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AllColors.primaryDark1)),
                  ),
                ),
                TextFormField(
                  controller: event_mng_vm.actual_dealers_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter dealers",
                    labelStyle: TextStyle(color: AllColors.primaryDark1),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AllColors.primaryDark1)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AllColors.primaryDark1)),
                  ),
                ),
                TextFormField(
                  controller: event_mng_vm.actual_distributers_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter distributer",
                    labelStyle: TextStyle(color: AllColors.primaryDark1),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AllColors.primaryDark1)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AllColors.primaryDark1)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 30.0),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AllColors.primaryDark1), // Set your desired color
                      ),
                      onPressed: () {
                        //Navigator.of(context).pop();
                        if (event_mng_vm.actual_distributers_controller.text
                                .isNotEmpty &&
                            event_mng_vm
                                .actual_farmers_controller.text.isNotEmpty &&
                            event_mng_vm
                                .actual_dealers_controller.text.isNotEmpty) {
                          event_mng_vm.eventMngComplete();
                        } else
                          Utils.sanckBarError(
                              'Complete!', 'Please fill all fields');
                        // Close the dialog
                      },
                      child: Text(
                        'Ok',
                        style: GoogleFonts.poppins(
                            color: AllColors.customDarkerWhite,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AllColors.primaryDark1)),
                      onPressed: () {
                        Navigator.pop(context);
                        // Close the dialog
                      },
                      child: Text('Cancel',
                          style: GoogleFonts.poppins(
                              color: AllColors.customDarkerWhite,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );

      },
    );
  }

}
