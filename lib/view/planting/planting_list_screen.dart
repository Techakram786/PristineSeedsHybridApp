import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../resourse/routes/routes_name.dart';
import '../../view_model/planting_vm/planting_vm.dart';

class PlantingListScreen extends StatelessWidget {
  PlantingListScreen({Key? key}) : super(key: key);
  PlantingVM plantingPageController = Get.put(PlantingVM());
  Size size = Get.size;
  Future<bool> onWillPop() async {
    Get.offAllNamed(RoutesName.homeScreen);
    return false; // Prevent the default back behavior
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: onWillPop,
      child: DefaultTabController(
        length: 2,
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
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text('Planting List',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.twentee,
                                  fontWeight: FontWeight.w700)),
                        ),
                        Spacer(),
                        IconButton(
                          icon:const  Icon(Icons.refresh),
                          tooltip: "Refresh List Data",
                          onPressed: () {
                           // plantingPageController.plantingHeaderGetRefressUi('','');
                            plantingPageController.plantingHeaderGetRefressUi('');
                          },
                        ),
                        ActionChip(
                          elevation: 2,
                          padding: EdgeInsets.all(2),
                          backgroundColor: AllColors.primaryDark1,
                          shadowColor: Colors.black,
                          shape: StadiumBorder(
                              side: BorderSide(color: AllColors.primaryliteColor)),
                          avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                          //CircleAvatar
                          label: Text(
                              'Add',
                              style: GoogleFonts.poppins(
                                color: AllColors.customDarkerWhite,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w600,
                              )),
                          onPressed: () {
                            plantingPageController.getSupervisor();
                            plantingPageController.resetAllHeaderFields();
                            plantingPageController.productionLocationGet();

                          }, //Text
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    return Visibility(
                      visible: plantingPageController.loading.value,
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
                                  side: BorderSide(color:plantingPageController.status.value=='0'? AllColors.primaryDark1:AllColors.primaryliteColor)),
                              label: Text('Pending',
                                  style: GoogleFonts.poppins(
                                    color: plantingPageController.status.value=='0'? AllColors.primaryDark1:AllColors.primaryliteColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600,
                                  )
                              ),
                              onPressed: () {
                                plantingPageController.status.value='0';
                                plantingPageController.plantingHeaderGetRefressUi('');
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
                                 side: BorderSide(color: plantingPageController.status.value=='1'? AllColors.primaryDark1:AllColors.primaryliteColor)),
                             label: Text('Complete',
                                 style: GoogleFonts.poppins(
                                   color: plantingPageController.status.value=='1'? AllColors.primaryDark1:AllColors.primaryliteColor,
                                   fontSize: AllFontSize.fourtine,
                                   fontWeight: FontWeight.w600,
                                 )
                             ),
                             onPressed: () {
                               plantingPageController.status.value='1';
                               plantingPageController.plantingHeaderGetRefressUi('');
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
              )),
        ),
      ),
    );
  }

  Widget ListBindUi(BuildContext context) {

    return Expanded(
      child: TabBarView(
        children: [
          // Content for Tab 1
          Container(child: Obx(() {
            return BindPagginationListView(context);
          })),
          // Content for Tab 2
          Container(child: Obx(() {
            return BindPagginationListView(context);
          })),
        ],
      ),
    );
  }
  //todo listview bind
  Widget BindPagginationListView(context) {
    ScrollController _scrollController = ScrollController();
    _scrollController!.addListener(() {
      try {
        if (_scrollController!.position.pixels ==
            _scrollController!.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (plantingPageController.total_rows / plantingPageController.rowsPerPage).toInt();
          if ((plantingPageController.total_rows % plantingPageController.rowsPerPage) > 0)
            total_page += 1;

          print(
              "last index ${plantingPageController.pageNumber} ${plantingPageController.total_rows} ${plantingPageController.rowsPerPage} ${total_page}");

          if (plantingPageController.pageNumber + 1 != total_page) {
            plantingPageController.plantingHeaderGet(plantingPageController.pageNumber + 1, '');
            plantingPageController.pageNumber += 1;
          }
        }
      }catch(e){
        print('Exception: '+e.toString());
      }
    });
    if (plantingPageController.planting_header_get_list.value.isNotEmpty &&
        plantingPageController.planting_header_get_list.value.length > 0) {
      return Expanded(
        child: ListView.separated(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(height: .05, color: AllColors.primaryDark1,),
            shrinkWrap: true,
            itemCount: plantingPageController.planting_header_get_list.value.length,
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
    var plantingDate = StaticMethod.convertDateFormat1(plantingPageController
        .planting_header_get_list[position].plantingDate!);
    return InkWell(
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 5, right: 5),
        onTap: () {
            plantingPageController.plantingHeaderGetDetails(
                plantingPageController.planting_header_get_list[position].code!);
        },
        title:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                'Planting No : ${plantingPageController.planting_header_get_list[position].code ?? ''}',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.sisxteen,
                )),
            Text(plantingDate ?? '',
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
              Text('Organizer :',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  )),
              Text(
                  '${plantingPageController.planting_header_get_list[position].organizerName ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.twelve,
                  ))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Location Centre :',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  )),
              Text(
                  '${plantingPageController.planting_header_get_list[position].productionCenterLoc ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.twelve,
                  ))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Season :',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  )),
              Text(
                  '${plantingPageController.planting_header_get_list[position].seasonName ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.twelve,
                  ))
            ]),
            Row(
              children: [

                Text('Sowing Acres :',style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w400,
                  fontSize: AllFontSize.twelve,
                )),
              //todo ritik comment....

              /*  Text(
                    'Sowing Acres : ${plantingPageController.planting_header_get_list[position].totalSowingAreaInAcres ?? ''}',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w400,
                      fontSize: AllFontSize.twelve,
                    )),*/
                Spacer(),
                Text(plantingPageController.planting_header_get_list[position].totalSowingAreaInAcres.toString(),
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w400,
                      fontSize: AllFontSize.twelve,
                    ),
                )
                //todo ritik comment....

                /*Text(plantingDate ?? '',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w400,
                      fontSize: AllFontSize.twelve,
                    )),*/

              ],
            ),
          ],
        ),
      ),
    );
  }
}
