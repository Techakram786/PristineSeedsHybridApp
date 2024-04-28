import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pristine_seeds/current_location/current_location.dart';
import 'package:pristine_seeds/find_area/AreaControler.dart';
import 'package:pristine_seeds/utils/app_utils.dart';
import 'package:pristine_seeds/view_model/services/splash_services.dart';
import '../../constants/app_colors.dart';
import '../../size_config.dart';
import 'components/body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices=SplashServices();

  AreaCalculator areaCalculator=AreaCalculator();
   double area=0.0;

  List<Offset> polygonCoordinates = [
   Offset(28.6134365, 77.3880032),
   Offset(30.6234365, 78.3980032),
   Offset(30.6334365, 79.4080032),
   Offset(31.6434365, 80.4180032),
   //Offset(4, 0),
   //Offset(4, 3),
   //Offset(0, 3),
  ];
  final size =Get.size.height;
  bool isLoading = true; // Added to track whether images are loading
  late ImageProvider logo;
  @override
  void initState() {
    super.initState();






    //locationData.getCurrentPosition();
    //locationData.getCurrentLocation();//
    area=areaCalculator.calculatePolygonArea(polygonCoordinates);
    String maer=area.toStringAsFixed(3);
    if (maer.contains('e')) {//1.01e-15
      List<String> parts = maer.split('e');
      maer= double.parse(parts[0]).toString(); // Convert scientific notation to a regular number string
    }
    print('area is : $maer');
    splashServices.isLogin();
   // splashServices.checkInternetAndRequest(context);

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body()
    );
  }

}
