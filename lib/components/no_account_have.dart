import 'package:flutter/material.dart';
import 'package:pristine_seeds/constants/app_colors.dart';

import '../size_config.dart';
class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        GestureDetector(
          onTap: () => {
            press as void Function()?,
          },
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
      ],
    );
  }
}
