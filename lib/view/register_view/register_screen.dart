import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/components/back_button.dart';
import 'package:pristine_seeds/constants/app_colors.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';

import '../../components/default_button.dart';
import '../../size_config.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordVisible = false;
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              Positioned(
                  top: 40,
                  left: 15.0,
                  child: CircleBackButton(
                    press:(){
                      Get.back();
                    },
                  )),
              Positioned(
                top: 80,
                child: Column(
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: AllColors.primaryColor,
                          fontFamily: 'Ageo Persona'),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Text("Create your new account",
                        style: GoogleFonts.roboto(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                            fontStyle: FontStyle.normal)),
                  ],
                ),
              ),
              Positioned(
                top: 80,
                right: 0,
                child: // Add spacing between text and image
                Image.asset(
                  "assets/images/leaves_img.png", // Replace with your image path
                  width: 120.0, // Adjust width as needed
                  height: 70.0, // Adjust height as needed
                ),
              ),
              Positioned(
                top: 170, // Adjust the vertical position as needed
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    ListView(shrinkWrap: true, children: [
                      TextField(
                        cursorColor: AllColors.primaryDark1,
                        decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: Icon(
                            Icons.person,
                            color: AllColors.primaryDark1,
                          ),
                          // Add a clear icon if needed
                          filled: true,
                          fillColor: Colors.grey[50],
                          // Light gray background
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(height: 10), // Add spacing between text fields
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: AllColors.primaryDark1,
                        ),
                        // Add a clear icon if needed
                        filled: true,
                        fillColor: Colors.grey[50],
                        // Light gray background
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10), // Add spacing between text fields
                    TextField(
                      obscureText: !_isPasswordVisible,
                      cursorColor: AllColors.primaryDark1,// Password field
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: AllColors.primaryDark1,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AllColors.primaryDark1,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
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
                    SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 6.0),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: AllColors.primaryDark1,
                            fontFamily: 'Ageo Persona' // Change text color as needed
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    // Add Login button
                   /* Positioned(
                      bottom: 60,
                      child: DefaultButton(
                        text: "Sign Up",
                        press: () {

                        },
                      ),

                    ),*/
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                child: GestureDetector(
                  onTap: () {
                    //Get.to(LoginScreen());
                    Get.toNamed(RoutesName.loginScreen);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                              color: AllColors.primaryDark1,
                              fontFamily: 'Ageo Persona',
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
        ),
      ),
    );
  }
}
