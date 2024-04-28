import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/constants/app_colors.dart';
import 'package:pristine_seeds/constants/app_titles.dart';
import 'package:pristine_seeds/size_config.dart';
import 'package:pristine_seeds/view_model/create_password_vm/create_password_vm.dart';
import '../../../components/back_button.dart';
import '../../../components/default_button.dart';
import '../../../view_model/session_management/session_management_controller.dart';
class Body extends StatelessWidget {
  Body({super.key});
  SessionManagement sessionManagement=SessionManagement();
  final passwordVM=Get.put(CreatePasswordViewModel());
  final _formKey = GlobalKey<FormState>();


  List<String> errors = [];
  String? email;
  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: size.height *.05),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 0,left: 10),
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
                  Text(Apptitles.create_password,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(28),
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      Apptitles.create_password_description,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                          fontStyle: FontStyle.normal)
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                 // ForgotPassForm(),
                  Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: false,
                      enabled: false,
                      initialValue:Get.arguments.toString(),
                      keyboardType: TextInputType.emailAddress,
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
                    SizedBox(height: 10),
                    TextFormField(
                      controller:passwordVM.otpController.value ,
                      cursorColor: AllColors.primaryDark1,
                      keyboardType: TextInputType.number,
                      //onSaved: (newValue) => email = newValue,
                      onChanged: (value) {
                        // Clear the error when the user enters a value
                        if (value.isNotEmpty) {
                          _formKey.currentState?.validate();
                        }
                      },
                      validator: (value){
                        if (value!.isEmpty) {
                          return "OTP can't be blank";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your otp",
                        hintStyle: TextStyle(color: AllColors.primaryDark1),
                        prefixIcon: Icon(
                          Icons.mobile_off,
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
                    SizedBox(height: 10),
                    TextFormField(
                      controller: passwordVM.newPassController.value,
                      obscureText: !passwordVM.isPasswordVisible.value,

                      cursorColor: AllColors.primaryDark1,
                      //obscuringCharacter: "*",
                      validator: (value){
                        if (value!.isEmpty) {
                          return "Password can't be blank";
                        }
                        return null;
                      },

                      onChanged: (value) {
                        // Clear the error when the user enters a value
                        if (value.isNotEmpty) {
                          _formKey.currentState?.validate();
                        }
                      },

                      onFieldSubmitted: (value){
                        //Utils.fieldFocusChange(context, passwordVM.passFocusNode.value, loginVM.emailFocusNode.value);
                      },// Password field
                      decoration: InputDecoration(
                        hintText: "Enter your new password",
                        hintStyle: TextStyle(color: AllColors.primaryDark1),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: AllColors.primaryDark1,
                        ),
                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: Obx(() {
                          return IconButton(
                            icon: Icon(
                              passwordVM.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AllColors.primaryDark1,
                            ),
                            onPressed: () {
                              passwordVM.isPasswordVisible.value = !passwordVM.isPasswordVisible.value; // Toggle visibility
                            },
                          );
                        }),
                        // Add an eye icon for password visibility
                        filled: true,
                        fillColor: Colors.grey[50],
                        // Light gray background
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                  ],
                ),
              ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Obx(()  {
                    return DefaultButton(
                      text: "Continue",
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          passwordVM.loading.value=true;
                          passwordVM.forgotPasswordApi();
                        }
                      },
                      loading: passwordVM.loading.value,
                    );
                  }),
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
}

