import 'package:connectivity/connectivity.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../view_model/dash_board_vm/DashboardVM.dart';

class StaticMethod{
  static String? convertDateFormat(String inputDate) {
    final inputFormat = DateFormat('dd-MM-yyyy');
    final outputFormat = DateFormat('yyyy-MM-dd');
    try {
      final date = inputFormat.parse(inputDate);
      return outputFormat.format(date);
    } catch (e) {
      print("Error parsing date: $e");
      return inputDate; // Handle the error as needed
    }
  }
  static String? convertDateFormat1(String inputDate) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final outputFormat = DateFormat(' dd-MM-yyyy');
    try {
      final date = inputFormat.parse(inputDate);
      return outputFormat.format(date);
    } catch (e) {
      print("Error parsing date: $e");
      return inputDate; // Handle the error as needed
    }
  }

  static String? dateTimeToDate(String inputDate){
    final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final outputFormat = DateFormat('dd-MM-yyyy hh:mm aa');
    try {
      final date = inputFormat.parse(inputDate);
      print(outputFormat.format(date));
      return outputFormat.format(date);
    } catch (e) {
      print("Error parsing date: $e");
      return inputDate; // Handle the error as needed
    }
    // try{
    //   List<String> dateTimeParts = dateTime.split("T");
    //   print(dateTimeParts);
    //   String date = dateTimeParts[0];
    //   String time = dateTimeParts[1];
    //   List<String> timeParts = time.split('.');
    //   String fomatedTime = timeParts[0];
    //   DateTime parsedDate1 = DateTime.parse(date);
    //   String formattedDate1 = DateFormat('dd-MM-yyyy').format(parsedDate1);
    //   return formattedDate1;
    // }catch(e){
    //
    // }

  }
  static String? onlyDate(String inputDate){
    final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final outputFormat = DateFormat('dd-MM-yyyy');
    try {
      final date = inputFormat.parse(inputDate);
      return outputFormat.format(date);
    } catch (e) {
      print("Error parsing date: $e");
      return inputDate; // Handle the error as needed
    }

  }

  static Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> stopBackgroundService()async{
    //todo stop background service
    if (DashboardVM.backgroundService != null){
      DashboardVM.backgroundService!.getServiceInstance()!.invoke('stopService');
      DashboardVM.backgroundService!.setServiceInstance(null);
      DashboardVM.backgroundService = null;
    }
  }

  /*static Future<void> strintToDecadeBase64()async{
    //todo stop background service

    try{
      return base64.decode(inspectinDetailPageController
          .online_offline_selected_inspection
          .value
          .fields![position]
          .fieldValue!);
    }catch(e){

    }

  }*/
  static Uint8List stringToDecodeBase64(String? base64String) {
    try {
      return base64.decode(base64String!);
    } catch (e) {
      return new Uint8List(0);
    }
  }

  static Future<String> getCurrentData()async{
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }
}