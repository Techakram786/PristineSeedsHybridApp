import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/view_model/ipt_vm/ipt_vm.dart';

import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../resourse/routes/routes_name.dart';

class IptHeaderList extends StatelessWidget{
  IptHeaderList({super.key});
  Size size=Get.size;
  final ipt_pageController=Get.put(IPTViewModel());
  ScrollController _scrollController = ScrollController();
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
              ipt_pageController.resetAllNewIptFields();
              Get.toNamed(RoutesName.iptHeaderCreate);
            },
            child: Icon(Icons.add,color: AllColors.whiteColor,), // You can change the icon as needed
            backgroundColor: AllColors.primaryDark1,
          ),
            body: Container(
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
                                "IPT Header List ",
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
                    Obx(() {
                      return
                        Visibility(
                          visible:ipt_pageController.loading.value ,
                        child: LinearProgressIndicator(
                          color:AllColors.primaryliteColor ,
                          backgroundColor: AllColors.primaryDark1,),
                      );
                   },
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
                                ipt_pageController.selectedFlag.value="Pending";
                                ipt_pageController.pageNumber=0;
                               // orderPageController.order_header_get_list.value=[];
                                ipt_pageController.getIptHeaderList(ipt_pageController.pageNumber,ipt_pageController.selectedFlag.value,"");
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
                                ipt_pageController.selectedFlag.value="Completed";
                                ipt_pageController.pageNumber=0;
                                ipt_pageController.getIptHeaderList(ipt_pageController.pageNumber,ipt_pageController.selectedFlag.value,"");
                              },
                            ),
                            InkWell(
                              child: Row(
                                children: [
                                  InkWell(
                                    child: Column(children: [
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
                                ipt_pageController.selectedFlag.value="Approved";
                                ipt_pageController.pageNumber=0;
                                ipt_pageController.getIptHeaderList(ipt_pageController.pageNumber,ipt_pageController.selectedFlag.value,"");
                              },
                            )
                          ],
                        ),
                      ),
                    ),

                    Obx(() {
                      return BindListView(context);
                    },),
              ]
              ),
            )
        ),

    );
  }

  BindListView(BuildContext context) {
    if(ipt_pageController.ipt_get_list.isNotEmpty && ipt_pageController.ipt_get_list.length >0){
      return  Expanded(
        child: ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(height: .05, color: AllColors.primaryDark1,),
            shrinkWrap: true,
            itemCount: ipt_pageController.ipt_get_list.value.length,
            controller:_scrollController ,
            itemBuilder: (BuildContext context, int index) {
              _scrollController.addListener(() {
                if (_scrollController.position.pixels== _scrollController.position.maxScrollExtent){

                  int total_page = (ipt_pageController.total_rows / ipt_pageController.rowsPerPage).toInt();

                  if((ipt_pageController.total_rows%ipt_pageController.rowsPerPage)>0)
                    total_page+=1;

                  print("last index ${ipt_pageController.pageNumber} ${ipt_pageController.total_rows} ${ipt_pageController.rowsPerPage} ${total_page}");

                  if(ipt_pageController.pageNumber+1!=total_page){
                    ipt_pageController. getIptHeaderList(ipt_pageController.pageNumber+1,ipt_pageController.selectedFlag.value,"");
                    ipt_pageController.pageNumber+=1;
                  }
                }
              });
              return BindIptListView(context, index);
            }
            ),
      );
    }
    else{
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

  BindIptListView(BuildContext context, int index) {
    var iptDate = StaticMethod.dateTimeToDate(ipt_pageController.ipt_get_list[index].iptdate.toString());
    return InkWell(
      child: ListTile(
        onTap: () {

          if(ipt_pageController.ipt_get_list[index].iptstatus=='Completed' ||
              ipt_pageController.ipt_get_list[index].iptstatus=='Approved'){
            ipt_pageController.IptHeaderDetails(ipt_pageController.ipt_get_list[index].iptno!,'CART');
          }else{
            ipt_pageController.IptHeaderDetails(ipt_pageController.ipt_get_list[index].iptno!,'');
          }

        },
        title:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${ipt_pageController.ipt_get_list[index].iptno ?? ''}',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.sisxteen,
                )),
/*
            Text(" ${ipt_pageController.ipt_get_list[index].tocustomername ?? ''}",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.sisxteen,
                )),*/
        ],),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Tooltip(
              message: ipt_pageController.ipt_get_list[index].fromcustomername ?? '',
              child: Text("From :  ${ipt_pageController.ipt_get_list[index].fromcustomername ?? ''}",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                ),
                overflow: TextOverflow.ellipsis,),
            ),
            Tooltip(
              message: ipt_pageController.ipt_get_list[index].tocustomername ?? '',
              child: Text("To :  ${ipt_pageController.ipt_get_list[index].tocustomername ?? ''}",
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                ),
                overflow: TextOverflow.ellipsis,),
            ),


            Text('Date : ${iptDate ?? ''}',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                )),

          ],
        ),
        trailing: Expanded(
              child: Text(ipt_pageController.ipt_get_list[index].iptstatus ?? '',
                style: GoogleFonts.poppins(
                  color: AllColors.redColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                ),),
            ),

        // leading: Text('Rs. 12000.00'),

      ),
    );





  }


}



