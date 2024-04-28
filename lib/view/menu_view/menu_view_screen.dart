import 'package:flutter/material.dart';
import 'package:pristine_seeds/models/loginModel/login_model.dart';
import 'package:pristine_seeds/view/menu_view/bottom_sheet_screen.dart';
import 'package:pristine_seeds/view_model/services/splash_services.dart';
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: MyDraggableBottomSheet(),
        )
    );
  }

}

