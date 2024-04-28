import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/font_weight.dart';

import '../../view_model/dash_board_vm/DashboardVM.dart';
class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});
  final DashboardVM controller = Get.put(DashboardVM());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
               Container(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(color: Colors.white70, width: 0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                      ), // BoxShadow
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Location",
                            style: TextStyle(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.sisxteen,
                              fontWeight: AllFontWeight.title_weight,
                            ),
                          ),
                          Spacer(),
                          Obx((){
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(controller.current_status.value
                                , // Observe the fetchingLocation value in the controller
                                style: TextStyle(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.ten,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(color: AllColors.primaryDark1,height: 1,),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Card(
                              child: SizedBox(
                                height: 15,
                                width: 15,
                                child: Icon(
                                  Icons.golf_course_outlined,
                                  color: AllColors.primaryDark1,
                                  size: 10,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Latitude :",
                            style: TextStyle(
                              color: AllColors.blackColor,
                              fontSize: AllFontSize.twelve,
                              fontWeight: AllFontWeight.bodyeight,
                            ),
                          ),
                          Spacer(),
                          Obx(() {
                            return  Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(DashboardVM.currentLat.value.toString(), // Observe currentLat
                                style: TextStyle(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.ten,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Card(
                              child: SizedBox(
                                height: 15,
                                width: 15,
                                child: Icon(
                                  Icons.local_attraction,
                                  color: AllColors.primaryDark1,
                                  size: 10,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Longitude :",
                            style: TextStyle(
                              color: AllColors.blackColor,
                              fontSize: AllFontSize.twelve,
                              fontWeight: AllFontWeight.bodyeight,
                            ),
                          ),
                          Spacer(),
                          Obx((){
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(DashboardVM.currentLng.value.toString(), // Observe currentLng
                                style: TextStyle(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.ten,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
