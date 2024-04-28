import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../resourse/routes/routes_name.dart';
import '../../view_model/notification_vm/NotificationViewModel.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  NotificationVM notification_pageController = Get.put(NotificationVM());
  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    if (notification_pageController != null) {
      notification_pageController.getNotificationList('get', '');
    }
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RoutesName.homeScreen);
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
                padding: EdgeInsets.only(
                    left: 10, right: 10, bottom: 0, top: 25),
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
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Notification",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Visibility(visible:notification_pageController.loading.value?true:false ,
                    child: Container(
                      margin: EdgeInsets.only(top: 1),
                      child: LinearProgressIndicator(
                        color: AllColors.primaryliteColor,
                        backgroundColor: AllColors.primaryDark1,
                      ),
                    ));
              },),
              SizedBox(
                height: size.height * .001,
              ),
              Obx(() {
                return notification_pageController
                    .notification_list.isNotEmpty &&
                    notification_pageController
                        .notification_list.length >
                        0 &&
                    notification_pageController
                        .notification_list[0].condition ==
                        'True'
                    ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListView.separated(
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => Divider(
                          height: .05,
                          color: AllColors.primaryDark1,
                        ),
                        shrinkWrap: true,
                        itemCount: notification_pageController
                            .notification_list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BindListView(context, index);
                        }),
                  ),
                )
                    : Center(
                  child: Text(
                    'No Record Found',
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w700),
                  ),
                );
              }),
              Divider(
                height: 2,
                color: AllColors.blackColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  BindListView(BuildContext context, int index) {
    return Obx(() => ListTile(
      onTap: () {
        notification_pageController.setSelectedIndex(index);
        if(notification_pageController.notification_list[index].acknowledgement==0){
          notification_pageController.acknowledgement_id.value=notification_pageController.notification_list[index].id!;
          notification_pageController.getNotificationList("acknowledgement", notification_pageController.acknowledgement_id.value.toString());
        }else{
          if(notification_pageController.notification_list[index].acknowledgement!>0)
            notification_pageController.flag.value=='';
        }
      },


      tileColor: notification_pageController.notification_list[index].acknowledgement==0
          ? AllColors.skyBlue // Change the color as needed
          : AllColors.whiteColor,

      title: Row(
        children: [
          Text("NO: ", style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen,
              )
          ),
          Container(
            width: size.width*.5,
            child: Text(
                notification_pageController
                    .notification_list[index].documentno ??
                    '',
                //overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.sisxteen,
                )),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              child: Text("${notification_pageController
                  .notification_list[index].message ?? ''}",
                  //overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w600,
                    fontSize: AllFontSize.fourtine,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${notification_pageController
                    .notification_list[index].documenttype ?? ''}",
                    //overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w400,
                      fontSize: AllFontSize.twelve,
                    )),
                Text("${notification_pageController
                    .notification_list[index].createdon ?? ''}",
                    //overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w400,
                      fontSize: AllFontSize.twelve,
                    )),
              ],
            )
          ],
        ),
      ),
      leading: Container(
        height: 70,
        width: 56,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: AllColors.primaryDark1
            ,border: Border.all(color: AllColors.primaryDark1,width: 1)),
        child:  bindImage(index),
      ),
    ),
    );
  }
  bindImage(int index) {
    int serialNumber = index+1;
    if (notification_pageController.notification_list[index].documentno !=
        null && notification_pageController.notification_list[index] != "") {
      return Stack(
        children: [
          Center(
            child: Container(
              width: 90,
              height: 90,
              child: CircleAvatar(
                backgroundColor: AllColors.primaryliteColor,
                child: Text(serialNumber.toString(),
                    style: GoogleFonts.poppins(
                        fontWeight:FontWeight.w500,
                        fontSize: AllFontSize.twentee,
                        color: AllColors.primaryDark1)),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 25,
            top: 38,
            child: Obx(() {
              return  Visibility(visible: notification_pageController.notification_list[index].acknowledgement!>0?
              false:true,
                child: Icon(Icons.notifications
                  ,color: AllColors.primaryDark1,),
              );
            },
            ),
          )
        ],
      );
    }
    else{
      return CircleAvatar(
        backgroundColor:  AllColors.primaryDark1,
        child: Text("No",style: GoogleFonts.poppins(
            fontWeight:FontWeight.w500,
            fontSize: AllFontSize.twentee,
            color: AllColors.primaryDark1) ),
      );
    }
  }
}
