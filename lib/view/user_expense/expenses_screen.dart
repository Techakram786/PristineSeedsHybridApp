import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/constants/app_font_size.dart';
import 'package:pristine_seeds/models/region/RegionModel.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';
import '../../components/back_button.dart';
import '../../components/default_button.dart';
import '../../constants/app_colors.dart';
import '../../models/user_expenses/CatagoryResponse.dart';
import '../../view_model/user_expense_vm/user_expense_vm.dart';
class ExpensesScreen extends StatelessWidget {
  ExpensesScreen({super.key});

  final UserExpenseVM pageController = Get.put(UserExpenseVM());
  Size size = Get.size;

  static String _displaycategoryForOption(CatagoryResponse option) =>
      option.expenseName!;

  static String _displayRegionForOption(RegionModel option) =>
      option.regionName!;

  Future<bool> onWillPop() async {
    Get.offAllNamed(RoutesName.myExpensesScreen);
    return false; // Prevent the default back behavior
  }

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(
        pageController.expense_line_submit_list[0].expenseDate!);

    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
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
                            "Expenses",
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            )
                        ),
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              pageController.expense_line_submit_list[0]
                                  .status!,
                              style: GoogleFonts.poppins(
                                color: pageController
                                    .expense_line_submit_list[0].status!
                                    .toLowerCase() == 'Pending' ? AllColors
                                    .redColor : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700,
                              )
                          ),
                          SizedBox(height: 3,),
                          Text(
                              formattedDate,
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
                Obx(() {
                  return Visibility(
                    visible: pageController.isPogressIndicator.value
                        ? true
                        : false,
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


                SizedBox(height: size.height * .01,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Column(
                        children: [
                          Container(

                            child: Column(crossAxisAlignment: CrossAxisAlignment
                                .start,
                              children: [
                                Text(
                                    "Description (${pageController
                                        .expense_line_submit_list[0]
                                        .documentNo!})",
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700,
                                    )
                                ),
                                Text(
                                    pageController.expense_line_submit_list[0]
                                        .remarks!,
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w300,
                                    )
                                ),
                                SizedBox(height: 5,),
                                Divider(color: AllColors.primaryDark1,
                                  height: 1,
                                  thickness: 1,),
                                Text(
                                    "Expenses Submitted",
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700,
                                    )
                                ),
                                Divider(color: AllColors.primaryDark1,
                                  height: 1,
                                  thickness: 1,),
                                // Adding the ListView below the second divider
                                SizedBox(height: 5,),

                                Obx(() {
                                  final lines = pageController
                                      .expense_line_submit_list[0].lines;
                                  return Visibility(
                                    visible: pageController.isLinesVisible
                                        .value,
                                    child: lines != null && lines.length > 0
                                        ? Container(
                                      height: 200,
                                      child: ListView.separated(
                                        padding: EdgeInsets.all(1.0),
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                              height: .05,
                                              color: AllColors.primaryDark1,
                                            ),
                                        shrinkWrap: true,
                                        itemCount: pageController
                                            .expense_line_submit_list[0].lines!
                                            .length,
                                        // Adjust the number of items as needed
                                        itemBuilder: (context, index) {
                                          return BindListView(context, index);
                                        },
                                      ),
                                    )
                                        : Center(
                                      child: Text("Data Not Found",
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontWeight: FontWeight.w700,
                                            fontSize: AllFontSize.twentee
                                        ),
                                      ),
                                    ),
                                  );
                                }),

                                SizedBox(height: 5,),
                                Divider(color: AllColors.primaryDark1,
                                  height: 1,
                                  thickness: 1,),
                                Obx(() {
                                  return Visibility(
                                    visible: pageController.isLinesVisible
                                        .value,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                            "Total Amount",
                                            style: GoogleFonts.poppins(
                                              color: AllColors.primaryDark1,
                                              fontSize: AllFontSize.sisxteen,
                                              fontWeight: FontWeight.w700,
                                            )
                                        ),
                                        Text(
                                            'Rs. ${pageController
                                                .expense_line_submit_list[0]
                                                .totalLineAmount.toString()}',
                                            style: GoogleFonts.poppins(
                                              color: AllColors.primaryDark1,
                                              fontSize: AllFontSize.fourtine,
                                              fontWeight: FontWeight.w300,
                                            )
                                        ),
                                      ],
                                    ),
                                  );
                                }),

                                Divider(color: AllColors.primaryDark1,
                                  height: 1,
                                  thickness: 1,),
                                SizedBox(height: size.height * .02),

                                Obx(() {
                                  return Visibility(
                                    visible: pageController.isCompleteBtn.value,
                                    // visible: pageController.expense_line_submit_list[0].status!='Pending'?pageController.isCompleteBtn.value:!pageController.isCompleteBtn.value,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: DefaultButton(
                                            text: "Complete",
                                            press: () {
                                              pageController
                                                  .expenseCompleteApiHit();
                                            },
                                            //  loading: pageController.loading.value,
                                          ),
                                        ),
                                        SizedBox(width: size.width * .04),
                                        Expanded(
                                          child: DefaultButton(
                                            text: "Add New",
                                            press: () {
                                              pageController.isCompleteBtn
                                                  .value = false;
                                              pageController.isAddLinesVisible
                                                  .value = true;
                                              pageController.isLinesSubmit
                                                  .value = false;

                                              pageController.getExpenseCatagory(
                                                  'add_new');
                                            },
                                            // loading: pageController.loading.value,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          Obx(() {
                            return Visibility(
                              visible: pageController.isAddLinesVisible.value,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  bindCatagoryDropDown(context),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    enabled: pageController
                                        .expense_line_submit_list[0].status ==
                                        'Pending' ? true : false,
                                    controller: pageController
                                        .amount_controller,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      pageController.amount_controller.value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Amount of expense with all taxes",
                                      labelText: "Total Amount",

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
                                        borderSide: BorderSide(color: AllColors
                                            .primaryDark1), // Change the color to green
                                      ),
                                    ),
                                    cursorColor: AllColors.primaryDark1,
                                  ),
                                  Obx(() {
                                    return Visibility(
                                      visible: pageController.isLodging > 0
                                          ? true
                                          : false,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                //SizedBox(height: 8),
                                                Container(
                                                    width: size.width * .3,
                                                    child: bindDatePickerFrom(
                                                        context)),
                                                Container(
                                                    width: size.width * .3,
                                                    child: bindDatePickerTO(
                                                        context)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 8.0,),
                                          bindRegionNameDropDown(context),
                                        ],

                                      ),
                                    );
                                  }),
                                  Obx(() {
                                    return Visibility(
                                      visible: pageController.isKm > 0
                                          ? true
                                          : false,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 8),
                                          bindTotalKm(context),
                                        ],
                                      ),
                                    );
                                  }),
                                  SizedBox(height: 8),
                                  bindRemarks(context),
                                  SizedBox(height: size.height * .05),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      //todo obx comment when reset button click ui Damage then obx comment....
                                      /* Obx(() {
                                        return*/
                                      Expanded(
                                        child: Visibility(
                                          visible: pageController
                                              .expense_line_submit_list[0]
                                              .status!.toLowerCase() ==
                                              'pending',
                                          child: DefaultButton(
                                            text: "Submit Line",
                                            press: () {
                                              pageController
                                                  .hitExpenseLineSubmit(
                                                  pageController.document_no
                                                      .toString(), 'expense',
                                                  null);
                                            },
                                            //  loading: pageController.loading.value,
                                          ),
                                        ),
                                      ),
                                      // }),
                                      SizedBox(width: size.width * .01),
                                      Expanded(
                                        child: DefaultButton(
                                          text: "Back",
                                          press: () {
                                            pageController
                                                .description_controller.clear();
                                            pageController.date_controller
                                                .clear();
                                            pageController
                                                .expense_catagory_controller
                                                .clear();
                                            pageController.amount_controller
                                                .clear();

                                            pageController.file_path0.value =
                                            '';
                                            pageController.file_path1.value =
                                            '';
                                            pageController.file_path2.value =
                                            '';
                                            pageController.file_path3.value =
                                            '';

                                            pageController.image_url.value = '';
                                            pageController.image_url1.value =
                                            '';
                                            pageController.image_url2.value =
                                            '';
                                            pageController.file_path3.value =
                                            '';
                                            if (pageController
                                                .expense_line_submit_list[0]
                                                .status == 'Pending') {
                                              pageController.isCompleteBtn
                                                  .value = true;
                                              pageController.isAddLinesVisible
                                                  .value = false;
                                              pageController.isLinesSubmit
                                                  .value = true;
                                            }
                                            pageController.isAddLinesVisible
                                                .value = false;
                                          },
                                          // loading: pageController.loading.value,
                                        ),
                                      ),
                                      SizedBox(width: size.width * .01),
                                      GestureDetector(
                                          onTap: () async {
                                            FocusScopeNode currentFocus = FocusScope
                                                .of(context);
                                            if (!currentFocus.hasPrimaryFocus &&
                                                currentFocus.focusedChild !=
                                                    null) {
                                              currentFocus.focusedChild
                                                  ?.unfocus();
                                            }
                                            //pageController.getFile();
                                            if (pageController.isShowImage
                                                .value == true)
                                              pageController.isShowImage.value =
                                              false;
                                            else
                                              pageController.isShowImage.value =
                                              true;
                                          },
                                          child: Icon(Icons.attach_file,
                                            color: AllColors.lightblackColor,)),
                                      // Replace with your desired attachment icon
                                      SizedBox(width: size.width * .01),
                                      // Add spacing between the icon and text
                                      Text(pageController.files_count > 0
                                          ? pageController.files_count
                                          .toString()
                                          : '0', style: GoogleFonts.poppins(
                                          color: AllColors.lightblackColor,
                                          fontSize: AllFontSize.sisxteen,
                                          fontWeight: FontWeight.w700
                                      ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.02,),
                                  Obx(() {
                                    return Visibility(
                                      visible: pageController.isShowImage.value,
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 1,
                                                // Adjust the height of the line as needed
                                                color: Colors
                                                    .black, // Change the color of the line
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0, right: 4.0),
                                              child: Text(
                                                "Files",
                                                style: GoogleFonts.poppins(
                                                    fontSize: AllFontSize
                                                        .sisxteen,
                                                    // Adjust the font size
                                                    fontWeight: FontWeight.w700,
                                                    color: AllColors
                                                        .lightblackColor // Adjust the font weight
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 1,
                                                // Adjust the height of the line as needed
                                                color: Colors
                                                    .black, // Change the color of the line
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: size.height * 0.02,),
                                        Obx(() {
                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Visibility(
                                              visible: pageController
                                                  .isShowImage.value,

                                              child: Center(
                                                  child: Row(
                                                    children: [
                                                      linefileBindUi('file_one',
                                                          pageController
                                                              .image_url.value,
                                                          pageController
                                                              .file_path0
                                                              .value),
                                                      SizedBox(
                                                          width: size.width *
                                                              .02),
                                                      linefileBindUi('file_two',
                                                          pageController
                                                              .image_url1.value,
                                                          pageController
                                                              .file_path1
                                                              .value),
                                                      SizedBox(
                                                          width: size.width *
                                                              .02),
                                                      linefileBindUi(
                                                          'file_three',
                                                          pageController
                                                              .image_url2.value,
                                                          pageController
                                                              .file_path2
                                                              .value),
                                                      SizedBox(
                                                          width: size.width *
                                                              .02),
                                                      linefileBindUi(
                                                          'file_four',
                                                          pageController
                                                              .image_url3.value,
                                                          pageController
                                                              .file_path3
                                                              .value),
                                                    ],
                                                  )
                                              ),
                                            ),
                                          );
                                        }),
                                        SizedBox(height: size.height * 0.02,),
                                        Visibility(
                                          visible: pageController
                                              .expense_line_submit_list[0]
                                              .status == 'Pending' && pageController
                                              .expense_line_submit_list[0].lines![0].imageCount!<4
                                              ? pageController.addFileButton
                                              .value
                                              : false,
                                          child: GestureDetector(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AllColors.primaryDark1
                                                  ),
                                                  child: Icon(Icons.add,color: AllColors.whiteColor,),
                                                ),
                                                SizedBox(width: size.width*.02,),
                                                Text('Add Files',
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.primaryDark1,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: AllFontSize.twentee,
                                                  ),
                                                )
                                              ],
                                            ),
                                            onTap: ()async{
                                              showCinfirmationDialog(
                                                  context);
                                              //await pageController.getFile('');
                                            },
                                          ),
                                        )
                                      ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            );
                          }),
                          SizedBox(height: size.height * .02,)
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            )
        ),
      ),
    );
  }

  //todo listview bind
  Widget BindListView(context, int position) {
    final line = pageController.expense_line_submit_list[0].lines![position];
    return InkWell(
      child: ListTile(
        onTap: () {
          pageController.selectedContainerIndex.value = line.imageCount!;
          pageController.resetAllfieldsAndPath();
          pageController.showExpenseLineDetails(position);
        },
        title: Row(
          children: [
            Text(line.expenseName ?? '',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w500,
                  fontSize: AllFontSize.fourtine,
                )),
            Icon(
              Icons.attach_file, color: AllColors.lightblackColor, size: 18,),
            SizedBox(width: size.width * .01),
            // Add spacing between the icon and text
            Text(line.imageCount!.toString() ?? ''
              , style: GoogleFonts.poppins(
                  color: AllColors.lightblackColor,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w500
              ),
            )
          ],
        ),
        subtitle: Text(line.expenseRemark ?? '',
            style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.fourtine,
            )),
        // leading: Text('Rs. 12000.00'),
        trailing: Text('RS. ${line.expenseAmount.toString()}',
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.fourtine,
          ),),
      ),
    );
  }

  Widget linefileBindUi(String flag, String image_url, String file_path) {
    if (pageController.isShowImage.value) {
      print(flag + '   ' + image_url + '  ' + file_path);
      if (file_path.isNotEmpty && (file_path.toLowerCase().endsWith('.png')
          || file_path.toLowerCase().endsWith('.jpeg')
          || file_path.toLowerCase().endsWith('.jpg'))) {
        return GestureDetector(
          child: Container(
            child: DottedBorder(
              color: Colors.grey,
              strokeWidth: 2,
              borderType: BorderType.RRect,
              radius: Radius.circular(20),
              dashPattern: [10, 5, 10, 5],
              child: Container(
                width: size.width * 0.30,
                height: size.height * 0.15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.file(
                    File(file_path.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          onTap: () async {
            //todo comment code...(15-01-2024)
            /* if(pageController.expense_line_submit_list[0].status!.toLowerCase()=='pending'){
              if(file_path.isNotEmpty || image_url.isNotEmpty)
                await pageController.getFile(flag);
              else
                Utils.sanckBarError('Image', 'Please Click Add Button!');
            }
*/
          },
        );
      }
      else
      if (file_path.isNotEmpty && file_path.toLowerCase().endsWith('.pdf')) {
        return GestureDetector(
          child: Container(
            child: DottedBorder(
              color: Colors.grey,
              strokeWidth: 2,
              borderType: BorderType.RRect,
              radius: Radius.circular(20),
              dashPattern: [10, 5, 10, 5],
              child: Container(
                width: size.width * 0.30,
                height: size.height * 0.15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Icon(
                    Icons.picture_as_pdf,
                    size: 60,
                    color: AllColors.primaryDark1,
                  ),
                ),
              ),
            ),
          ),
          onTap: () async {
            //todo comment  code when we click image box Code comment....(15-01-2024)
            /* if(pageController.expense_line_submit_list[0].status!.toLowerCase()=='pending'){
              await pageController.getFile(flag);
            }*/

          },
        );
      }
      else if (file_path.isNotEmpty &&
          (file_path.toLowerCase().endsWith('.doc') ||
              file_path.toLowerCase().endsWith('.docx'))) {
        return GestureDetector(
          child: Container(
            child: DottedBorder(
              color: Colors.grey,
              strokeWidth: 2,
              borderType: BorderType.RRect,
              radius: Radius.circular(20),
              dashPattern: [10, 5, 10, 5],
              child: Container(
                width: size.width * 0.30,
                height: size.height * 0.15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Icon(
                    Icons.file_copy,
                    size: 60,
                    color: AllColors.primaryDark1,
                  ),
                ),
              ),
            ),
          ),
          onTap: () async {
            if (pageController.expense_line_submit_list[0].status!
                .toLowerCase() == 'pending') {
              await pageController.getFile(flag);
            }
          },
        );
      }
      else if (file_path.isEmpty && image_url.isNotEmpty &&
          (image_url.toLowerCase().endsWith('.png')
              || image_url.toLowerCase().endsWith('.jpeg')
              || image_url.toLowerCase().endsWith('.jpg'))
      ) {
        return GestureDetector(
          child: Container(
            child: DottedBorder(
              color: Colors.grey,
              strokeWidth: 2,
              borderType: BorderType.RRect,
              radius: Radius.circular(20),
              dashPattern: [10, 5, 10, 5],
              child: Container(
                width: size.width * 0.30,
                height: size.height * 0.15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    image_url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          onTap: () async {
            //todo comment  code when we click image box Code comment....(15-01-2024)

            /*if(pageController.expense_line_submit_list[0].status!.toLowerCase()=='pending'){
              await pageController.getFile(flag);
            }
*/
          },
        );
      }
      else if (file_path.isEmpty && image_url.isNotEmpty &&
          image_url.toString().endsWith('.pdf')) {
        return GestureDetector(
          child: Container(
            child: DottedBorder(
              color: Colors.grey,
              strokeWidth: 2,
              borderType: BorderType.RRect,
              radius: Radius.circular(20),
              dashPattern: [10, 5, 10, 5],
              child: Container(
                width: size.width * 0.30,
                height: size.height * 0.15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Icon(
                    Icons.picture_as_pdf,
                    size: 60,
                    color: AllColors.primaryDark1,
                  ),
                ),
              ),
            ),
          ),
          onTap: () async {
            //todo comment  code when we click image box Code comment....(15-01-2024)

            /*if(pageController.expense_line_submit_list[0].status!.toLowerCase()=='pending'){
              await pageController.getFile(flag);
            }*/

          },
        );
      }
      else if (file_path.isEmpty && image_url.isNotEmpty &&
          (image_url.toString().endsWith('.doc') ||
              image_url.toString().endsWith('.docx'))) {
        return GestureDetector(
          child: Container(
            child: DottedBorder(
              color: Colors.grey,
              strokeWidth: 2,
              borderType: BorderType.RRect,
              radius: Radius.circular(20),
              dashPattern: [10, 5, 10, 5],
              child: Container(
                width: size.width * 0.30,
                height: size.height * 0.15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Icon(
                    Icons.file_copy,
                    size: 60,
                    color: AllColors.primaryDark1,
                  ),
                ),
              ),
            ),
          ),
          onTap: () async {
            //todo comment  code when we click image box Code comment....(15-01-2024)

            /*if(pageController.expense_line_submit_list[0].status!.toLowerCase()=='pending'){
              await pageController.getFile(flag);
            }*/

          },
        );
      }
      else {
        return GestureDetector(
          child: Container(
            child: DottedBorder(
              color: Colors.grey,
              strokeWidth: 2,
              borderType: BorderType.RRect,
              radius: Radius.circular(20),
              dashPattern: [10, 5, 10, 5],
              child: Container(
                width: size.width * 0.30,
                height: size.height * 0.15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Icon(
                    Icons.image,
                    size: 60,
                    color: AllColors.primaryDark1,
                  ),
                ),
              ),
            ),
          ),
          onTap: () async {
            //todo comment  code when we click image box Code comment....(15-01-2024)

            /*     if(pageController.expense_line_submit_list[0].status!.toLowerCase()=='pending'){
              await pageController.getFile(flag);
            }*/

          },
        );
      }
    }
    else {
      return Text('No Record Found', style: GoogleFonts.poppins(
          color: AllColors.primaryDark1,
          fontSize: AllFontSize.fourtine,
          fontWeight: FontWeight.w500
      ),);
    }
  }

  Widget bindCatagoryDropDown(context) {
    return Autocomplete<CatagoryResponse>(
      displayStringForOption: _displaycategoryForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return pageController.expense_catagory_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return pageController.expense_catagory_list
            .where((CatagoryResponse option) {
          return option.expenseName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (CatagoryResponse selection) {
        print(selection.expenseName);
        pageController.isLodging.value = selection.isLodging!;
        pageController.isKm.value = selection.isKm!;
        pageController.expense_catagory_controller.text =
            _displaycategoryForOption(selection).toString();
        pageController.image_requred.value = selection.imageRequired!;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          enabled: pageController.expense_line_submit_list[0].status ==
              'Pending' ? true : false,
          controller: controller
            ..text = pageController.expense_catagory_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Category',
            labelText: 'Expense Category',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten
            ),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<CatagoryResponse> onSelected,
          Iterable<CatagoryResponse> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final CatagoryResponse option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.expenseName.toString(),
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize
                                .sisxteen // Change the text color here
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget bindRegionNameDropDown(context) {
    return Autocomplete<RegionModel>(
      displayStringForOption: _displayRegionForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return pageController.region_name_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return pageController.region_name_list
            .where((RegionModel option) {
          return option.regionName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (RegionModel selection) {
        print(selection.regionName);
        // Update the TextField with the selected
        pageController.region_catagory_controller.text =
            _displayRegionForOption(selection).toString();
        pageController.region_name.value = selection.regionName!;
        pageController.region_code.value = selection.regionCode!;
        print(pageController.region_code.value);
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          enabled: pageController.expense_line_submit_list[0].status ==
              'Pending' ? true : false,
          controller: controller
            ..text = pageController.region_catagory_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Region',
            labelText: 'Region Name',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten
            ),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<RegionModel> onSelected,
          Iterable<RegionModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final RegionModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.regionName.toString(),
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize
                                .sisxteen // Change the text color here
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget bindDatePickerFrom(context) {
    return TextFormField(
      enabled: pageController.expense_line_submit_list[0].status == 'Pending'
          ? true
          : false,
      controller: pageController.from_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "From Date",
        labelText: 'From Date',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.ten
        ),
        labelStyle: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w700,
            fontSize: AllFontSize.sisxteen),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
      onTap: () async {
        DateTime stating_date = new DateTime(1900);
        //DateTime ending_date = new DateTime(2200);
        DateTime ending_date = new DateTime.now();
        FocusScope.of(context).requestFocus(new FocusNode());
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: stating_date,
          lastDate: ending_date,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AllColors.primaryDark1, // Header background color
                //accentColor: AllColors.primaryDark1, // Color of the buttons
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(
                    textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },

        );
        var outputFormat = DateFormat('dd-MM-yyyy');
        if (date != null && date != "")
          pageController.from_date_controller.text =
              outputFormat.format(date);
        else
          pageController.from_date_controller.text = "";
      },
    );
  }

  Widget bindDatePickerTO(context) {
    return TextFormField(
      enabled: pageController.expense_line_submit_list[0].status == 'Pending'
          ? true
          : false,
      controller: pageController.to_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "To Date",
        labelText: 'To Date',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.ten
        ),
        labelStyle: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w700,
            fontSize: AllFontSize.sisxteen),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
      onTap: () async {
        DateTime stating_date = new DateTime(1900);
        DateTime ending_date = new DateTime.now();
        FocusScope.of(context).requestFocus(new FocusNode());
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: stating_date,
          lastDate: ending_date,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AllColors.primaryDark1, // Header background color
                //accentColor: AllColors.primaryDark1, // Color of the buttons
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(
                    textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );
        var outputFormat = DateFormat('dd-MM-yyyy');
        if (date != null && date != "")
          pageController.to_date_controller.text =
              outputFormat.format(date);
        else
          pageController.to_date_controller.text = "";
      },
    );
  }

  Widget bindTotalKm(context) {
    return TextFormField(
      enabled: pageController.expense_line_submit_list[0].status == 'Pending'
          ? true
          : false,
      controller: pageController.total_km_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        pageController.total_km_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Total Km",
        labelText: "Total Km",

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
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
    );
  }

  Widget bindRemarks(context) {
    return TextFormField(
      enabled: pageController.expense_line_submit_list[0].status == 'Pending'
          ? true
          : false,
      controller: pageController.remark_controller,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        pageController.remark_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Remarks",
        labelText: "Remarks",

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
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
    );
  }

  void showCinfirmationDialog(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Choose Option.....",
            style: TextStyle(color: AllColors.primaryDark1,)),
        content: Container(
          height: 100,
          child: Column(
            children: [
              Divider(height: .5, color: AllColors.lightgreyColor,),
              GestureDetector(
                onTap: () async {
                  await pageController.getFile('');
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(Icons.photo_album_outlined,
                        color: AllColors.primaryDark1, size: 20,),
                      SizedBox(width: 20,),
                      Text('Gallery', style: TextStyle(color: AllColors
                          .primaryDark1),),
                    ],
                  ),
                ),
              ),
              Divider(height: .5, color: AllColors.lightgreyColor,),
              InkWell(
                onTap: () async {
                  pageController.upLoadImage(context, '');
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt_outlined,
                        color: AllColors.primaryDark1, size: 20,),
                      SizedBox(width: 20,),
                      Text('Camera', style: TextStyle(color: AllColors
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
}

