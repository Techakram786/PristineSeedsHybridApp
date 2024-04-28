import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/constants/static_methods.dart';
import 'package:pristine_seeds/models/common_response/common_resp.dart';
import 'package:pristine_seeds/models/region/RegionModel.dart';
import 'package:pristine_seeds/repository/user_expense_repo/user_expense_repo.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:pristine_seeds/resourse/routes/routes_name.dart';
import '../../models/dash_board/emp_master_response.dart';
import '../../models/user_expenses/CatagoryResponse.dart';
import '../../models/user_expenses/ExpenseHeaderResponse.dart';
import '../../models/user_expenses/ExpenseLinesResponse.dart';
import '../../models/user_expenses/ExpenseLinesSubmittedResponse.dart';
import '../../resourse/appUrl/app_url.dart';
import '../../utils/app_utils.dart';
import '../session_management/session_management_controller.dart';

class UserExpenseVM extends GetxController {
  final _api = UserExpenseRepository();
  RxBool loading = false.obs;
  RxBool iscategoryExpense = false.obs;
  RxBool isAddLinesVisible = false.obs;
  RxBool isLinesVisible = false.obs;
  RxBool isHeaderAndLine = false.obs;
  RxBool isLinesSubmit = false.obs;
  RxBool isCompleteBtn = false.obs;
  RxBool isShowImage = false.obs;
  RxBool isShowMyExpensesLines = false.obs;
  RxBool addFileButton = true.obs;
  RxBool isshowDate = false.obs;
  RxBool isshowtotalKm = false.obs;
  RxBool isPogressIndicator = false.obs;

  SessionManagement sessionManagement = SessionManagement();
  String email_id = "";
  String document_no = "";
  String grade = "";
  String company_id = "";
  RxString expense_date = "".obs;
  RxString region_name = "".obs;
  RxString region_code = "".obs;
  RxInt image_requred = 0.obs;
  RxInt isLodging = 0.obs;
  RxInt isKm = 0.obs;
  String expense_status = 'pending';
  List<EmpMasterResponse> employess_List = [];
  double total_amt = 0.0;

  //todo create expense variables..................
  var expense_catagory_controller = TextEditingController();
  var region_catagory_controller = TextEditingController();
  var date_controller = TextEditingController();
  var from_date_controller = TextEditingController();
  var to_date_controller = TextEditingController();
  var description_controller = TextEditingController();
  var amount_controller = TextEditingController();
  var remark_controller = TextEditingController();
  var total_km_controller = TextEditingController();

  //todo expenses variables..................

  RxString file_path0 = ''.obs;
  RxString file_path1 = ''.obs;
  RxString file_path2 = ''.obs;
  RxString file_path3 = ''.obs;
  RxString image_url = ''.obs;
  RxString image_url1 = ''.obs;
  RxString image_url2 = ''.obs;
  RxString image_url3 = ''.obs;
  RxInt files_count = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    email_id = await sessionManagement.getEmail() ?? '';
    grade = await sessionManagement.getGrade() ?? '';
    company_id = await sessionManagement.getCompanyId() ?? '';
    getRegionsList();

