import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/view_model/user_expense_vm/user_expense_vm.dart';
import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../resourse/routes/routes_name.dart';

class MyExpensesScreen extends StatelessWidget {
  MyExpensesScreen({super.key});
  final UserExpenseVM pageController=Get.put(UserExpenseVM());
  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    pageController.onInit();
    return WillPopScope(
      onWillPop: () async {
        //Get.back();
        Get.toNamed(RoutesName.homeScreen);
        return true;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(RoutesName.createExpensesScreen);
            pageController.getExpenseCatagory('');
            pageController.resetAllFields();
          },
          child: Icon(Icons.add,color: AllColors.whiteColor,), // You can change the icon as needed
          backgroundColor: AllColors.primaryDark1, // Customize the button's background color
        ),
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: size.height,
          child: Obx(() {
            if (pageController.loading.value) {
              // Show a progress indicator while loading
              return Center(
                child: CircularProgressIndicator(
                  color: AllColors.primaryDark1,
                  backgroundColor: AllColors.primaryliteColor,
                  strokeAlign: CircularProgressIndicator.strokeAlignCenter,
                ), /// You can use any progress indicator here
              );
            } else {
              // Show the UI when not loading
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
                              "My Expenses",
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
                                    Text('RS ${pageController.pending_header_amt}',
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
                              pageController.getExpenseHeader('pending');
                            },
                          ),
                          SizedBox(width: 10,),
                          InkWell(
                            child: Row(children: [
                              Column(children: [
                                Text('RS: ${pageController.under_approval_header_amt}',
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
                              pageController.getExpenseHeader('Under_Approve');
                            },
                          ),
                          SizedBox(width: 10,),
                          InkWell(
                            child: Row(
                              children: [
                                InkWell(
                                  child: Column(children: [
                                    Text('RS ${pageController.unpaid_header_amt}',
                                      softWrap: false,
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontWeight: FontWeight.w700,
                                          fontSize: AllFontSize.fourtine),
                                    ),
                                    Text('Unpaid',
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
                              pageController.getExpenseHeader('Unpaid');
                              pageController.isCompleteBtn.value=false;
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*.00001,),
                  Obx((){
                    final headerList = pageController.header_response_list;
                    return  Visibility(
                      visible: pageController.isShowMyExpensesLines.value,
                      child: headerList.isNotEmpty && headerList.length>0 &&headerList[0].condition=='True' ?Expanded(
                        child: ListView.separated(
                            padding: EdgeInsets.zero,
                            separatorBuilder: (context, index) => Divider(
                              height: .05,
                              color: AllColors.primaryDark1,
                            ),
                            shrinkWrap: true,
                            itemCount: pageController.header_response_list.length,
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
    return InkWell(
      child: ListTile(
        onTap: () {
          print('cliked$position');
          pageController.getExpensesHeaderLinesApi(pageController.header_response_list[position].documentNo!);
          pageController.getExpenseCatagory('add_new');
        },
        title: Text('Document No. : ${pageController.header_response_list[position].documentNo!}',
            style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w700,
              fontSize: AllFontSize.sisxteen,
            )),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pageController.header_response_list[position].remarks!,
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.fourtine,
                )),
            Text('Date: ${pageController.header_response_list[position].expenseDate}',
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
          children: [
            Text('RS. ${pageController.header_response_list[position].lineAmount.toString()}',
              style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.fourtine,
              ),),
            Text(pageController.header_response_list[position].status.toString(),
              style: GoogleFonts.poppins(
                color: AllColors.redColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.fourtine,
              ),),
          ],
        ),
      ),
    );
  }
}
