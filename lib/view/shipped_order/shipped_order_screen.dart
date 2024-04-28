import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/view_model/orders_vm/orders_vm.dart';
import 'package:pristine_seeds/view_model/shipped_order_vm/shipped_order_vm.dart';

import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../resourse/routes/routes_name.dart';



class ShippedOrderScreen extends StatelessWidget {
  ShippedOrderScreen({super.key});

  Size size = Get.size;
  ShippedOrderVm shippedOrderController = Get.put(ShippedOrderVm());
  OrdersVM ordersVM=Get.put(OrdersVM());

  Future<bool> onWillPop() async {
    Get.offAllNamed(RoutesName.homeScreen);
    return false; // Prevent the default back behavior
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
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
                              //Get.back();
                              Get.toNamed(RoutesName.homeScreen);
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                            "Shipped Order List",
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                Obx((){
                  return Visibility(
                    visible: shippedOrderController.loading.value?true:false,
                    child: Container(
                      margin: EdgeInsets.only(top: 1),
                      child: LinearProgressIndicator(
                        backgroundColor: AllColors.primaryDark1,
                        color: AllColors.ripple_green,
                      ),
                    ),
                  );
                }),
                Obx(() {
                  return  Expanded(
                        child: ListView.separated(
                          //controller: shippedOrderController.scrollController,
                            padding: EdgeInsets.zero,
                            separatorBuilder: (context, index) =>
                                Divider(
                                  height: .05,
                                  color: AllColors.primaryDark1,
                                ),
                            shrinkWrap: true,
                            itemCount: shippedOrderController.orderShippedData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return BindPendingListView(context, index);
                            }
                        ),
                      );
                }),
              ],
            )
        ),
      ),
    );
  }


  Widget BindPendingListView(context, int index) {
    var orderDate = StaticMethod.dateTimeToDate(shippedOrderController.orderShippedData[index].createdOn!);
    return InkWell(
      child: ListTile(
        onTap: () {
         /* shippedOrderController.orderNo.value=shippedOrderController.orderShippedData[index].orderNo ?? '';
          shippedOrderController.getShippedOrderData(shippedOrderController.orderShippedData[index].orderNo ?? '');*/
        },
        title:  Text('Order No. : ${shippedOrderController.orderShippedData[index]
            .orderNo ?? ''}',
            style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w700,
              fontSize: AllFontSize.sisxteen,
            )),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                shippedOrderController.orderShippedData[index].customerName ??
                    '',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                )),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('RS: ${shippedOrderController.orderShippedData[index]
                    .totalApprovePrice ?? ''}',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w300,
                      fontSize: AllFontSize.fourtine,
                    )),
                Text('${orderDate ?? ''}',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w300,
                      fontSize: AllFontSize.fourtine,
                    )),
              ],
            ),


          ],
        ),
        // leading: Text('Rs. 12000.00'),
        trailing: InkWell(
          onTap: (){
            dialogBoxopenForDetails(context, index);
          },
                child: CircleAvatar(
                  backgroundColor: AllColors.ripple_green,
                    child: Icon(Icons.remove_red_eye_rounded, size: 20,)
                )
        ),

      ),
    );
  }

  void dialogBoxopenForDetails(context, int index) {
    shippedOrderController.orderNo.value=shippedOrderController.orderShippedData[index].orderNo ?? '';
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("View Details.....",
                style: TextStyle(color: AllColors.primaryDark1,)),
            Text("(${ shippedOrderController.orderNo.value})",
                style: TextStyle(color: AllColors.blackColor, fontSize:AllFontSize.sisxteen)),
          ],
        ),
        content: Container(
          height: 100,
          child: Column(
            children: [
              Divider(height: .5, color: AllColors.lightgreyColor,),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  ordersVM.shippedstatus.value='Shipped';
                  ordersVM.getOrderHeaderDetails(shippedOrderController.orderNo.value, "Shipped Details");
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(Icons.remove_red_eye_rounded,
                        color: AllColors.primaryDark1, size: 20,),
                      SizedBox(width: 20,),
                      Text('View Order Details', style: TextStyle(color: AllColors
                          .primaryDark1),),
                    ],
                  ),
                ),
              ),
              Divider(height: .5, color: AllColors.lightgreyColor,),
              InkWell(
                onTap: () async {
                  shippedOrderController.getShippedOrderData(shippedOrderController.orderShippedData[index].orderNo ?? '');
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(Icons.remove_red_eye_rounded,
                        color: AllColors.primaryDark1, size: 20,),
                      SizedBox(width: 20,),
                      Text('View Invoice Details', style: TextStyle(color: AllColors
                          .primaryDark1),),
                    ],
                  ),
                ),
              ),
              Divider(height: .5, color: AllColors.lightgreyColor,),
            ],
          ),
        ),
      );
    });
  }

 /* Future<void> viewDetailsOfOrder(context, int position) async {
    Size size=Get.size;
    showModalBottomSheet(context: context,
      builder: (BuildContext context) {
        return  Container(
          width: double.infinity,
          height: size.height/2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      child: CircleBackButton(
                        press: () {
                          //Get.toNamed(RoutesName.homeScreen);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "Order Details",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.twentee,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Center(child: Divider(height: 1,color: AllColors.primaryDark1,)),
              // Obx(() {
              //  return
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: Column(
                      children: [
                                  Text(
                                    " Order No : ${shippedOrderController.orderShippedData[position].orderNo??''}",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text('Customer Name : ${shippedOrderController.orderShippedData[position].customerName??''}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w300

                                    ),
                                  ),
                                  Text(
                                    "Total Qty : ${shippedOrderController.orderShippedData[position].totalQty?? ''}",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    'In Kg : ${item.empname!}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w300

                                    ),
                                  ),


                                  Text(
                                    "Season :",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '${item.season!}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),


                                  Text(
                                    "Category Code :",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '${item.categorycode!}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),

                                  Text(
                                    "Item Group Code :",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    ' ${item.itemgroupcode!}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),


                                  Text(
                                    "Item No :",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    ' ${item.itemno!}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),

                                  Text(
                                    "Customer/Distributor :",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: size.width*.3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Tooltip(
                                        message:item.customerordistributor ?? '' ,
                                        child: Text(
                                          ' ${item.customerordistributor ?? ''}',
                                          style: GoogleFonts.poppins(
                                              color: AllColors.primaryDark1,
                                              fontSize: AllFontSize.fourtine,
                                              fontWeight: FontWeight.w300
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                    ),
                  ),
                ),
              ]),
          );

      },);
  }*/
}