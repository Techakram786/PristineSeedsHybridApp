import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/back_button.dart';
import '../../components/default_button.dart';
import '../../components/default_button_red.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../../view_model/orders_vm/order_approver_vm.dart';

class ApproverViewCartScreen extends StatelessWidget {
  ApproverViewCartScreen({Key? key}) : super(key: key);

  final OrderApproverViewModel viewCartController = Get.put(OrderApproverViewModel());
  Size size = Get.size;

  Future<bool> onWillPop() async {
    //Get.back();
    Get.toNamed(RoutesName.orderApproverScreen);
    return true; // Prevent the default back behavior
  }
  @override
  Widget build(BuildContext context) {
    var orderDate="";
    if(viewCartController.order_detail_list.length>0){
      orderDate = StaticMethod.onlyDate(viewCartController.order_detail_list[0].orderDate?? '')!;
    }
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
                              Get.toNamed(RoutesName.orderApproverScreen);
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20,top: 15,),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "(${viewCartController
                                    .order_detail_list[0].orderNo != null ?
                                viewCartController.order_detail_list[0]
                                    .orderNo! : ''}"+')',
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.twentee,
                                  fontWeight: FontWeight.w700,
                                )
                            ),
                            SizedBox(height: 3,),
                            Container(
                              width: size.width*.4,
                              child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  "${viewCartController
                                      .order_detail_list[0].orderNo != null ?
                                  viewCartController.order_detail_list[0]
                                      .customerName! : ''}",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600,
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              viewCartController
                                  .order_detail_list[0].orderStatus != null ?
                              viewCartController
                                  .order_detail_list[0].orderStatus! : '',
                              style: GoogleFonts.poppins(
                                color: viewCartController
                                    .order_detail_list[0].orderStatus ==
                                    'Pending' ? AllColors.redColor : AllColors
                                    .primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700,
                              )
                          ),
                          SizedBox(height: 3,),
                          Text(
                              orderDate.toString(),
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w600,
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                Obx((){
                  return Visibility(
                    visible: viewCartController.isPogressIndicator.value?true:false,
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
                SizedBox(height: size.height * .01),
                Obx((){
                  return  Container(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 5),
                    child: bindHeaderDetails(context),
                  );
                }),
                Divider(
                  height: 2,
                  color: AllColors.primaryDark1,
                ),
                Obx((){
                  return Expanded(
                    child: Container(
                      child: bindListLayout(),
                    ),
                  );
                }),
              ],
            )
        ),
      ),
    );
  }
  //todo bind header details........
  Widget bindHeaderDetails(BuildContext context) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('View Order Details',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w700,)
                  ),
                  /*  Text('\u{20B9} ${ viewCartController.order_detail_list[0].totalPrice.toString()}',
                      style: GoogleFonts.poppins(
                        color: AllColors.redColor,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w700,)
                  ),*/
                  /*Text('\u{20B9} ${ viewCartController.order_detail_list[0].totalApprovePrice.toString()}',
                      style: GoogleFonts.poppins(
                        color: AllColors.redColor,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w700,)
                  ),*/
                  Text(viewCartController.order_detail_list[0].orderStatus=='Pending'?'\u{20B9} ${ viewCartController.order_detail_list[0].totalPrice.toString()}':
                  '\u{20B9}${viewCartController.order_detail_list[0].totalApprovePrice.toString()}',
                      style: GoogleFonts.poppins(
                        color: AllColors.redColor,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w700,)
                  ),
                ],
              ),
              SizedBox(height: size.height*.01),
              Obx((){
                return Visibility(
                  visible: viewCartController.order_detail_list[0].orderStatus=='Completed'?true:false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        child:  DefaultButton(
                          text: "Approve",
                          press: () {
                            showApproveDialog(context,viewCartController.order_detail_list[0].orderNo!);
                            //viewCartController.orderHeaderComplete(viewCartController.order_detail_list[0].orderNo!);
                          },
                          //  loading: viewCartController.loading.value,
                        ),
                      ),
                      Container(
                        width: 150,
                        child: DefaultButtonRed(
                          text: "Reject",
                          press: () {
                            showRemarkDialog(context,viewCartController.order_detail_list[0].orderNo!);
                            //viewCartController.orderHeaderComplete(viewCartController.order_detail_list[0].orderNo!);
                          },
                          //loading: viewCartController.loading.value,
                        ),
                      )

                    ],
                  ),
                );
              }),
              SizedBox(height: size.height*.01),
              Text('Total Qty ${viewCartController.order_detail_list[0].totalQty} / ' +
                  (viewCartController.order_detail_list[0].orderStatus == 'Rejected'
                      ?'Rej. Qty'+ viewCartController.order_detail_list[0].totalApproveQty.toString()
                      :'Appr.Qty:'+ viewCartController.order_detail_list[0].totalApproveQty.toString()),
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w600


                  )),

              //todo ritik comment flag according check......
              /*Text('Total Qty: ${viewCartController.order_detail_list[0].totalQty.toString()} / Appr.Qty: ${viewCartController.order_detail_list[0].totalApproveQty.toString()}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600,)
              ),*/
              SizedBox(height: size.height*.01),
              //todo ritik comment flag according check......

              /* Text('In Kg: ${viewCartController.order_detail_list[0].totalOrderInKg.toString()+' Kg'} / Appr.In Kg: ${viewCartController.order_detail_list[0].totalApproveOrderInKg.toString()} ',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600,)
              ),*/

              Text('In Kg: ${viewCartController.order_detail_list[0].totalOrderInKg.toString()+' Kg'} / '+

                  (viewCartController.order_detail_list[0].orderStatus == 'Rejected'
                      ?'Rej.In Kg:'+ viewCartController.order_detail_list[0].totalApproveOrderInKg.toString()
                      :'Appr.In Kg:'+ viewCartController.order_detail_list[0].totalApproveOrderInKg.toString()),
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600,)

              ),
              SizedBox(height: size.height*.01),
              Text('Current O/S: \u{20B9} ${viewCartController.order_detail_list[0].currentOutstanding.toString()}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600,)
              ),
              SizedBox(height: size.height*.01),
              Text('Credit Limit: \u{20B9} ${viewCartController.order_detail_list[0].creditLimit.toString()}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600,)
              ),
            ],
          ),
        )
    );
  }

  //todo bind for list layout category items.....
  Widget bindListLayout() {
    if (viewCartController.order_detail_list[0].lines == null ||
        viewCartController.order_detail_list[0].lines!.isEmpty ) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text('No Records Found.', style: TextStyle(
              fontSize: 20,
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w700
          ),),
        ),
      );
    } else {
      Size size = Get.size;
      return Container(
        height: size.height - 170,
        child: ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) =>
                Divider(
                  height: 5,
                  color: AllColors.primaryDark1,
                ),
            itemCount: viewCartController.order_detail_list[0].lines!.length,
            itemBuilder: (context, index) {
              //var item = orderItemGroupPageController.searchResult[index];
              return BindListView(context,index);
            }),
      );
    }
  }
  //todo listview bind
  Widget BindListView(context,int position)
  {
    return InkWell(
      child: ListTile(
        onTap: () {
        },
        subtitle: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bindImage(position),
                SizedBox(width: size.width*.001),
                Obx((){
                  return  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(viewCartController.order_detail_list[0].lines![position].itemNo ?? ''
                        ,style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700
                        ),),
                      Text('Sec.Pack: ${viewCartController.order_detail_list[0].lines![position].secondaryPacking.toString() +' '+
                          viewCartController.order_detail_list[0].lines![position].baseUnitOfMeasure.toString() ?? ''}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )),
                      Text('Price/ ${viewCartController.order_detail_list[0].lines![position].baseUnitOfMeasure.toString()+': Rs. '+
                          viewCartController.order_detail_list[0].lines![position].unitPrice.toString() ?? ''}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )
                      ),


                      //todo ritik comment according to flag.....
                      /*Text('Appr.Price/ ${viewCartController.order_detail_list[0].lines![position].baseUnitOfMeasure.toString()+': Rs. '+
                          viewCartController.order_detail_list[0].lines![position].approvePrice.toString() ?? ''}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )
                      ),*/

                      Text(
                        '${viewCartController.order_detail_list[0].orderStatus == 'Rejected'
                            ? 'Rej. Price / ${viewCartController.order_detail_list[0].lines![position].baseUnitOfMeasure.toString()}'
                            : 'Appr. Total Price'}: Rs. ${viewCartController.order_detail_list[0].lines![position].approvePrice.toString()}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        ),
                      ),



                      Text('Order Qty: ${viewCartController.order_detail_list[0].lines![position].qty.toString()}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )
                      ),

                      Text(
                          '${viewCartController.order_detail_list[0].orderStatus == 'Rejected' ? ' Rej. Qty:${viewCartController.order_detail_list[0].lines![position].approveQty.toString()}' : 'Appr.Qty: ${viewCartController.order_detail_list[0].lines![position].approveQty.toString()}'}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )


                      ),

                      //todo ritik comment according to flag.....

                      /* Text('Appr.Qty: ${viewCartController.order_detail_list[0].lines![position].approveQty.toString()}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )
                      ),*/
                    ],
                  );
                }),

              ],
            ),
            SizedBox(height: size.height*.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          iconSize: 25,
                          icon: Container(
                              decoration: BoxDecoration(
                                color: viewCartController.order_detail_list[0].orderStatus=='Completed'?AllColors.primaryDark1:AllColors.primaryliteColor, // Change this color to your desired background color
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.remove,color: AllColors.customDarkerWhite,),
                              )),
                          onPressed: () {
                            if(viewCartController.order_detail_list[0].orderStatus=='Completed'){
                              viewCartController.orderApproverItemLineInsert(viewCartController.order_detail_list[0].lines![position].orderNo!,
                                  viewCartController.order_detail_list[0].lines![position].itemNo!,
                                  viewCartController.order_detail_list[0]
                                      .lines![position].approveQty==0?
                                  viewCartController.order_detail_list[0]
                                      .lines![position].qty!:viewCartController.order_detail_list[0]
                                      .lines![position].approveQty!,'REMOVE');
                            }
                          },
                        ),
                        Obx((){
                          return InkWell(
                            child: Text(viewCartController.order_detail_list[0].lines![position].approveQty==0?
                            viewCartController.order_detail_list[0].lines![position].qty.toString():
                            viewCartController.order_detail_list[0].lines![position].approveQty.toString(),
                              style: TextStyle(
                                color: AllColors.primaryDark1,
                                fontWeight: FontWeight.w700,
                                fontSize: AllFontSize.twentee,
                              ),
                            ),
                            onTap: (){
                              if(viewCartController.order_detail_list[0].orderStatus=='Completed'){
                                showApproveConfirmQtyDialog(context,position);
                              }

                              //  showApproveConfirmQtyDialog(context,position);
                            },
                          );
                        }),

                        IconButton(
                          iconSize: 25,
                          icon: Container(
                              decoration: BoxDecoration(
                                color: viewCartController.order_detail_list[0].orderStatus=='Completed'?AllColors.primaryDark1:AllColors.primaryliteColor, // Change this color to your desired background color
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.add,color: AllColors.customDarkerWhite,),
                              )),
                          onPressed: () {
                            if(viewCartController.order_detail_list[0].orderStatus=='Completed') {
                              viewCartController.orderApproverItemLineInsert(
                                  viewCartController.order_detail_list[0]
                                      .lines![position].orderNo!,
                                  viewCartController.order_detail_list[0]
                                      .lines![position].itemNo!,
                                  viewCartController.order_detail_list[0]
                                      .lines![position].approveQty==0?
                                  viewCartController.order_detail_list[0]
                                      .lines![position].qty!:viewCartController.order_detail_list[0]
                                      .lines![position].approveQty!, 'ADD');
                            }
                          },
                        ),
                      ],
                    ),
                    Obx(() {
                      return  Text('In ${viewCartController.order_detail_list[0].lines![position].baseUnitOfMeasure}: '
                          '${viewCartController.order_detail_list[0].lines![position].approveOrderInKg==0? viewCartController.order_detail_list[0].lines![position].orderInKg.toString()+' '+
                          viewCartController.order_detail_list[0].lines![position].baseUnitOfMeasure.toString():viewCartController.order_detail_list[0].lines![position].approveOrderInKg}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          ));
                    }),
                  ],
                ),
                Spacer(),
                /*  Expanded(
                  child: Obx((){
                    return Visibility(
                      visible: viewCartController.order_detail_list[0].orderStatus=='Pending'?true:false,
                      child: DefaultButtonRed(
                        text: "Delete",
                        press: () {
                          viewCartController.orderItemLineInsert(viewCartController.order_detail_list[0].lines![position].orderNo!,
                              viewCartController.order_detail_list[0].lines![position].itemNo!,
                              0,'DELETE','CART');
                        },
                      ),
                    );
                  }),
                ),*/
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget bindImage(int position) {
    if(viewCartController.order_detail_list[0].lines![position].imageUrl != null &&
        viewCartController.order_detail_list[0].lines![position].imageUrl != "")
      return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            viewCartController.order_detail_list[0].lines![position].imageUrl!,
            width: 100,
            height: 120,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // If there's an error loading the image, display a default image
              return Image.asset(
                "assets/images/no_file.png",
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      );
    else
      return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            "assets/images/no_file.png",
            width: 100,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
      );

  }

  showApproveConfirmQtyDialog(BuildContext context, int position) {
    viewCartController.qty_controller.text=viewCartController.order_detail_list[0].lines![position].approveQty==0?
    viewCartController.order_detail_list[0].lines![position].qty!.toString():
    viewCartController.order_detail_list[0].lines![position].approveQty.toString();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm...",style: TextStyle(color: AllColors.primaryDark1)),
          content: TextFormField(
            cursorColor: AllColors.primaryDark1,
            keyboardType: TextInputType.number,
            controller: viewCartController.qty_controller,
            decoration: InputDecoration( labelText: "Enter Qty",labelStyle: TextStyle(color: AllColors.primaryDark1,),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AllColors.primaryDark1),
                // Change underline color
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AllColors.primaryDark1), // Change focused underline color
              ),

            ),


          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cancel button pressed
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor),),
            ),
            TextButton(
              onPressed: () {
                if(viewCartController.qty_controller.text.isNotEmpty){
                  viewCartController.orderApproverItemLineInsert(viewCartController.order_detail_list[0].lines![position].orderNo!,
                      viewCartController.order_detail_list[0].lines![position].itemNo!,
                      int.parse(viewCartController.qty_controller.text) ,'');
                  Navigator.of(context).pop();
                }
                else
                  Utils.sanckBarError('Order!', 'Please Enter Order Qty');
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1),),
            ),
          ],
        );
      },
    );
  }

  void showRemarkDialog(BuildContext context, String documentNo) {
    viewCartController.remarks_controller.clear();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Reject...",style: TextStyle(color: AllColors.primaryDark1,)),
          content: TextFormField(
            cursorColor: AllColors.primaryDark1,
            controller: viewCartController.remarks_controller,
            decoration: InputDecoration(labelText: "Enter Remarks",labelStyle: TextStyle(color: AllColors.primaryDark1,),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AllColors.primaryDark1,)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AllColors.primaryDark1,))


            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cancel button pressed
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor,)),
            ),
            TextButton(
              onPressed: () {
                if(viewCartController.remarks_controller.text.isNotEmpty){
                  viewCartController.markApproveReject(documentNo, viewCartController.remarks_controller.text,'Rejected');
                  Navigator.of(context).pop();
                }
                else
                  Utils.sanckBarError('Remark!', 'Please Enter Remarks');
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1,)),
            ),
          ],
        );
      },
    );
  }
  void showApproveDialog(BuildContext context, String documentNo) {

    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Approve...",style: TextStyle(color: AllColors.primaryDark1,)),
          content:Text('Do you want to approve?',style: TextStyle(color: AllColors.primaryDark1),),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cancel button pressed
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor,)),
            ),
            TextButton(
              onPressed: () {

                viewCartController.markApproveReject(documentNo, '','Approved');
                Navigator.of(context).pop();
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1,)),
            ),
          ],
        );
      },
    );
  }
}