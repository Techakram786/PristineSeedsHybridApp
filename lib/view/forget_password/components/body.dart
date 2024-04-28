import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/constants/app_colors.dart';
import 'package:pristine_seeds/constants/app_titles.dart';
import 'package:pristine_seeds/size_config.dart';
import 'package:pristine_seeds/view_model/forgot_password_vm/forgot_password_vm.dart';
import '../../../components/back_button.dart';
import '../../../components/default_button.dart';
import '../../register_view/register_screen.dart';

class Body extends StatelessWidget {
  Body({super.key});

  final passwordVM=Get.put(ForgotPasswordViewModel());

  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? email;

  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: size.height *.05,),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top:0,left: 10),
              child: CircleBackButton(
                press:(){
                  Get.back();
                },
              ),
            ),
          ),

          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Container(
                    padding: EdgeInsets.all(8),
                    width: 120, // Set the desired image width
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black12
                    ),
                    // Set the desired image height
                    child: Image.asset(
                      "assets/images/pristine_pfulfil.png",
                      fit: BoxFit.cover, // You can adjust the BoxFit as needed
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Text(Apptitles.forgot_password,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(28),
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  Text(
                      Apptitles.password_description,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                          fontStyle: FontStyle.normal)
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.1),
                  //ForgotPassForm(),
                ],

              ),

            ),
          ),
          Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  TextFormField(
                    controller:passwordVM.emailController.value ,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: AllColors.primaryDark1,
                    //onSaved: (newValue) => email = newValue,
                    onChanged: (value) {
                      // Clear the error when the user enters a value
                      if (value.isNotEmpty) {
                        _formKey.currentState?.validate();
                      }
                    },
                    validator: (value){
                      if (value!.isEmpty) {
                        return "Email can't be blank";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      hintStyle: TextStyle(color: AllColors.primaryDark1),
                      prefixIcon: Icon(
                        Icons.email,
                        color: AllColors.primaryDark1,
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      // Light gray background
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height *.1),
                   Obx(() {
                    return DefaultButton(
                      text: "Continue",
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          passwordVM.loading.value = true;
                          passwordVM.forgotPasswordApi();
                        }
                      },
                      loading: passwordVM.loading.value,
                    );
                  }),
                ],
              ),
            ),
          ),
          SizedBox(height: size.height *.1),
          GestureDetector(
            child: GestureDetector(
              onTap: () {
               /* Get.to(RegisterScreen(),
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(seconds: 1));*/
              },
              child: Container(
                margin: EdgeInsets.only(top: 16.0,left: 16,right: 16),
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Ageo Persona',
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          color: AllColors.primaryDark1,
                          //fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

