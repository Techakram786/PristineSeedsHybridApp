
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../resourse/routes/routes_name.dart';
import '../../view_model/seed_dispatch_vm/seed_dispatch_vm.dart';

class SeedDispatchListScreen extends StatelessWidget{
  SeedDispatchListScreen({Key? key}) : super(key: key);
  final SeedDispatch_VM seedDispatch_VM_Controller = Get.put(SeedDispatch_VM());
  ScrollController _scrollController = ScrollController();
  Size size = Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          //Get.toNamed(RoutesName.homeScreen);
          Get.offAllNamed(RoutesName.homeScreen);
          //Navigator.pop(context);
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
                        child: Text('Seed Dispatch Note',
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twentee,
                                fontWeight: FontWeight.w700)),
                      ),
                      Spacer(),
                      ActionChip(
                        elevation: 2,
                        padding: EdgeInsets.all(2),
                        backgroundColor: AllColors.primaryDark1,
                        shadowColor: Colors.black,
                        shape: StadiumBorder(
                            side: BorderSide(color: AllColors.primaryliteColor)),
                        //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                        //CircleAvatar
                        label: Text(
                            'Add',
                            style: GoogleFonts.poppins(
                              color: AllColors.customDarkerWhite,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600,
                            )),
                        onPressed: () {
                          seedDispatch_VM_Controller.resetAllHeaderFields();
                          seedDispatch_VM_Controller.seeDispatchLocationGet();
                          seedDispatch_VM_Controller.getSupervisor();
                          Get.toNamed(RoutesName.seedDispatchHeaderCreate);
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
                  decoration: BoxDecoration(
                    color: AllColors.lightgreyColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx((){
                        return  Padding(
                          padding: const EdgeInsets.all(10.0),
                          child:  ActionChip(
                            elevation: 1,
                            tooltip: "Pending",
                            backgroundColor: AllColors.grayColor,
                            //avatar: Icon(Icons.arrow_forward, color: plantingPageController.status.value=='0'? AllColors.primaryDark1:AllColors.primaryliteColor),
                            shape: StadiumBorder(
                                side: BorderSide(color:seedDispatch_VM_Controller.status==0? AllColors.primaryDark1:AllColors.primaryliteColor)),
                            label: Text('Pending',
                                style: GoogleFonts.poppins(
                                  color: seedDispatch_VM_Controller.status==0? AllColors.primaryDark1:AllColors.primaryliteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600,
                                )
                            ),
                            onPressed: () {
                              seedDispatch_VM_Controller.status.value=0;
                              seedDispatch_VM_Controller.seed_dispatch_get_header_list.clear();
                              seedDispatch_VM_Controller.seedDispatchHeaderGet(0, "", seedDispatch_VM_Controller.status.value);
                              //showConfirmDiscardDialog(context,"Do You Want To Discard Header?","Header Discard",plantingLineDetailsPageController.planting_header_list[0].code,null);
                            },
                          ),
                          /*InkWell(
                            child:  Text('Pending',
                              softWrap: false,
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontWeight: FontWeight.w700,
                                  fontSize: AllFontSize.fourtine),
                            ),
                            onTap: (){
                              plantingPageController.status.value='0';
                              plantingPageController.plantingHeaderGetRefressUi('');
                            },
                          ),*/);
                      }),
                      Obx((){
                        return  Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ActionChip(
                            elevation: 1,
                            tooltip: "Complete",
                            backgroundColor: AllColors.grayColor,
                            //avatar: Icon(Icons.arrow_forward, color:plantingPageController.status.value=='1'? AllColors.primaryDark1:AllColors.primaryliteColor),
                            shape: StadiumBorder(
                                side: BorderSide(color: seedDispatch_VM_Controller.status==1? AllColors.primaryDark1:AllColors.primaryliteColor)),
                            label: Text('Complete',
                                style: GoogleFonts.poppins(
                                  color: seedDispatch_VM_Controller.status==1? AllColors.primaryDark1:AllColors.primaryliteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600,
                                )
                            ),
                            onPressed: () {
                              seedDispatch_VM_Controller.status.value=1;
                              seedDispatch_VM_Controller.seed_dispatch_get_header_list.clear();
                              seedDispatch_VM_Controller.seedDispatchHeaderGet(0,"",seedDispatch_VM_Controller.status.value);
                            },
                          ),
                        );
                      }),
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
        int total_page= (seedDispatch_VM_Controller.total_rows/seedDispatch_VM_Controller.rowsPerPage).toInt();
        if((seedDispatch_VM_Controller.total_rows%seedDispatch_VM_Controller.rowsPerPage)>0)
          total_page+=1;
        if(seedDispatch_VM_Controller.pageNumber+1!=total_page){
          seedDispatch_VM_Controller.seedDispatchHeaderGet(seedDispatch_VM_Controller.pageNumber+1,'',seedDispatch_VM_Controller.status.value);
          seedDispatch_VM_Controller.pageNumber+=1;
        }
      }
    });
    if (seedDispatch_VM_Controller.seed_dispatch_get_header_list.value.isNotEmpty &&
        seedDispatch_VM_Controller.seed_dispatch_get_header_list.value.length > 0) {
      return Expanded(
        child: ListView.separated(
            controller:_scrollController,
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(height: .05, color: AllColors.primaryDark1,),
            shrinkWrap: true,
            itemCount: seedDispatch_VM_Controller.seed_dispatch_get_header_list.value.length,
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
    var Date = StaticMethod.convertDateFormat1(seedDispatch_VM_Controller.seed_dispatch_get_header_list[position].date!);
    return InkWell(
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 5, right: 5),
        onTap: () {
          print('cliked$position');
          //print(seedDispatch_VM_Controller.seed_dispatch_get_header_list[position].dispatchno);
          seedDispatch_VM_Controller.seedDispatchHeaderLineDetail(seedDispatch_VM_Controller.seed_dispatch_get_header_list[position].dispatchno!);
        },
        title:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                'Dispatch No. : ${seedDispatch_VM_Controller.seed_dispatch_get_header_list[position].dispatchno ?? ''}',
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
              Text('Location :',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  )),
              Text(
                  '${seedDispatch_VM_Controller.seed_dispatch_get_header_list[position].locationname ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.twelve,
                  ))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Transporter :',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  )),
              Text(
                  '${seedDispatch_VM_Controller.seed_dispatch_get_header_list[position].transporter ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.twelve,
                  ))
            ]),
            Row(
              children: [
                Text('Truck No. :',style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w400,
                  fontSize: AllFontSize.twelve,
                )),
                Spacer(),
                Text('${seedDispatch_VM_Controller.seed_dispatch_get_header_list[position].trucknumber ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}
