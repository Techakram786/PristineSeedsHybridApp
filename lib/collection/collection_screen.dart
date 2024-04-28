import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/view_model/collection_vm/collectionVm.dart';
import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../resourse/routes/routes_name.dart';

class CollectionListScreen extends StatelessWidget  {
  CollectionListScreen({super.key});

  final CollectionViewModal collectionVmController = Get.put(CollectionViewModal());
  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //Get.back();
        Get.offAllNamed(RoutesName.homeScreen);
        //  Get.toNamed(RoutesName.homeScreen);
        return true;
      },
      child: Scaffold(
        body:  Container(
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
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text('Collection List',
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
                          collectionVmController.collectionGetRefressUi();
                        },
                      ),*/
                    ActionChip(
                      elevation: 2,
                      padding: EdgeInsets.all(7),
                      backgroundColor: AllColors.primaryDark1,
                      shadowColor: Colors.black,
                      shape: StadiumBorder(
                          side: BorderSide(color: AllColors.primaryliteColor)),
                      //CircleAvatar
                      label: Text(
                          'Add',
                          style: GoogleFonts.poppins(
                            color: AllColors.customDarkerWhite,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w600,
                          )),
                      onPressed: () {
                        Get.offAllNamed(RoutesName.collectionCreate);
                      }, //Text
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Visibility(
                  visible: collectionVmController.loading.value,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.primaryliteColor,
                  ),
                );
              }),

              Container(
                  child:   Obx(() {
                    return bindListView(context);
                  })
              ),
            ],
          ),
        ),

      ),
    );
  }
  Widget bindListView(context){

    if (collectionVmController.collection_list.value.isNotEmpty && collectionVmController.collection_list.value.length > 0) {
      return Obx(() {
        return  Expanded(
          child: ListView.separated(
            //controller: plantingPageController.scrollController,
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) => Divider(height: .05, color: AllColors.primaryDark1,),
              shrinkWrap: true,
              itemCount: collectionVmController.collection_list.value.length,
              itemBuilder: (BuildContext context, int index) {
                return bindPendingListView(context, index);
              }),
        );
      },

      );
    }
    else {
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
  Widget bindPendingListView(context, int position) {
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 4, top: 4),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 5, right: 5),
         onTap: () {
           collectionVmController.viewHeaderLineData(collectionVmController.collection_list[position]);
        },
        title:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                'Collection code : ${collectionVmController.collection_list[position].collectioncode ?? ''}',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w600,
                  fontSize: AllFontSize.fourtine,
                )),
          ],
        ),

        subtitle: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Name : ${collectionVmController.collection_list[position].partyname ?? ''}${'('}${collectionVmController.collection_list[position].chqddrtgsno ?? ''}${')'}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  )),
              Text(
                  'Bank : ${collectionVmController.collection_list[position].bank ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  )),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Remark : ${collectionVmController.collection_list[position].remark ?? ''}',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w400,
                        fontSize: AllFontSize.twelve,
                      )),
                  Text(
                      ' ${collectionVmController.collection_list[position].date ?? ''}',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w400,
                        fontSize: AllFontSize.twelve,
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



