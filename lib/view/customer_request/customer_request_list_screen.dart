import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pristine_seeds/constants/app_colors.dart';
import 'package:pristine_seeds/models/customer_request/customer_create_model.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';

import '../../components/back_button.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../view_model/customer_request_vm/customer_request_vm.dart';

class CustomerRequestList extends StatelessWidget {
  CustomerRequestList({super.key});

  final customer_request_controller=Get.put(CustomerViewModel());
  ScrollController _scrollController = ScrollController();
  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RoutesName.homeScreen);
        return true;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showFilterBottomSheet(context);
          },
          child: Icon(Icons.filter_alt, color: AllColors.whiteColor,),
          backgroundColor: AllColors.primaryDark1,
        ),
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
                      child: Text('Customer Request List  ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.twentee,
                              fontWeight: FontWeight.w700)),
                    ),
                    Spacer(),
                    Obx(() {
                      return  Visibility(
                        visible: customer_request_controller.status=="Completed"?false:true,
                        child: ActionChip(
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
                          customer_request_controller.flag.value="Create";
                            Get.toNamed(RoutesName.customerRequestCreate);
                            customer_request_controller.resetAllFields();

                          }, //Text
                        ),
                      );
                    },
                      //child:
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Visibility(
                  visible: customer_request_controller.isLoading.value,
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
                              side: BorderSide(color:customer_request_controller.status=="Pending"? AllColors.primaryDark1:AllColors.primaryliteColor)),
                          label: Text('Pending',
                              style: GoogleFonts.poppins(
                                color: customer_request_controller.status=="Pending"? AllColors.primaryDark1:AllColors.primaryliteColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w600,
                              )
                          ),
                          onPressed: () {
                            customer_request_controller.name_controller.clear();
                            customer_request_controller.request_nocontroller.clear();
                            customer_request_controller.status.value="Pending";
                            customer_request_controller.getCustomerRequestList(customer_request_controller.status.value);
                          },
                        ),
                       );
                    }),
                    Obx((){
                      return  Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ActionChip(
                          elevation: 1,
                          tooltip: "Complete",
                          backgroundColor: AllColors.grayColor,
                          shape: StadiumBorder(
                              side: BorderSide(color: customer_request_controller.status=="Completed"? AllColors.primaryDark1:AllColors.primaryliteColor)),
                          label: Text('Complete',
                              style: GoogleFonts.poppins(
                                color: customer_request_controller.status=="Completed"? AllColors.primaryDark1:AllColors.primaryliteColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w600,
                              )
                          ),
                          onPressed: () {
                            customer_request_controller.name_controller.clear();
                            customer_request_controller.request_nocontroller.clear();
                            customer_request_controller.status.value="Completed";
                            customer_request_controller.getCustomerRequestList(customer_request_controller.status.value);
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
                    return BindCustomerListView(context);
                  })
              ),
            ],
          ),

        ),
      ),
    );
  }

  Widget BindCustomerListView(context) {
    if (customer_request_controller.customer_request_list.value.isNotEmpty &&
        customer_request_controller.customer_request_list.value.length > 0) {
      return Expanded(
        child: ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(height: .05, color: AllColors.primaryDark1,),
            shrinkWrap: true,
            itemCount: customer_request_controller.customer_request_list.value.length,
            itemBuilder: (BuildContext context, int index) {
              return BindCustomerRequestListView(context, index);
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

  Widget BindCustomerRequestListView(context, int position) {
  //  var Date = StaticMethod.convertDateFormat1(customer_request_controller.customer_request_list[position].date!);
    return InkWell(
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 5, right: 5),
        onTap: () {


          if(customer_request_controller.customer_request_list[position].status=='Pending')
            {
              customer_request_controller.flag.value="Update";
            }
          else{
            customer_request_controller.flag.value="View";
          }
          customer_request_controller.request_no.value=customer_request_controller.customer_request_list[position].requestno!;
          customer_request_controller.viewCustomerApiHitListDetails(customer_request_controller.customer_request_list[position].requestno!);
         // customer_request_controller.viewRequestDetails(customer_request_controller.customer_request_list[position],customer_request_controller.flag.value);
        },
        title:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                'Request No : ${customer_request_controller.customer_request_list[position].requestno.toString() ?? ''}',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.sisxteen,
                )),

          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Name :',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  )),
              Text(
                  '${customer_request_controller.customer_request_list[position].name ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.twelve,
                  ))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Contact :',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  )),
              Text(
                  '${customer_request_controller.customer_request_list[position].contact.toString() ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.twelve,
                  ))
            ]),
            Row(
              children: [
                Text('Region :',style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w400,
                  fontSize: AllFontSize.twelve,
                )),
                Spacer(),
                Text('${customer_request_controller.customer_request_list[position].region.toString() ?? ''}',
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
                Text('Zone :',style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w400,
                  fontSize: AllFontSize.twelve,
                )),
                Spacer(),
                Text('${customer_request_controller.customer_request_list[position].zone.toString() ?? ''}',
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
                Text('Customer Type :',style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w400,
                  fontSize: AllFontSize.twelve,
                )),
                Spacer(),
                Text('${customer_request_controller.customer_request_list[position].customertype.toString() ?? ''}',
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
                Text('Vendor Type :',style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w400,
                  fontSize: AllFontSize.twelve,
                )),
                Spacer(),
                Text('${customer_request_controller.customer_request_list[position].vendortype.toString() ?? ''}',
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
                Text('Territory_type :',style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w400,
                  fontSize: AllFontSize.twelve,
                )),
                Spacer(),
                Text('${customer_request_controller.customer_request_list[position].territorytype.toString() ?? ''}',
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
                Text('Seed_Licence_No :',style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w400,
                  fontSize: AllFontSize.twelve,
                )),
                Spacer(),
                Text('${customer_request_controller.customer_request_list[position].seedlicenseno.toString() ?? ''}',
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

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure minimal height
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          "Filter",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        customer_request_controller.getCustomerRequestList(customer_request_controller.status.value);
                        /*customer_list_pageController.getCustomerList(
                            customer_list_pageController.pageNumber);*/
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Icon(
                          Icons.cancel,
                          color: AllColors.primaryDark1,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Divider(
                      height: 3, color: AllColors.primaryDark1, thickness: 1),
                ),
                Column(
                  children: [
                    TextField(
                      controller: customer_request_controller.request_nocontroller,
                      decoration: InputDecoration(
                        labelText: 'Request No.',
                        hintText: 'Request No.',
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
                              color: AllColors
                                  .primaryDark1), // Change the color to green
                        ),
                      ),
                      cursorColor: AllColors.primaryDark1,
                      onChanged: (value) {
                        customer_request_controller.request_nocontroller.text=value;
                      },
                    ),
                    TextField(
                      controller: customer_request_controller.name_controller,
                      decoration: InputDecoration(
                        labelText: "Name",
                        hintText: 'Name',
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
                              color: AllColors
                                  .primaryDark1), // Change the color to green
                        ),
                      ),
                      cursorColor: AllColors.primaryDark1,
                      onChanged: (value) {
                        customer_request_controller.name_controller.text=value;

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
                                      color: AllColors.primaryDark, width: 1),
                                ),
                                backgroundColor: AllColors.whiteColor,
                                foregroundColor: AllColors.lightgreyColor),
                            onPressed: () {
                               customer_request_controller.getCustomerRequestList(customer_request_controller.status.value);
                      /*         customer_request_controller.name_controller.clear();
                               customer_request_controller.request_nocontroller.clear();*/
                               Get.back();

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
                              customer_request_controller.name_controller.clear();
                              customer_request_controller.request_nocontroller.clear();
                              customer_request_controller.getCustomerRequestList(customer_request_controller.status.value);
                             // Get.back();
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
