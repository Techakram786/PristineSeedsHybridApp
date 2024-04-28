import 'package:flutter/material.dart';
import 'package:pristine_seeds/constants/app_colors.dart';
class InternetExceptionwdget extends StatefulWidget {

  const InternetExceptionwdget({super.key});


  @override
  State<InternetExceptionwdget> createState() => _InternetExceptionwdgetState();
}

class _InternetExceptionwdgetState extends State<InternetExceptionwdget> {

  @override
  Widget build(BuildContext context) {
    final hieght=MediaQuery.of(context).size.height;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: hieght *.13,),
              Icon(Icons.cloud_off,color: AllColors.primaryliteColor,),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(child: Text("No Internet")
                ),
              ),
              SizedBox(height: hieght *.13,),
              InkWell(
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    color: AllColors.primaryColor,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Center(child: Text("Retry",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white)),
                  )
                ),
              ),
            ],
          ),);
  }
}
