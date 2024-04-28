
import 'package:flutter/material.dart';
import 'package:pristine_seeds/models/loginModel/login_model.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';
class MyDraggableBottomSheet extends StatelessWidget {
   const MyDraggableBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Center(

        child: InkWell(child: Text("click",style: TextStyle(color: Colors.black,fontSize: 20.0),),onTap: (){
          _showBottomSheet(context);
        },),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9, // Adjust the height as needed
          child: SingleChildScrollView(
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in the grid
                  ),
                  itemCount: 10, // Number of items in the grid
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // Handle item click here
                        print('Item $index clicked');
                        // You can replace the print statement with your custom logic.
                      },
                      child: Card(
                        child: Center(
                          child: Text('Item $index'),
                        ),
                      ),
                    );
                  },
                ),
                // Add other content here if needed
              ],
            ),
          ),
        );
      },
    );
  }

}
