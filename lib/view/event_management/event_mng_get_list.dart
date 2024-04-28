import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/view_model/event_management_view_modal/event_mg_vm.dart';

import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../models/event_management_modal/event_type_modal.dart';
import '../../resourse/routes/routes_name.dart';

class EventManagementListScreen extends StatelessWidget{
  EventManagementListScreen({Key? key}) : super(key: key);
  final EventManagementViewModal event_mng_vm = Get.put(EventManagementViewModal());
  Size size = Get.size;
  Future<bool> onWillPop() async {
    Get.offAllNamed(RoutesName.homeScreen);
    return true; // Prevent the default back behavior
  }
  ScrollController _scrollController = ScrollController();
  static String _displayEventType(EventTypeModal option) =>
      option.eventtype!;
  @override
  Widget build(BuildContext context) {
    //seedDispatch_VM_Controller.seedDispatchHeaderGet();
    return WillPopScope(
        onWillPop: onWillPop,

        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //event_mng_vm.resetAllcreateMngFields();
                showFilterBottomSheet(context);

            },
            child: Icon(Icons.filter_alt_sharp, color: AllColors.whiteColor,),
            backgroundColor: AllColors.primaryDark1,),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Container(
            width: double.infinity,
            height: size.height,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 25),
                  decoration: BoxDecoration(boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 3.0,
                        offset: Offset(0.0, 0.55))
                  ], color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          height: size.height * 0.09,
                          child: CircleBackButton(
                            press: () {
                              Get.toNamed(RoutesName.homeScreen);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Text('Event Management',
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twentee,
                                fontWeight: FontWeight.w700)),
                      ),
                      Spacer(),
                      /* IconButton(
                        icon:const  Icon(Icons.refresh),
                        tooltip: "Refresh List Data",
                        onPressed: () {
                          // plantingPageController.plantingHeaderGetRefressUi('','');
                          plantingPageController.plantingHeaderGetRefressUi('','0');
                        },
                      ),*/
                      ActionChip(
                        elevation: 2,
                        padding: EdgeInsets.all(2),
                        backgroundColor: AllColors.primaryDark1,
                        shadowColor: Colors.black,
                        shape: StadiumBorder(
                            side: BorderSide(color: AllColors.primaryliteColor)),
                        avatar:
                        Icon(Icons.add, color: AllColors.customDarkerWhite),
                        //CircleAvatar
                        label: Text(
                            'Add',
                            style: GoogleFonts.poppins(
                              color: AllColors.customDarkerWhite,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600,
                            )),
                        onPressed: () {
                          event_mng_vm.resetAllcreateMngFields();
                         // event_mng_vm.getEventType();
                         // print('radha create...........');
                          Get.toNamed(RoutesName.createEventMng);
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
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AllColors.lightgreyColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text('Pending',
                                  softWrap: false,
                                  style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: AllFontSize.fourtine),
                                ),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios,color: AllColors.primaryDark1,),
                          ],
                        ),
                        onTap: (){
                          event_mng_vm.pageNumber=0;
                          event_mng_vm.event_code_controller.clear();
                          event_mng_vm.date_controller.clear();
                          event_mng_vm.event_type_controller.clear();
                          event_mng_vm.item_group_code_controller.clear();
                          event_mng_vm.item_category_code_controller.clear();
                          event_mng_vm.farmer_code_controller.clear();
                          event_mng_vm.eventMngGetRefressUi('Pending');
                        },
                      ),
                      InkWell(
                        child: Container(
                          child: Row(children: [
                            Column(children: [
                              Text('Under Approval',
                                softWrap: false,
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AllFontSize.fourtine),
                              ),
                            ],),
                            Icon(Icons.arrow_forward_ios,color: AllColors.primaryDark1,),
                          ],),
                        ),
                        onTap: (){
                          event_mng_vm.pageNumber=0;
                          event_mng_vm.event_code_controller.clear();
                          event_mng_vm.date_controller.clear();
                          event_mng_vm.event_type_controller.clear();
                          event_mng_vm.item_group_code_controller.clear();
                          event_mng_vm.item_category_code_controller.clear();
                          event_mng_vm.farmer_code_controller.clear();
                          event_mng_vm.eventMngGetRefressUi('Completed');
                        },
                      ),
                      InkWell(
                        child: Row(
                          children: [
                            InkWell(
                              child: Column(children: [
                                /*Text('RS ${pageController.unpaid_header_amt}',
                                  softWrap: false,
                                  style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: AllFontSize.fourtine),
                                ),*/
                                Text('Approved',
                                  softWrap: false,
                                  style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: AllFontSize.fourtine),
                                ),
                              ],),

                            ),
                            Icon(Icons.arrow_forward_ios,color: AllColors.primaryDark1,),
                          ],
                        ),
                        onTap: (){
                          event_mng_vm.pageNumber=0;
                          event_mng_vm.event_code_controller.clear();
                          event_mng_vm.date_controller.clear();
                          event_mng_vm.event_type_controller.clear();
                          event_mng_vm.item_group_code_controller.clear();
                          event_mng_vm.item_category_code_controller.clear();
                          event_mng_vm.farmer_code_controller.clear();
                          event_mng_vm.eventMngGetRefressUi('Approved');
                        },
                      )
                    ],
                  ),
                ),

                Divider(height: 2,
                  color: AllColors.primaryliteColor,),
                Container(
                    child:   Obx(() {
                      return BindPagginationListView(context);
                    })
                ),
              ],
            ),
          ),
        ));
  }
  Widget BindPagginationListView(context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // You have reached the end of the list
        int total_page= (event_mng_vm.total_rows/event_mng_vm.rowsPerPage).toInt();
        if((event_mng_vm.total_rows%event_mng_vm.rowsPerPage)>0)
          total_page+=1;

        //     print("last index ${pageNumber} ${total_rows} ${seedDispatch_VM_Controller.rowsPerPage} ${total_page}");

        if(event_mng_vm.pageNumber+1!=total_page){
          event_mng_vm.eventMngHeaderGet(event_mng_vm.pageNumber+1);
          event_mng_vm.pageNumber+=1;
        }
      }
    });
    if (event_mng_vm.event_mng_get_list.value.isNotEmpty &&
        event_mng_vm.event_mng_get_list.value.length > 0) {
      return Expanded(
        child: ListView.separated(
            controller: event_mng_vm.scrollController,
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(height: .05, color: AllColors.primaryDark1,),
            shrinkWrap: true,
            itemCount: event_mng_vm.event_mng_get_list.value.length,
            itemBuilder: (BuildContext context, int index) {
              return BindPendingListView(context, index);
            }),
      );
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            'No Record Found.',
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.twentee,
                fontWeight: FontWeight.w700),
          ),
        ),
      );
    }
  }
  Widget BindPendingListView(context, int position) {
    var Date = StaticMethod.convertDateFormat1(event_mng_vm.event_mng_get_list[position].eventdate!);
    return InkWell(
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 5, right: 5),
        onTap: () {
          print('cliked$position');
          //print(seedDispatch_VM_Controller.seed_dispatch_get_header_list[position].dispatchno);
          event_mng_vm.createEventMng('',event_mng_vm.event_mng_get_list[position].eventcode!);


          //print('evenenttttttt..........${event_mng_vm.event_mng_get_list[position].eventcode}');


        },
        title:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                'Event Code : ${event_mng_vm.event_mng_get_list[position].eventcode ?? ''}',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.sisxteen,
                )),
            Text(Date ?? '',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w400,
                  fontSize: AllFontSize.twelve,
                )),
          ],
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Event desc :',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  )),
              Text(
                  '${event_mng_vm.event_mng_get_list[position].eventdesc ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.twelve,
                  ))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Event Type :',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  )),
              Text(
                  '${event_mng_vm.event_mng_get_list[position].eventtype ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.twelve,
                  ))
            ]),
            Row(
              children: [
                Text('Budget :',style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w400,
                  fontSize: AllFontSize.twelve,
                )),

                Spacer(),
                Text('${event_mng_vm.event_mng_get_list[position].eventbudget ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text('Farmer Code :',style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w400,
                  fontSize: AllFontSize.twelve,
                )),

                Spacer(),
                Text('${event_mng_vm.event_mng_get_list[position].farmercode ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text('Category Code :',style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w400,
                  fontSize: AllFontSize.twelve,
                )),

                Spacer(),
                Text('${event_mng_vm.event_mng_get_list[position].itemcategorycode ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  ),
                )

              ],
            ),
            Row(
              children: [
                Text('Group Code :',style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w400,
                  fontSize: AllFontSize.twelve,
                )),

                Spacer(),
                Text('${event_mng_vm.event_mng_get_list[position].itemgroupcode ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  ),
                )

              ],
            ),
            Row(
              children: [
                Text('Village :',style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w400,
                  fontSize: AllFontSize.twelve,
                )),
                Spacer(),
                Container(
                  width: size.width*.3,
                  child: Text('${event_mng_vm.event_mng_get_list[position].eventcovervillages ?? ''}',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w400,
                      fontSize: AllFontSize.twelve,
                    ),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  ),
                )

              ],
            ),
            Row(
              children: [
                Spacer(),
                Container(
                  width: size.width*.3,
                  child: Text('${event_mng_vm.event_mng_get_list[position].status ?? ''}',
                    style: GoogleFonts.poppins(
                      color: AllColors.redColor,
                      fontWeight: FontWeight.w400,
                      fontSize: AllFontSize.twelve,
                    ),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  ),
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
  //todo for filter dialog.............................
  void showFilterBottomSheet(BuildContext context){
    //event_mng_vm.date_controller.text=event_mng_vm.current_date.value;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure minimal height
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filter List",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.twentee,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Icon(Icons.cancel,color: AllColors.primaryDark1,),
                        ),
                      )
                    ],
                  ),
                ),
                Center(child: Divider(height: 1,color: AllColors.primaryDark1,)),

                Column(
                  children: [
                    TextField(
                      controller: event_mng_vm.event_code_controller,
                      decoration: InputDecoration(
                        labelText: 'Event Code',
                        hintText: 'Event Code',
                        hintStyle: GoogleFonts.poppins(
                          color: AllColors.lightblackColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.ten,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.sisxteen,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AllColors.primaryDark1), // Change the color to green
                        ),
                      ),
                      cursorColor: AllColors.primaryDark1,
                      onChanged: (value) {
                        // Handle the text field value changes if needed
                      },
                    ),
                    TextField(
                      controller: event_mng_vm.date_controller,
                      decoration: InputDecoration(
                        labelText: 'Select Date',
                        hintText: 'Select Date',
                        hintStyle: GoogleFonts.poppins(
                          color: AllColors.lightblackColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.ten,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.sisxteen,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AllColors.primaryDark1), // Change the color to green
                        ),
                      ),
                      cursorColor: AllColors.primaryDark1,
                      onTap: () async {
                        DateTime stating_date = new DateTime(1900);
                        DateTime ending_date = new DateTime(2200);
                        FocusScope.of(context).requestFocus(new FocusNode());
                        DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: stating_date,
                            lastDate: ending_date);
                        var outputFormat = DateFormat('yyyy-MM-dd');
                        if (date != null && date != "")
                          event_mng_vm.date_controller.text= outputFormat.format(date);
                        else
                          event_mng_vm.date_controller.text = "";
                      },
                      onChanged: (value) {
                        // Handle the text field value changes if needed
                      },
                    ),
                    TextField(
                      controller: event_mng_vm.event_type_controller,
                      decoration: InputDecoration(
                        labelText: 'Event type',
                        hintText: 'Event type',
                        hintStyle: GoogleFonts.poppins(
                          color: AllColors.lightblackColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.ten,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.sisxteen,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AllColors.primaryDark1), // Change the color to green
                        ),
                      ),
                      cursorColor: AllColors.primaryDark1,
                      onChanged: (value) {
                        // Handle the text field value changes if needed
                      },
                    ),
                    TextField(
                      controller: event_mng_vm.item_category_code_controller,
                      decoration: InputDecoration(
                        labelText: 'Item category code',
                        hintText: 'Item category code',
                        hintStyle: GoogleFonts.poppins(
                          color: AllColors.lightblackColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.ten,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.sisxteen,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AllColors.primaryDark1), // Change the color to green
                        ),
                      ),
                      cursorColor: AllColors.primaryDark1,
                      onChanged: (value) {
                        // Handle the text field value changes if needed
                      },
                    ),
                    TextField(
                      controller: event_mng_vm.item_group_code_controller,
                      decoration: InputDecoration(
                        labelText: 'Item group code',
                        hintText: 'Item group code',
                        hintStyle: GoogleFonts.poppins(
                          color: AllColors.lightblackColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.ten,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.sisxteen,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AllColors.primaryDark1), // Change the color to green
                        ),
                      ),
                      cursorColor: AllColors.primaryDark1,
                      onChanged: (value) {
                        // Handle the text field value changes if needed
                      },
                    ),
                    TextField(
                      controller: event_mng_vm.farmer_code_controller,
                      decoration: InputDecoration(
                        labelText: 'Farmer code',
                        hintText: 'Farmer code',
                        hintStyle: GoogleFonts.poppins(
                          color: AllColors.lightblackColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.ten,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.sisxteen,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AllColors.primaryDark1), // Change the color to green
                        ),
                      ),
                      cursorColor: AllColors.primaryDark1,
                      onChanged: (value) {
                        // Handle the text field value changes if needed
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.primaryDark,
                                      width: 1),
                                ),
                                backgroundColor: AllColors.whiteColor,
                                foregroundColor: AllColors.lightgreyColor),
                            onPressed: () {
                              Get.back();
                              //event_mng_vm.status.value="";
                              event_mng_vm.eventMngHeaderGet(event_mng_vm.pageNumber);
                              //Get.toNamed(RoutesName.eventMngGetList);
                            },
                            child: Text(
                              'Submit',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.sisxteen,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.redColor, width: 1),
                                ),
                                backgroundColor: AllColors.whiteColor,
                                foregroundColor: AllColors.lightgreyColor),
                            onPressed: () {
                              //Get.back();
                              event_mng_vm.status.value="Pending";
                              event_mng_vm.event_code_controller.clear();
                              event_mng_vm.date_controller.clear();
                              event_mng_vm.event_type_controller.clear();
                              event_mng_vm.item_group_code_controller.clear();
                              event_mng_vm.item_category_code_controller.clear();
                              event_mng_vm.farmer_code_controller.clear();
                              event_mng_vm.eventMngHeaderGet(event_mng_vm.pageNumber);
                            },
                            child: Text(
                              'Reset',
                              style: GoogleFonts.poppins(
                                  color: AllColors.redColor,
                                  fontSize: AllFontSize.sisxteen,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}