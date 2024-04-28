import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/constants/app_colors.dart';
import '../constants/app_font_size.dart';
class DefaultElevatedButton extends StatelessWidget {
   DefaultElevatedButton({
     Key? key,
     this.text,
     this.press,
     this.loading=false,
  }) : super(key: key);
   final String? text;
   final Function? press;
   final bool loading;
   Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height:size.height*.07,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),

        ),
        onPressed: loading ? null : press as void Function()?, // Disable button while loading
        child: loading
            ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            AllColors.primaryDark1, // You can change the color to your preference
          ),
        )
            : Text(
          text!,
          style: GoogleFonts.poppins(
              fontSize:AllFontSize.sisxteen,
              color: Colors.white,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}
