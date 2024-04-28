import 'package:get/get.dart';
import 'package:pristine_seeds/repository/check_out_repository/CheckOutRepository.dart';

class CheckOutViewModel extends GetxController {
  final _api = CheckOutRepository();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

}
