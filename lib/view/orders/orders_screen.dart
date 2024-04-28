import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pristine_seeds/view_model/orders_vm/orders_vm.dart';
import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../resourse/routes/routes_name.dart';
class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});
  final OrdersVM orderPageController=Get.put(OrdersVM());
  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //Get.back();
        Get.offAllNamed(RoutesName.homeScreen);
        return true;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            orderPageController.resetAllNewOrderFields();
            Get.toNamed(RoutesName.newOrderScreen);
          },
          child: Icon(Icons.add,color: AllColors.whiteColor,), // You can change the icon as needed
          backgroundColor: AllColors.primaryDark1, // Customize the button's background color
        ),
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: size.height,
          child: Obx(() {
            if (orderPageController.loading.value) {
              // Show a progress indicator while loading
              return Center(
                child:   CircularProgressIndicator(
                  color: AllColors.primaryDark1,
                  backgroundColor: AllColors.primaryliteColor,
                  strokeAlign: CircularProgressIndicator.strokeAlignCenter,
                ),
                //LoadingAnimationWidget.newtonCradle(color:AllColors.primaryDark1, size: 200)   /// You can use any progress indicator here
              );
            } else {
              // Show the UI  not loading
              return Column(
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
                              "Orders",
                              style:GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 0,right: 0,top: 5,bottom: 5),
                    decoration: BoxDecoration(
                      color: AllColors.lightgreyColor,
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text('RS ${orderPageController.pending_amt.toString()}',
                                      softWrap: false,
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontWeight: FontWeight.w700,
                                          fontSize: AllFontSize.fourtine),
                                    ),
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
                              orderPageController.status.value='Pending';
                              orderPageController.pageNumber=0;
                              orderPageController.order_header_get_list.value=[];
                              orderPageController.getOrderHeader(orderPageController.status.value,orderPageController.pageNumber,'');
                            },
                          ),
                          InkWell(
                            child: Row(children: [
                              Column(children: [
                                Text('RS: ${orderPageController.under_approval_amt.toString()}',
                                  softWrap: false,
                                  style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: AllFontSize.fourtine),
                                ),
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
                            onTap: (){
                              orderPageController.status.value='Completed';
                              orderPageController.pageNumber=0;
                              orderPageController.order_header_get_list.value=[];
                              orderPageController.getOrderHeader(orderPageController.status.value,orderPageController.pageNumber,'');
                            },
                          ),
                          InkWell(
                            child: Row(
                              children: [
                                InkWell(
                                  child: Column(children: [
                                    Text('RS ${orderPageController.pending_shipment_amt.toString()}',
                                      softWrap: false,
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontWeight: FontWeight.w700,
                                          fontSize: AllFontSize.fourtine),
                                    ),
                                    Text('Pending shipment',
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
                              orderPageController.status.value='Approved';
                              orderPageController.pageNumber=0;
                              orderPageController.order_header_get_list.value=[];
                              orderPageController.getOrderHeader(orderPageController.status.value,orderPageController.pageNumber,'');

                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*.00001,),
                  Obx((){
                    final headerList = orderPageController.order_header_get_list;
                    return  Visibility(
                      visible: orderPageController.isShowMyExpensesLines.value,
                      child: headerList.isNotEmpty && headerList.length>0 &&headerList[0].condition=='True' ?
                      Expanded(
                        child: ListView.separated(
                            controller: orderPageController.scrollController,
                            padding: EdgeInsets.zero,
                            separatorBuilder: (context, index) => Divider(
                              height: .05,
                              color: AllColors.primaryDark1,
                            ),
                            shrinkWrap: true,
                            itemCount: orderPageController.order_header_get_list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return BindPendingListView(context, index);
                            }
                        ),
                      ):
                      Center(
                        child: Text('No Record Found',style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.twentee,
                            fontWeight: FontWeight.w700
                        ),),
                      ),
                    );
                  }),
                  Divider(
                    height: 2,
                    color: AllColors.blackColor,
                  )
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  //todo listview bind
  Widget BindPendingListView(context, int position)
  {
    var orderDate = StaticMethod.dateTimeToDate(orderPageController.order_header_get_list[position].createdOn!);
    return InkWell(
      child: ListTile(
        onTap: () {
          if(orderPageController.order_header_get_list[position].orderStatus=='Completed' ||
              orderPageController.order_header_get_list[position].orderStatus=='Approved'){
            orderPageController.getOrderHeaderDetails(orderPageController.order_header_get_list[position].orderNo!,'CART');
          }else{
            orderPageController.getOrderHeaderDetails(orderPageController.order_header_get_list[position].orderNo!,'');
          }

        },
        title: Text('Order: ${orderPageController.order_header_get_list[position].orderNo ?? ''}',
            style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w700,
              fontSize: AllFontSize.sisxteen,
            )),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(orderPageController.order_header_get_list[position].customerName ?? '',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                )),

            Text('Date: ${orderDate ?? ''}',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                )),

          ],
        ),
        // leading: Text('Rs. 12000.00'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text('RS. ${orderPageController.order_header_get_list[position].totalPrice.toString()}',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                ),),
            ),
            Expanded(
              child: Text('${orderPageController.order_header_get_list[position].orderStatus=='Approved'?'Appr. Price.${orderPageController.order_header_get_list[position].totalApprovePrice.toString()}':''}',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                ),
              ),
            ),
            Expanded(
              child: Text(orderPageController.order_header_get_list[position].orderStatus ?? '',
                style: GoogleFonts.poppins(
                  color: AllColors.redColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                ),),
            ),
          ],
        ),
      ),
    );
  }
}
