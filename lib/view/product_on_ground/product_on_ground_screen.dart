import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/view_model/product_on_ground_vm/product_on_ground_vm.dart';

import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../resourse/routes/routes_name.dart';

class ProductOnGroundScreen extends StatelessWidget{
  ProductOnGroundScreen({Key? key}) : super(key: key);
  Size size = Get.size;
  final pog_controller= Get.put(ProductOnGroundVM());

  @override
  Widget build(BuildContext context) {
   return WillPopScope(
     onWillPop:() async{
       Get.offAllNamed(RoutesName.homeScreen);
       return true;
     },
     child: Scaffold(
       body: Container(
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
                     child: Text('POG List',
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
                            pog_controller.collectionGetRefressUi();

                          },
                        ),*/
                   ActionChip(
                     elevation: 2,
                     padding: EdgeInsets.all(8),
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
                       pog_controller.flag='Add';
                       Get.offAllNamed(RoutesName.productOnGroundLineDetails);
                     }, //Text
                   ),

                 ],
               ),
             ),
             Container(
               width: size.width,
               padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
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
                         pog_controller.selectionType='Pending';
                         pog_controller.pogDataList.value=[];
                         pog_controller.pageNumber=0;
                         pog_controller.productOnGroundGetData(0);
                       },
                     ),
                     InkWell(
                       child: Row(children: [
                         Column(children: [
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
                         pog_controller.selectionType='Completed';
                         pog_controller.pogDataList.value=[];
                         pog_controller.pageNumber=0;
                         pog_controller.productOnGroundGetData(0);
                       },
                     ),

                     InkWell(
                       child: Row(children: [
                         Column(children: [
                           Text('Approved',
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
                         pog_controller.selectionType='Approved';
                         pog_controller.pogDataList.value=[];
                         pog_controller.pageNumber=0;
                         pog_controller.productOnGroundGetData(0);
                       },
                     ),
                   ],
                 ),
               ),
             ),
             Obx(() {
               return Visibility(
                 visible: pog_controller.loading.value,
                 child: LinearProgressIndicator(
                   backgroundColor: AllColors.primaryDark1,
                   color: AllColors.primaryliteColor,
                 ),
               );
             }),
              Obx(() {
                    return bindListView(context);
                })
            //),
           ],
         ),
       ),
     ),
   );
  }

  Widget bindListView(context){
    ScrollController _scrollController = ScrollController();
    _scrollController!.addListener(() {
      try {
        if (_scrollController!.position.pixels ==
            _scrollController!.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (pog_controller.total_rows / pog_controller.rowPerpage).toInt();
          if ((pog_controller.total_rows % pog_controller.rowPerpage) > 0)
            total_page += 1;

          print(
              "last index ${pog_controller.pageNumber} ${pog_controller.total_rows} ${pog_controller.rowPerpage} ${total_page}");

          if (pog_controller.pageNumber + 1 != total_page) {
            pog_controller.productOnGroundGetData(pog_controller.pageNumber + 1);
            pog_controller.pageNumber += 1;
          }
        }
      }catch(e){
        print('Exception: '+e.toString());
      }
    });
    if (pog_controller.pogDataList.value.isNotEmpty && pog_controller.pogDataList.value.length > 0) {
    //  return Obx(() {
        return  Expanded(
          child: ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) => Divider(height: .05, color: AllColors.primaryDark1,),
              shrinkWrap: true,
              itemCount: pog_controller.pogDataList.value.length,
              itemBuilder: (BuildContext context, int index) {
                return bindPendingListView(context, index);
              }),
        );
    //  },

     // );
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
          if(pog_controller.pogDataList[position].status=='Pending')
            {
              pog_controller.flag='Update';
            }
          else{
            pog_controller.flag='View';
          }
          pog_controller.viewHeaderLineData(pog_controller.pogDataList[position]);
        },
        title:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                'Code : ${pog_controller.pogDataList[position].pogcode ?? ''}',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.sisxteen,
                )),
          ],
        ),

        subtitle: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Zone : ${pog_controller.pogDataList[position].zone ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.fourtine,
                  )),
              Text(
                  'Season : ${pog_controller.pogDataList[position].season ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  )),

                  Text(
                      'Remark : ${pog_controller.pogDataList[position].remarks ?? ''}',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w400,
                        fontSize: AllFontSize.twelve,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Status : ${pog_controller.pogDataList[position].status ?? ''}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w400,
                            fontSize: AllFontSize.twelve,
                          )
                      ),
                      Text(
                          ' ${pog_controller.pogDataList[position].date ?? ''}',
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
        trailing:viewDeleteIcon(context, pog_controller.pogDataList[position].pogcode!, position)
      ),
    );
  }

 Widget viewDeleteIcon(context, String pogCode, int position) {
    if(pog_controller.pogDataList[position].status=='Pending')
      {
        return Container(
          margin: EdgeInsets.only(right: 5),
                  //padding: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.red)
                  ),
                  child: InkWell(
                    onTap: (){
                      /*pog_controller.discardLines(pogCode);*/
                      showConfirmationDialog(context, pogCode);
                    },
                      child: Icon(Icons.delete , color: Colors.red,)
                  )
              );
      }

    return Container(height: 0, width: 0,);
  }

  void showConfirmationDialog(context, String pogCode) {
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm......",style: TextStyle(color: AllColors.primaryDark1,)),
          content:Text('Do you want to Discard?',style: TextStyle(color: AllColors.primaryDark1),),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No",style: TextStyle(color: AllColors.redColor,)),
            ),
            TextButton(
              onPressed: () {
                pog_controller.discardLines(pogCode);
                Navigator.of(context).pop();
              },
              child: Text("Yes",style: TextStyle(color: AllColors.primaryDark1,)),
            ),
          ],
        );
      },
    );
  }



}