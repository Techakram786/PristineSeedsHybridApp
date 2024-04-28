

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/models/shipped_oeder_header/shipped_order_header_modal.dart';
import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../resourse/routes/routes_name.dart';
import '../../view_model/shipped_order_vm/shipped_order_vm.dart';

class ShippedOrderHeaderScreen extends StatelessWidget{
  ShippedOrderVm shippedOrderController = Get.put(ShippedOrderVm());

  Future<bool> onWillPop() async {
    Get.offAllNamed(RoutesName.shippedOrderScreen);
    return false; // Prevent the default back behavior
  }
  Size size=Get.size;

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
                              Get.toNamed(RoutesName.shippedOrderScreen);
                            },
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                                "Shipped Order Header List",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                )
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                                "(${shippedOrderController.orderNo.toString()})",
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.sisxteen,
                                  fontWeight: FontWeight.w700,
                                )
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return Visibility(
                    visible: shippedOrderController.loading.value,
                    child: Container(
                      margin: EdgeInsets.only(top: 1),
                      child: LinearProgressIndicator(
                        backgroundColor: AllColors.primaryDark1,
                        color: AllColors.ripple_green,
                        minHeight: 5,
                        value: 0,
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
                        itemCount: shippedOrderController.headerDataList.length,
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
    List<Sol> sol_list= shippedOrderController.headerDataList[index].sol ??  [];
    var orderDate = StaticMethod.dateTimeToDate(shippedOrderController.headerDataList[index].deliveryDate!);

    return ExpansionTile(
      tilePadding: EdgeInsets.all(10),
      title: Text(
        'Invoice No. : ${shippedOrderController.headerDataList[index].dcNo ?? ''}',
        style: GoogleFonts.poppins(
          color: AllColors.primaryDark1,
          fontWeight: FontWeight.w700,
          fontSize: AllFontSize.sisxteen,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transporter Name  : ${shippedOrderController.headerDataList[index].transporterName ?? ''}',
            style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.fourtine,
            ),
          ),
          Text(
            'Vehicle No. : ${shippedOrderController.headerDataList[index].truckNo ?? ''}',
            style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.fourtine,
            ),
          ),
          Text(
            'DC Qty. : ${shippedOrderController.headerDataList[index].totalLineQuantity ?? ''}',
            style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.fourtine,
            ),
          ),

          Text(
            'Delivery Date : ${orderDate}',
            style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.fourtine,
            ),
          ),
        ],
      ),
      children: List.generate(
        // Generate widgets for each item in the sol list
        shippedOrderController.headerDataList[index].sol?.length ?? 0,
            (solIndex) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description : ${shippedOrderController.headerDataList[index].sol?[solIndex]?.description ?? ''}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.fourtine,
                        ),
                      ),
                      Text(
                        'Unit of Measure : ${shippedOrderController.headerDataList[index].sol?[solIndex]?.unitOfMeasure ?? ''}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.fourtine,
                        ),
                      ),
                      Text(
                        'Invoice Qty: ${shippedOrderController.headerDataList[index].sol?[solIndex]?.quantityInvoiced}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.fourtine,
                        ),
                      ),
                      Text(
                        'Variant Code: ${shippedOrderController.headerDataList[index].sol?[solIndex]?.variantCode}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.fourtine,
                        ),
                      ),
                    ],
                  ),
                )

               /* if (solIndex < shippedOrderController.headerDataList[index].sol!.length - 1)*/

              ],
            );
        },
      ),
    );
  }



}

