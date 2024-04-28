import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/view_model/ipt_vm/ipt_vm.dart';

import '../../components/back_button.dart';
import '../../components/default_button.dart';
import '../../components/default_button_red.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';

class IptApproverViewScreen extends StatelessWidget{
  IptApproverViewScreen({super.key});
  final ipt_header_view_controller=Get.put(IPTViewModel());
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    var iptDate="";
    if(ipt_header_view_controller.approver_details_list.length>0){
      iptDate = StaticMethod.onlyDate(ipt_header_view_controller.approver_details_list[0].iptDate?? '')!;
    }
     return WillPopScope(
       onWillPop: () async {
         Get.back();
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
                                 Get.back();
                               //  Get.toNamed(RoutesName.orderApproverScreen);
                               },
                             ),
                           ),
                         ),
                         Container(
                           padding: EdgeInsets.only(left: 20,),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                   "(${ipt_header_view_controller
                                       .approver_details_list[0].iptNo != null ?
                                   ipt_header_view_controller
                                       .approver_details_list[0]
                                       .iptNo! : ''}"+')',
                                   style: GoogleFonts.poppins(
                                     color: AllColors.primaryDark1,
                                     fontSize: AllFontSize.twentee,
                                     fontWeight: FontWeight.w700,
                                   )
                               ),
                              /* SizedBox(height: 3,),
                               Container(
                                 width: size.width*.4,
                                 child: Text(
                                     overflow: TextOverflow.ellipsis,
                                     "${ipt_header_view_controller
                                         .approver_details_list[0].iptNo != null ?
                                     ipt_header_view_controller
                                         .approver_details_list[0]
                                         .fromCustomerName! : ''}",
                                     style: GoogleFonts.poppins(
                                       color: AllColors.primaryDark1,
                                       fontSize: AllFontSize.fourtine,
                                       fontWeight: FontWeight.w600,
                                     )
                                 ),
                               ),*/
                             ],
                           ),
                         ),
                         Spacer(),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.end,
                           children: [
                             Text(
                                 ipt_header_view_controller
                                     .approver_details_list[0].iptStatus != null ?
                                 ipt_header_view_controller
                                     .approver_details_list
                                    [0].iptStatus! : '',
                                 style: GoogleFonts.poppins(
                                   color: ipt_header_view_controller
                                       .approver_details_list[0].iptStatus ==
                                       'Pending' ? AllColors.redColor : AllColors
                                       .primaryDark1,
                                   fontSize: AllFontSize.fourtine,
                                   fontWeight: FontWeight.w700,
                                 )
                             ),
                             SizedBox(height: 3,),
                             Text(
                                 iptDate.toString(),
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
                       visible: ipt_header_view_controller.loading.value?true:false,
                       child: Container(
                         margin: EdgeInsets.only(top: 1),
                         child: LinearProgressIndicator(
                           backgroundColor: AllColors.primaryDark1,
                           color: AllColors.primaryliteColor,
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
              SizedBox(height: size.height*.01),
              Obx((){
                return Visibility(
                  visible: ipt_header_view_controller.approver_details_list[0].iptStatus=='Completed'?true:false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        child:  DefaultButton(
                          text: "Approve",
                          press: () {
                            showApproveDialog(context,ipt_header_view_controller.approver_details_list[0].iptNo!);
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
                            showRemarkDialog(context,ipt_header_view_controller.approver_details_list[0].iptNo!);
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
              Text('Total Qty ${ipt_header_view_controller.approver_details_list[0].totalQty} / ' +
                  (ipt_header_view_controller.approver_details_list[0].iptStatus == 'Rejected'
                      ?'Rej. Qty'+ ipt_header_view_controller.approver_details_list[0].totalApproveQty.toString()
                      :'Appr.Qty:'+ ipt_header_view_controller.approver_details_list[0].totalApproveQty.toString()),
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

              Text('In Kg: ${ipt_header_view_controller.approver_details_list[0].totalOrderInKg.toString()+' Kg'} / '+

                  (ipt_header_view_controller.approver_details_list[0].iptStatus == 'Rejected'
                      ?'Rej.In Kg:'+ ipt_header_view_controller.approver_details_list[0].totalApproveOrderInKg.toString()
                      :'Appr.In Kg:'+ ipt_header_view_controller.approver_details_list[0].totalApproveOrderInKg.toString()),
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600,)

              ),
              SizedBox(height: size.height*.01),

              SizedBox(height: size.height*.01),
              /*Text('Credit Limit: \u{20B9} ${ipt_header_view_controller.approver_details_list[0].cr.toString()}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600,)
              ),*/
            ],
          ),
        )
    );
  }

  //todo bind for list layout category items.....
  Widget bindListLayout() {
    if (ipt_header_view_controller.approver_details_list[0].lines == null ||
        ipt_header_view_controller.approver_details_list[0].lines!.isEmpty ) {
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
            itemCount: ipt_header_view_controller.approver_details_list[0].lines!.length,
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
                      Text(ipt_header_view_controller.approver_details_list[0].lines![position].itemNo ?? ''
                        ,style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700
                        ),),
                      Text('Sec.Pack: ${ipt_header_view_controller.approver_details_list[0].lines![position].secondaryPacking.toString() +' '+
                          ipt_header_view_controller.approver_details_list[0].lines![position].baseUnitOfMeasure.toString() ?? ''}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )),
                    /*  Text('Price/ ${ipt_header_view_controller.approver_details_list[0].lines![position].baseUnitOfMeasure.toString()+': Rs. '+
                          ipt_header_view_controller.approver_details_list[0].lines![position].unitPrice.toString() ?? ''}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )
                      ),*/


                      Text('Lot No. : ${ipt_header_view_controller.approver_details_list[0].lines![position].lotNo.toString() }',
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

                    /*  Text(
                        '${ipt_header_view_controller.approver_details_list[0].iptStatus == 'Rejected'
                            ? 'Rej. Price / ${ipt_header_view_controller.approver_details_list[0].lines![position].baseUnitOfMeasure.toString()}'
                            : 'Appr.Price/'+ipt_header_view_controller.approver_details_list[0].lines![position].baseUnitOfMeasure.toString()}: Rs. ${ipt_header_view_controller.approver_details_list[0].lines![position].approvePrice.toString()}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        ),
                      ),*/



                      Text('Order Qty: ${ipt_header_view_controller.approver_details_list[0].lines![position].qty.toString()}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )
                      ),

                      Text(
                          '${ipt_header_view_controller.approver_details_list[0].iptStatus == 'Rejected' ? ' Rej. Qty:${ipt_header_view_controller.approver_details_list[0].lines![position].approveQty.toString()}' : 'Appr.Qty: ${ipt_header_view_controller.approver_details_list[0].lines![position].approveQty.toString()}'}',
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
                                color: ipt_header_view_controller.approver_details_list[0].iptStatus=='Completed'?AllColors.primaryDark1:AllColors.primaryliteColor, // Change this color to your desired background color
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.remove,color: AllColors.customDarkerWhite,),
                              )),
                          onPressed: () {
                            int qty=ipt_header_view_controller.approver_details_list[0].lines![position].approveQty!.toInt();
                            qty--;
                            if(ipt_header_view_controller.approver_details_list[0].iptStatus=='Completed') {
                              ipt_header_view_controller.iptApproverLineUpdate(
                                  ipt_header_view_controller
                                      .approver_details_list.value[0]
                                      .lines![position].iptNo!,
                                  ipt_header_view_controller
                                      .approver_details_list.value[0]
                                      .lines![position].itemNo!,
                                  ipt_header_view_controller
                                      .approver_details_list.value[0]
                                      .lines![position].lotNo!,
                                  qty.toString());
                            }
                          },
                        ),
                        Obx((){
                          return InkWell(
                            child: Text(ipt_header_view_controller.approver_details_list[0].lines![position].approveQty==0?
                            ipt_header_view_controller.approver_details_list[0].lines![position].qty.toString():
                              ipt_header_view_controller.approver_details_list[0].lines![position].approveQty.toString(),
                              style: TextStyle(
                                color: AllColors.primaryDark1,
                                fontWeight: FontWeight.w700,
                                fontSize: AllFontSize.twentee,
                              ),
                            ),
                            onTap: (){
                              if(ipt_header_view_controller.approver_details_list[0].iptStatus=='Completed'){
                                showApproveConfirmQtyDialog(context,position);
                              }
                            },
                          );
                        }),

                        IconButton(
                          iconSize: 25,
                          icon: Container(
                              decoration: BoxDecoration(
                                color: ipt_header_view_controller.approver_details_list[0].iptStatus=='Completed'?AllColors.primaryDark1:AllColors.primaryliteColor, // Change this color to your desired background color
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.add,color: AllColors.customDarkerWhite,),
                              )),
                          onPressed: () {
                            int qty=ipt_header_view_controller.approver_details_list[0].lines![position].approveQty!.toInt();
                            qty++;
                            if(ipt_header_view_controller.approver_details_list[0].iptStatus=='Completed') {
                              ipt_header_view_controller.iptApproverLineUpdate(
                                  ipt_header_view_controller.approver_details_list[0]
                                      .lines![position].iptNo!,
                                  ipt_header_view_controller.approver_details_list[0]
                                      .lines![position].itemNo!,ipt_header_view_controller.approver_details_list[0].lines![position].lotNo!,
                                  qty.toString());
                            }
                          },
                        ),
                      ],
                    ),
                    Obx(() {
                      return  Text('In ${ipt_header_view_controller.approver_details_list[0].lines![position].baseUnitOfMeasure}: '
                          '${ipt_header_view_controller.approver_details_list[0].lines![position].approveOrderInKg==0? ipt_header_view_controller.approver_details_list[0].lines![position].orderInKg.toString()+' '+
                          ipt_header_view_controller.approver_details_list[0].lines![position].baseUnitOfMeasure.toString():ipt_header_view_controller.approver_details_list[0].lines![position].approveOrderInKg}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          ));
                    }),
                  ],
                ),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget bindImage(int position) {
    if(ipt_header_view_controller.approver_details_list[0].lines![position].imageUrl != null &&
        ipt_header_view_controller.approver_details_list[0].lines![position].imageUrl != "")
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
            ipt_header_view_controller.approver_details_list[0].lines![position].imageUrl!,
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
    ipt_header_view_controller.ipt_qty_controller.text=ipt_header_view_controller.approver_details_list[0].lines![position].approveQty==0?
    ipt_header_view_controller.approver_details_list[0].lines![position].qty!.toString():
    ipt_header_view_controller.approver_details_list[0].lines![position].approveQty.toString();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm...",style: TextStyle(color: AllColors.primaryDark1)),
          content: TextFormField(
            cursorColor: AllColors.primaryDark1,
            keyboardType: TextInputType.number,
            controller: ipt_header_view_controller.ipt_qty_controller,
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
                print(ipt_header_view_controller.approver_details_list[0].lines![position].iptNo);

                if(ipt_header_view_controller.ipt_qty_controller.text.isNotEmpty){
                  ipt_header_view_controller.iptApproverLineUpdate(ipt_header_view_controller.approver_details_list[0].lines![position].iptNo!,
                      ipt_header_view_controller.approver_details_list[0].lines![position].itemNo!,ipt_header_view_controller.approver_details_list[0].lines![position].lotNo.toString(),
                      ipt_header_view_controller.ipt_qty_controller.text);
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
    ipt_header_view_controller.remarks_controller.clear();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Reject...",style: TextStyle(color: AllColors.primaryDark1,)),
          content: TextFormField(
            cursorColor: AllColors.primaryDark1,
            controller: ipt_header_view_controller.remarks_controller,
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
                if(ipt_header_view_controller.remarks_controller.text.isNotEmpty){
                  ipt_header_view_controller.approve_flag="Go To List";
                  ipt_header_view_controller.iptApproveMarkRejected(ipt_header_view_controller.approver_details_list[0].iptNo.toString(),
                      "Rejected",ipt_header_view_controller.remarks_controller.text);
                 // viewCartController.markApproveReject(documentNo, ipt_header_view_controller.remarks_controller.text,'Rejected');
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
                ipt_header_view_controller.approve_flag="Go To List";
                ipt_header_view_controller.iptApproveMarkRejected(ipt_header_view_controller.approver_details_list[0].iptNo.toString(),
                    "Approved","");

              //  ipt_header_view_controller.markApproveReject(documentNo, '','Approved');
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