    //todo for get pending header lines...............
    getExpenseHeader('pending');
  }

  List<ExpenseHeaderResponse> header_response_list = [];
  List<CatagoryResponse> expense_catagory_list = [];
  List<RegionModel> region_name_list = [];
  List<ExpenseLinesSubmittedResponse> expense_line_submit_list = [];

  RxInt selectedContainerIndex = 0.obs; // To track which container to fill
  RxInt imageCount = 0.obs; // To track which container to fill
  Future getFile(String flag) async {
    print(flag);
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(allowMultiple: false);
    try {
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        if (files.isNotEmpty) {
          String outputPath = files[0].path;
          int maxSizeInBytes = 3000 * 1024;

          // Compress and save the selected image
          await compressAndSaveImage(files[0], outputPath, maxSizeInBytes);
          // Set the selected file path to the appropriate observable based on selectedContainerIndex
          isShowImage.value = false;
          if (flag.isEmpty) {
            if (selectedContainerIndex.value == 0) {
              file_path0.value = files[0].path;
              imageCount+=1;
            } else if (selectedContainerIndex.value == 1) {
              file_path1.value = files[0].path;
              imageCount+=1;

            } else if (selectedContainerIndex.value == 2) {
              file_path2.value = files[0].path;
              imageCount+=1;

            } else if (selectedContainerIndex.value == 3) {
              file_path3.value = files[0].path;
              imageCount+=1;

            }
            selectedContainerIndex.value++;
          } else {
            if (flag == 'file_one') {
              if(file_path0.value.isEmpty){
                imageCount+=1;
              }
              file_path0.value = files[0].path;

            } else if (flag == 'file_two') {
              if(file_path1.value.isEmpty){
                imageCount+=1;
              }
              file_path1.value = files[0].path;

            } else if (flag == 'file_three') {
              if(file_path2.value.isEmpty){
                imageCount+=1;

              }
              file_path2.value = files[0].path;

            } else if (flag == 'file_four') {
              if(file_path3.value.isEmpty){
                imageCount+=1;
                addFileButton.value=false;
                addFileButton.value=true;
              }
              file_path3.value = files[0].path;
            }

          }
          isShowImage.value = true;
          //todo Increment the index for the next container


          // todo Reset the index to 0 if it goes beyond 3 (assuming you have 4 containers)
          /*  if (selectedContainerIndex.value > 3) {
             selectedContainerIndex.value = 0;
          }*/
        }
        expenseAttachmentCount();
        print(flag + ' aaa ${file_path2.value} bb  ${files[0].path}');
      }
      if (selectedContainerIndex > 3) {
        addFileButton.value = false;
      } else {
        //Utils.sanckBarError('Image!', 'No Select Any Image');
      }
    } catch (e) {
      print(e);
      Utils.sanckBarError('Image Error!', e.toString());
    }
  }

  final ImagePicker _picker = ImagePicker();


  //todo for get pending headerlines...............
  String pending_header_amt='0';
  String under_approval_header_amt='0';
  String unpaid_header_amt='0';
  getExpenseHeader(String status) {
    this.loading.value = true;
    Map<String, String> data = {'email_id': email_id, 'status': status};
    isShowMyExpensesLines.value = false;
    _api.getExpenseHeader(data, sessionManagement).then((value) {
      print(value);

      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ExpenseHeaderResponse> header_response = jsonResponse
              .map((data) => ExpenseHeaderResponse.fromJson(data))
              .toList();
          if (header_response != null &&
              header_response.length > 0 &&
              header_response[0].condition == 'True') {
            pending_header_amt=header_response[0].pendingAmount.toString();
            under_approval_header_amt=header_response[0].underApproveAmount.toString();
            unpaid_header_amt=header_response[0].unpaidAmount.toString();
            header_response_list = header_response;

            loading.value = false;
            isShowMyExpensesLines.value = true;

            //Utils.sanckBarSuccess('True Message!', header_response[0].condition.toString());
          } else {
            pending_header_amt=header_response[0].pendingAmount.toString();
            under_approval_header_amt=header_response[0].underApproveAmount.toString();
            unpaid_header_amt=header_response[0].unpaidAmount.toString();
            isShowMyExpensesLines.value = true;
            loading.value = false;
            header_response_list = [];
          }
        } else {
          pending_header_amt='0';
          under_approval_header_amt='0';
          unpaid_header_amt='0';
          loading.value = false;
          Utils.sanckBarError(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);
        }
      } catch (e) {
        pending_header_amt='0';
        under_approval_header_amt='0';
        unpaid_header_amt='0';
        loading.value = false;
        printError();
        print(e);
      }
    }).onError((error, stackTrace) {
      pending_header_amt='0';
      under_approval_header_amt='0';
      unpaid_header_amt='0';
      print(error);
      loading.value = false;
    });
  }

  //todo for create expense...................
  getExpensesHeaderLinesApi(String documentNo) {
    this.loading.value = true;
    Map data = {'document_no': documentNo, 'created_by': email_id};

    _api.expenseCreate(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        print(value);
        if (jsonResponse is List) {
          List<ExpenseLinesSubmittedResponse> header_lines_response =
          jsonResponse
              .map((data) => ExpenseLinesSubmittedResponse.fromJson(data))
              .toList();
          if (header_lines_response[0].condition == 'True') {
            loading.value = false;
            isLinesVisible.value = true;
            isAddLinesVisible.value = false;
            isLinesSubmit.value = true;
            //isCompleteBtn.value=true;
            expense_line_submit_list = header_lines_response;


            if (expense_line_submit_list[0].isDone! > 0) {
              isCompleteBtn.value = false;
            } else {
              isCompleteBtn.value = true;
            }

            print('doc no:-  ${expense_line_submit_list[0].documentNo}');
            Get.toNamed(RoutesName.expensesScreen);
          } else {
            expense_line_submit_list = [];
            loading.value = false;
            Utils.sanckBarError(
                'False Message!', header_lines_response[0].message.toString());
          }
        } else {
          loading.value = false;
          expense_line_submit_list = [];
          Utils.sanckBarError(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);
        }
      } catch (e) {
        expense_line_submit_list = [];
        loading.value = false;
        printError();
      }
    }).onError((error, stackTrace) {
      print(error);
      loading.value = false;
      expense_line_submit_list = [];
    });
  }

  //todo hit for get expense catagories.............
  getExpenseCatagory(String flag) {
    selectedContainerIndex.value = 0;
    files_count.value = 0;
    addFileButton.value = true;
    file_path0.value = '';
    file_path1.value = '';
    file_path2.value = '';
    file_path3.value = '';
    image_url.value = '';
    image_url1.value = '';
    image_url2.value = '';
    image_url3.value = '';
    expense_catagory_controller.text = '';
    amount_controller.text = '';
    remark_controller.text='';
    from_date_controller.text= '';
    to_date_controller.text= '';
    region_catagory_controller.text= '';
    total_km_controller.text= '';

    this.loading.value = true;
    Map data = {'flag': 'GetExpense'};
    _api.getExpenseCatagory(data, sessionManagement).then((value) {
      try {
        List<CatagoryResponse> expense_response = (json.decode(value) as List)
            .map((i) => CatagoryResponse.fromJson(i))
            .toList();
        if (expense_response.length != null &&
            expense_response.length > 0 &&
            expense_response[0].condition == 'True') {
          expense_catagory_list = expense_response;
          if (flag != 'add_new') Get.toNamed(RoutesName.createExpensesScreen);

        } else {
          expense_catagory_list = [];
          Utils.sanckBarError(
              'Message False!', 'Expenses Categories Not Found');
        }
      } catch (e) {
        expense_catagory_list = [];
      }
    }).onError((error, stackTrace) {
      expense_catagory_list = [];
      Utils.sanckBarError('Api Exception onError', error.toString());
    }).whenComplete(() => {this.loading.value = false});
  }

  //todo for get regions................
  //todo hit for get expense lines.....
  Future<void> getExpenseLines(String? expense_no) async {
    this.loading.value = true;
    Map<String, String> data = {
      'document_no': expense_no.toString(),
      'email_id': email_id
    };
    _api.getExpenseLines(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ExpenseLineResponse> lines_responses = jsonResponse
              .map((data) => ExpenseLineResponse.fromJson(data))
              .toList();
          if (lines_responses != null && lines_responses.length > 0) {
            loading.value = false;
          } else {
            loading.value = false;
          }
        } else {
          loading.value = false;
          Utils.sanckBarError(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);
        }
      } catch (e) {
        loading.value = false;
        printError();
      }
    }).onError((error, stackTrace) {
      print(error);
      loading.value = false;
    });
  }

  //todo for create expense...................
  expenseCreateApi() {
    if (description_controller.text.isEmpty ||
        description_controller.text == null) {
      Utils.sanckBarError('Error : ', 'Please Enter Description.');
      return;
    }
    if (date_controller.text.isEmpty || date_controller.text == null) {
      Utils.sanckBarError('Error : ', 'Please Select Date.');
      return;
    }
    if (expense_catagory_controller.text.isEmpty || expense_catagory_controller.text == null) {
      Utils.sanckBarError('Error : ', 'Please Select Expense.');
      return;
    }
    if (isLodging>0 && (from_date_controller.text.isEmpty || from_date_controller.text == null)) {
      Utils.sanckBarError('Error : ', 'Please Select From Date.');
      return;
    }
    if (isLodging>0 && (to_date_controller.text.isEmpty || to_date_controller.text == null)) {
      Utils.sanckBarError('Error : ', 'Please Select To Date.');
      return;
    }

    if (isLodging>0 && (region_catagory_controller.text.isEmpty || region_catagory_controller.text == null)) {
      Utils.sanckBarError('Error : ', 'Please Select Region.');
      return;
    }
    if (isKm>0 && (total_km_controller.text.isEmpty || total_km_controller.text == null)) {
      Utils.sanckBarError('Error : ', 'Please Enter Total Km.');
      return;
    }

    if (amount_controller.text.isEmpty || amount_controller.text == null) {
      Utils.sanckBarError('Error : ', 'Please Enter Total Amount.');
      return;
    }
    if ((file_path0 == null || file_path0.isEmpty )&& image_requred > 0) {
      Utils.sanckBarError('Error : ', 'Please Select Image.');
      return;
    }
    //  this.loading.value = true;
    isPogressIndicator.value=true;

    Map data = {
      'document_no': '',
      'grade': grade,
      'expense_date':
      StaticMethod.convertDateFormat(date_controller.text.toString()),
      'remarks': description_controller.text.toString(),
      'da_code': '',
      'da_name': '',
      'da_amount': '0',
      'created_by': email_id
    };
    _api.expenseCreate(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ExpenseLinesSubmittedResponse> responses = jsonResponse
              .map((data) => ExpenseLinesSubmittedResponse.fromJson(data))
              .toList();
          if (responses[0].condition == 'True') {
            //  loading.value = false;
            isPogressIndicator.value=false;
            hitExpenseLineSubmit(responses[0].documentNo, '',responses);
          } else {
            isPogressIndicator.value=false;
            //loading.value = false;
            Utils.sanckBarError(
                'False Message!', responses[0].message.toString());
          }
        } else {
          //loading.value = false;
          isPogressIndicator.value=false;
          Utils.sanckBarError('API Error',jsonResponse.toString());
          print(jsonResponse);
        }
      } catch (e) {
        isPogressIndicator.value=false;
        //  loading.value = false;
        printError();
      }
    }).onError((error, stackTrace) {
      print(error);
      isPogressIndicator.value=false;
      //loading.value = false;
    });
  }

  //todo hit for expense line submit...............
  Future<void> hitExpenseLineSubmit(String? documentNo, String flag, List<ExpenseLinesSubmittedResponse> ?header_response) async {
    if (flag == 'expense') {
      if (expense_catagory_controller.text.isEmpty ||
          expense_catagory_controller.text == null) {
        Utils.sanckBarError('Error : ', 'Please Enter Expense Category.');
        return;
      }
      if (amount_controller.text.isEmpty || amount_controller.text == null) {
        Utils.sanckBarError('Error : ', 'Please Enter Total Amount.');
        return;
      }
    }

    print(documentNo);
    print("regoin....${region_catagory_controller.text}");
    var totalKmText = total_km_controller.text;
    var totalKm = totalKmText.isNotEmpty ? totalKmText : '0';
    isPogressIndicator.value=true;
    // loading.value = true;

    final server_uri = Uri.parse(AppUrl.expenseLinesSubmit);
    final clint_request = http.MultipartRequest('POST', server_uri);
    var lodging_from_date=  StaticMethod.convertDateFormat(from_date_controller.text.toString()) ?? '' ;
    var lodging_to_date= StaticMethod.convertDateFormat(to_date_controller.text.toString())?? '';
    var fields = <String, String>{
      "document_no": documentNo.toString().isNotEmpty
          ? documentNo.toString()
          : expense_line_submit_list[0].documentNo.toString(),
      "expense_name": expense_catagory_controller.text,
      "expense_amount": amount_controller.text,
      "lodging_from_date": lodging_from_date.toString(),
      "lodging_to_date": lodging_to_date.toString(),
      "total_km_travel":totalKm,
      "expense_remark":remark_controller.text ??'',
      "region_code":region_code.value ??'',
      "region_name":region_catagory_controller.text ??''
    };
    clint_request.fields.addAll(fields);
    if (file_path0.isNotEmpty) {
      clint_request.files
          .add(await http.MultipartFile.fromPath('image1', file_path0.value));
    }
    if (file_path1.isNotEmpty) {
      clint_request.files
          .add(await http.MultipartFile.fromPath('image2', file_path1.value));
    }
    if (file_path2.isNotEmpty) {
      clint_request.files
          .add(await http.MultipartFile.fromPath('image3', file_path2.value));
    }
    if (file_path3.isNotEmpty) {
      clint_request.files
          .add(await http.MultipartFile.fromPath('image4', file_path3.value));
    }
    isLinesVisible.value = false;
    //--hit api
    _api.expenseLinesSubmit(clint_request, sessionManagement).then((value) {
      print(value);
      final jsonResponse = json.decode(value);
      try {
        print(value);
        if (jsonResponse is List) {
          List<ExpenseLinesSubmittedResponse> response = jsonResponse
              .map((data) => ExpenseLinesSubmittedResponse.fromJson(data))
              .toList();
          if (response[0].condition == 'True') {
            print(response);
            isPogressIndicator.value=false;
            //   loading.value = false;
            isLinesVisible.value = true;
            isAddLinesVisible.value = false;
            isLinesSubmit.value = true;
            isCompleteBtn.value = true;
            expense_line_submit_list = response;
            resetAllFields();
            Utils.sanckBarSuccess(
                'True Message', expense_line_submit_list[0].message.toString());

            Get.toNamed(RoutesName.expensesScreen);
          }
          else {
            if(flag==''){
              isPogressIndicator.value=false;
              //  loading.value = false;
              isshowDate.value=true;
              isshowtotalKm.value=true;
              isLinesVisible.value = true;
              isAddLinesVisible.value = true;
              isLinesSubmit.value = true;
              isCompleteBtn.value = false;

              expense_line_submit_list = header_response!;
              //resetAllFields();
              Utils.sanckBarError(
                  'False Message!', response[0].message.toString());

              Get.toNamed(RoutesName.expensesScreen);
            }else{
              isLinesVisible.value = true;
              //isshowDate.value=true;
              //expense_line_submit_list = [];
              isPogressIndicator.value=false;
              //  loading.value = false;
              Utils.sanckBarError(
                  'False Message!', response[0].message.toString());
            }

          }
        } else {
          isPogressIndicator.value=false;
          // loading.value = false;
          isLinesVisible.value = true;
          Utils.sanckBarError('API Response Error ', jsonResponse?? '');
          print(jsonResponse);
        }
      } catch (e) {
        print(e);
      }
    }).onError((error, stackTrace) {
      isLinesVisible.value = true;
      print(error);
      isPogressIndicator.value=false;
      //loading.value = false;
      Utils.sanckBarError('Error!', "Api Response Error ${error}");
    });
  }

  //todo hit for get expense lines.....
  Future<void> getRegionsList() async {
    // this.loading.value = true;
    isPogressIndicator.value=true;
    Map<String, String> data = {
      'grade': grade,
    };
    _api.getRegion(data,sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<RegionModel> responses = jsonResponse
              .map((data) => RegionModel.fromJson(data))
              .toList();
          if (responses != null && responses.length > 0) {
            //loading.value = false;
            isPogressIndicator.value=false;
            region_name_list=responses;
          } else {
            // loading.value = false;
            isPogressIndicator.value=false;
            region_name_list=[];
          }
        } else {
          // loading.value = false;
          isPogressIndicator.value=false;
          region_name_list=[];
          Utils.sanckBarError(
              'API Error',
              jsonResponse["message"] == null
                  ? 'Invalid response format'
                  : jsonResponse["message"]);
        }
      } catch (e) {
        isPogressIndicator.value=false;
        // loading.value = false;
        region_name_list=[];
        printError();
      }
    }).onError((error, stackTrace) {
      print(error);
      //  loading.value = false;
      isPogressIndicator.value=false;
      region_name_list=[];
    });
  }

  //todo hit for complete expense..............
  expenseCompleteApiHit() {
    //this.loading.value = true;
    isPogressIndicator.value=true;
    Map data = {
      'document_no': expense_line_submit_list[0].documentNo,
      'email_id': email_id
    };
    _api.expenseComplete(data, sessionManagement).then((value) {
      print('complete doc no:-  ${expense_line_submit_list[0].documentNo}');
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<CommonResponse> responses = jsonResponse
              .map((data) => CommonResponse.fromJson(data))
              .toList();
          if (responses[0].condition == 'True') {
            //loading.value = false;
            isPogressIndicator.value=false;
            Utils.sanckBarSuccess(
                'True Message!', responses[0].message.toString());
            expense_line_submit_list = [];
            Get.toNamed(RoutesName.myExpensesScreen, preventDuplicates: false);
          } else {
            // loading.value = false;
            isPogressIndicator.value=false;
            Utils.sanckBarError(
                'False Message!', responses[0].message.toString());
          }
        } else {
          //loading.value = false;
          isPogressIndicator.value=false;
          Utils.sanckBarError('API Response Error: ', jsonResponse);
        }
      } catch (e) {
        //loading.value = false;
        isPogressIndicator.value=false;
        printError();
      }
    }).onError((error, stackTrace) {
      print(error);
      //loading.value = false;
      isPogressIndicator.value=false;
    });
  }
  //todo reset all fields......
  resetAllfieldsAndPath(){
    expense_catagory_controller.text=expense_catagory_controller.text.isNotEmpty?'':'';
    amount_controller.text= amount_controller.text.isNotEmpty?'':'';
    from_date_controller.text= from_date_controller.text.isNotEmpty?'':'';
    to_date_controller.text= to_date_controller.text.isNotEmpty?'':'';
    region_catagory_controller.text= region_catagory_controller.text.isNotEmpty?'':'';
    total_km_controller.text= total_km_controller.text.isNotEmpty?'':'';
    remark_controller.text= remark_controller.text.isNotEmpty?'':'';

    image_url.value=image_url.value.isNotEmpty?'':'';
    image_url1.value=image_url1.value.isNotEmpty?'':'';
    image_url2.value=image_url2.value.isNotEmpty?'':'';
    image_url3.value=image_url3.value.isNotEmpty?'':'';

    file_path0.value=file_path0.value.isNotEmpty?'':'';
    file_path1.value=file_path1.value.isNotEmpty?'':'';
    file_path2.value=file_path2.value.isNotEmpty?'':'';
    file_path3.value=file_path3.value.isNotEmpty?'':'';

    isshowDate.value=false;
    addFileButton.value=false;
    isshowtotalKm.value=false;
    isShowImage.value = false;
    addFileButton.value = false;
    files_count.value = 0;
  }

  //todo show line details for editing
  showExpenseLineDetails(int position) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var outputFormat = DateFormat('dd-MM-yyyy');
    isCompleteBtn.value = false;
    isAddLinesVisible.value = true;
    isLinesSubmit.value = false;
    isShowImage.value = true;
    print( ' islodging ::${expense_line_submit_list[0].lines![position].isLodging}');
    expense_catagory_controller.text = expense_line_submit_list[0].lines![position].expenseName!;
    amount_controller.text = expense_line_submit_list[0].lines![position].expenseAmount.toString()!;
    remark_controller.text=expense_line_submit_list[0].lines![position].expenseRemark!;
    if(expense_line_submit_list[0].lines![position].isLodging!>0){
      String lodgingFromDate = expense_line_submit_list[0].lines?[position]?.lodgingFromDate ?? "";
      print('loging...${lodgingFromDate}');
      String lodgingtoDate = expense_line_submit_list[0].lines?[position]?.lodgingToDate ?? "";
      DateTime? parsedfromDate = inputFormat.parse(lodgingFromDate, true);
      DateTime? parsedtoDate = inputFormat.parse(lodgingtoDate, true);
      String formattedDate = outputFormat.format(parsedfromDate);
      String formattedtoDate = outputFormat.format(parsedtoDate);

      from_date_controller.text=formattedDate/*expense_line_submit_list[0].lines![position].lodgingFromDate!*/;
      to_date_controller.text=formattedtoDate/*expense_line_submit_list[0].lines![position].lodgingToDate!*/;
      region_catagory_controller.text=expense_line_submit_list[0].lines![position].regionName!;
      isshowDate.value=true;
      isLodging.value=expense_line_submit_list[0].lines![position].isLodging!;
      region_code.value=expense_line_submit_list[0].lines![position].regionCode!;
    }
    else{
      isLodging.value=0;
    }

    if(expense_line_submit_list[0].lines![position].isKm!>0){
      total_km_controller.text=expense_line_submit_list[0].lines![position].totalKmTravel.toString();
      isshowtotalKm.value=true;
      isKm.value=expense_line_submit_list[0].lines![position].isKm!;
    }
    else{
      isKm.value=0;
    }
    print('imageUrl'+expense_line_submit_list[0].lines![position].imageUrl.toString());
    if (expense_line_submit_list[0].lines![position].imageUrl!.isNotEmpty) {
      image_url.value = expense_line_submit_list[0].lines![position].imageUrl.toString()!;
      //files_count.value++;
    }

    if (expense_line_submit_list[0].lines![position].imageUrl1!.isNotEmpty) {
      image_url1.value = expense_line_submit_list[0].lines![position].imageUrl1.toString()!;
      // files_count.value++;
    }
    if (expense_line_submit_list[0].lines![position].imageUrl2!.isNotEmpty) {
      image_url2.value = expense_line_submit_list[0].lines![position].imageUrl2.toString()!;
      //files_count.value++;
    }
    if (expense_line_submit_list[0].lines![position].imageUrl3!.isNotEmpty) {
      image_url3.value = expense_line_submit_list[0].lines![position].imageUrl3.toString()!;
      //files_count.value++;
    }

    if (files_count.value >= 0 && files_count.value<=3) {
      addFileButton.value = true;
    }
    expenseAttachmentCount();

  }

  expenseAttachmentCount(){
    files_count.value=0;
    if (image_url.isNotEmpty || file_path0.isNotEmpty) {
      files_count.value++;
    }
    if (image_url1.isNotEmpty || file_path1.isNotEmpty) {
      files_count.value++;
    }
    if (image_url2.isNotEmpty || file_path2.isNotEmpty ){
      files_count.value++;
    }
    if (image_url3.isNotEmpty || file_path3.isNotEmpty ) {
      files_count.value++;
    }

  }

  void resetAllFields() {
    expense_catagory_controller.text='';
    iscategoryExpense.value=false;
    //  expense_catagory_list.clear();
    isshowDate.value = false;
    isshowtotalKm.value = false;
    isShowImage.value=false;
    iscategoryExpense.value=true;
    addFileButton.value = true;
    isLodging.value=0;
    isKm.value=0;
    description_controller.text = '';
    date_controller.text = '';
    amount_controller.text = '';
    from_date_controller.text= '';
    to_date_controller.text= '';
    region_catagory_controller.text= '';
    total_km_controller.text= '';
    remark_controller.text= '';
    selectedContainerIndex.value = 0;
    imageCount.value=0;
    file_path0.value = '';
    file_path1.value = '';
    file_path2.value = '';
    file_path3.value = '';


  }


  Future<void> compressAndSaveImage(File file, String outputPath, int maxSizeInBytes) async {
    // Load the image from file
    List<int> imageBytes = await file.readAsBytes();
    Uint8List uint8List = Uint8List.fromList(imageBytes);
    img.Image image = img.decodeImage(uint8List)!;

    // Set the desired image width and initial quality
    int desiredWidth = 200; // Adjust this based on your needs
    int initialQuality = 90; // Initial quality value

    // Resize the image if it's too large
    if (image.width > desiredWidth) {
      image = img.copyResize(image, width: desiredWidth);
    }

    int currentQuality = initialQuality;
    List<int> compressedImageBytes;

    do {
      // Encode the image to JPEG with the current quality
      compressedImageBytes = img.encodeJpg(image, quality: currentQuality);

      // Update quality for the next iteration
      currentQuality -= 5;

      // Break the loop if quality drops below 5
      if (currentQuality < 5) {
        break;
      }
    } while (compressedImageBytes.length > maxSizeInBytes);

    // Save the compressed image to the specified output path
    await File(outputPath).writeAsBytes(compressedImageBytes);
    print("image size ......${compressedImageBytes.length}");
  }



  Future<File> compressImage(File imageFile, double targetSize) async {
    int currentQuality = 100;
    img.Image? image = img.decodeImage(await imageFile.readAsBytes());

    // Resize the image to a desired size
    img.Image resizedImage = img.copyResize(image!, width: 800);

    // Convert the image to a compressed format (JPEG) with a specific quality
    List<int> compressedBytes = img.encodeJpg(resizedImage, quality: 50);

    // Save the compressed image to a new file
    File compressedFile = File(imageFile.path.replaceAll(".jpg", "_compressed.jpg"));
    await compressedFile.writeAsBytes(compressedBytes);
    print("Size of compressed image: ${compressedFile.lengthSync()} bytes");

    return compressedFile;
  }

   var targetSizeInBytes = 3 * .01;
  void upLoadImage(BuildContext context, String flag) async{
    var image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      isShowImage.value = false;
      String outputPath = image.path;
      int maxSizeInBytes = 3000 * 1024;
       await compressAndSaveImage(File(image.path),outputPath, maxSizeInBytes);
      if (flag.isEmpty) {
        if (selectedContainerIndex.value == 0) {
          file_path0.value = image.path;
          imageCount+=1;
        } else if (selectedContainerIndex.value == 1) {
          file_path1.value = image.path;
          imageCount+=1;

        } else if (selectedContainerIndex.value == 2) {
          file_path2.value = image.path;
          imageCount+=1;

        } else if (selectedContainerIndex.value == 3) {
          file_path3.value = image.path;
          imageCount+=1;

        }
        selectedContainerIndex.value++;
      } else {
        if (flag == 'file_one') {
          if(file_path0.value.isEmpty){
            imageCount+=1;
          }
          file_path0.value = image.path;

        } else if (flag == 'file_two') {
          if(file_path1.value.isEmpty){
            imageCount+=1;

          }
          file_path1.value = image.path;

        } else if (flag == 'file_three') {
          if(file_path2.value.isEmpty){
            imageCount+=1;

          }
          file_path2.value = image.path;

        } else if (flag == 'file_four') {
          if(file_path3.value.isEmpty){
            imageCount+=1;
            addFileButton.value=false;
            addFileButton.value=true;
          }
          file_path3.value = image.path;
        }

      }
      isShowImage.value = true;

      expenseAttachmentCount();
      if (selectedContainerIndex > 3) {
        addFileButton.value = false;
      } else {
        //Utils.sanckBarError('Image!', 'No Select Any Image');
      }
    }
  }

  // 8KB

}
