import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pristine_seeds/constants/app_colors.dart';
import 'package:pristine_seeds/constants/font_weight.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';

import '../../constants/app_font_size.dart';
import '../../models/loginModel/login_model.dart';
import '../../resourse/routes/routes_name.dart';
import '../../view_model/dash_board_vm/DashboardVM.dart';
import '../../view_model/notification_vm/NotificationViewModel.dart';
import '../dash_view/dash_board_screen.dart';
import '../notification_view/notification_view_screen.dart';
import '../profile_view/profile_view_screen.dart';

class HomePageScreen extends StatefulWidget {
   HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();

}

class _HomePageScreenState extends State<HomePageScreen> {
  SessionManagement sessionManagement = SessionManagement();
  final DashboardVM controller = Get.put(DashboardVM());
  final NotificationVM notification_pageController = Get.put(NotificationVM());
  List<Menu> globalMenuList = [];
  List<Children> globalchildList = [];

  late List<Widget> _pages;
  late Widget _page1_dashboard;
  late Widget _page2_notification;
  late Widget _page3_profile;

  late int _currentIndex;
  late Widget _currentPage;
  bool isSecondGridViewVisible = false;

  @override
  void initState() {
    super.initState();

    _page1_dashboard = DashBoardScreen();
    _page2_notification = NotificationScreen();
    _page3_profile = ProfileScreen();

    _pages = [_page1_dashboard, _page2_notification, _page3_profile];

    _currentIndex = 0;
    _currentPage = _page1_dashboard;
    MenuList();
  }

  void changeTab(int index) {
    setState(() {
      if (index == 0) {
        _currentIndex = index;
        _currentPage = _pages[index];
        isSecondGridViewVisible = false; // Hide the second GridView
      } else if (index == 1) {
        _showBottomSheet(context);
      } else {
        index = index - 1;
        _currentIndex = index;
        _currentPage = _pages[index];
        isSecondGridViewVisible = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPage,
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          items: [
            Icon(
              Icons.dashboard,
              size: 30,
              color: Colors.white,
            ),
            Icon(Icons.menu, size: 30),
            Stack(children: [
              Icon(Icons.notifications, size: 30),
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration:  BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Obx(() {
                    return Visibility(
                      visible:notification_pageController.totalUnacknowledgedCount>=0 ? true:false ,
                      child: Text(
                        notification_pageController.totalUnacknowledgedCount.value.toString(),
                        style:TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                  ),
                ),
              )
            ]),

            Icon(Icons.person, size: 30),
          ],
          buttonBackgroundColor: AllColors.primaryDark1,
          height: 60,
          animationCurve: Curves.easeInOut,
          backgroundColor: AllColors.primaryDark1,
          color: Colors.black12,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (int index) => setState(() {
            changeTab(index);
          }),
        ),
      ),
    );
  }

  double _container_height = 200;
  String list_title="MY LIST";
  void _showBottomSheet(BuildContext context) {
    Size size = Get.size;
    /* double height_of_container =
    ((_list_length % 2) == 0 ? ((_list_length * 100) + 100) : (((_list_length + 1) * 100) + 100));*/
    double height_of_container =
    ((globalMenuList.length % 2) == 0 ? ((globalMenuList.length * 40) + 40) : (((globalMenuList.length + 1) * 40) + 40));
    //(globalMenuList.length % 2) == 0 ? ((globalMenuList.length * 100) + 50) : (((globalMenuList.length + 1) * 100) + 50));
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        // Calculate the height based on the number of items
        double calculatedHeight = height_of_container;
        final itemCount = globalMenuList.length; // Replace with your actual item count
        return StatefulBuilder(
          builder: (context, setState) {
            return ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
              child: Container(
                //height: calculatedHeight,
                height: MediaQuery.of(context).size.height * 0.5,//for fix hight..
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 3.0,
                                  offset: Offset(0.0, 0.55)
                              )
                            ],
                            color: Colors.white
                        ),
                        child: Column(
                          children: [
                            Container(
                                color: Colors.grey,
                                margin:EdgeInsets.only(left: 0,right: 0,top: 15,bottom: 0),
                                height: 5,
                                width:100
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0,right: 0,bottom: 10,top: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Visibility(
                                    visible: isSecondGridViewVisible,
                                    maintainSize: true,
                                    maintainAnimation: true,
                                    maintainState: true,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                        size: 35,
                                        color: AllColors.primaryDark1,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isSecondGridViewVisible = false;
                                          list_title = "MY LIST";
                                          calculatedHeight=((globalMenuList.length % 2) == 0 ? ((globalMenuList.length * 100) + 50) : (((globalMenuList.length + 1) * 100) + 50));
                                        });
                                        // Dismiss the bottom sheet when cancel icon is clicked
                                      },
                                    ),
                                  ),
                                  Text(
                                    list_title,
                                    style: TextStyle(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.titleSize,
                                      fontWeight: AllFontWeight.title_weight,
                                      fontFamily: "Ageo Persona",
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.cancel,
                                      size: 35,
                                      color: AllColors.primaryDark1,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        list_title = "MY LIST";
                                        isSecondGridViewVisible = false;
                                      });
                                      // Dismiss the bottom sheet when cancel icon is clicked
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView(
                        children: [
                          Visibility(
                            visible: !isSecondGridViewVisible,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4, // Number of columns in the grid
                              ),
                              itemCount: itemCount,
                              // Number of items in the grid
                              itemBuilder: (BuildContext context, int index) {
                                String title = globalMenuList[index].title.toString();
                                Widget imageWidget;

                                switch (title) {
                                  case 'TA/DA':
                                    imageWidget = Image.asset(
                                      "assets/images/tada.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'Order':
                                    imageWidget = Image.asset(
                                      "assets/images/orders.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'Approvals':
                                    imageWidget = Image.asset(
                                      "assets/images/approver.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'Master':
                                    imageWidget = Image.asset(
                                      "assets/images/masters.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'User':
                                    imageWidget = Image.asset(
                                      "assets/images/user.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;

                                  case 'Reports':
                                    imageWidget = Image.asset(
                                      "assets/images/reports.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;

                                  case 'Planting':
                                    imageWidget = Image.asset(
                                      "assets/images/planting.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;

                                  case 'Inspection':
                                    imageWidget = Image.asset(
                                      "assets/images/inspection.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'M & S':
                                    imageWidget = Image.asset(
                                      "assets/images/ms.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;

                                  case 'Event':
                                    imageWidget = Image.asset(
                                      "assets/images/event_management.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;

                                  default:
                                  // Use a default image or widget if the title doesn't match any case
                                    imageWidget = Image.asset(
                                      "assets/images/master.png",
                                      fit: BoxFit.cover,
                                    );
                                }

                                return InkWell(
                                  onTap: () {
                                    // Handle item click here
                                    print('Item $index clicked');
                                    setState(() {
                                      isSecondGridViewVisible = true;
                                      globalchildList = globalMenuList[index].children!;
                                      // Calculate the height based on the number of child items
                                      if(isSecondGridViewVisible){
                                        calculatedHeight=(globalchildList.length % 2) == 0 ? ((globalchildList.length * 100) + 50) : (((globalchildList.length + 1) * 100) + 50);
                                        list_title=title;
                                      }
                                    });
                                    // You can replace the print statement with your custom logic.
                                  },
                                  splashColor: Colors.green,
                                  child: Card(
                                  shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.all(Radius.circular(8.0))), // No border radius
                                    child: Container(
                                      height: _container_height,
                                      decoration: BoxDecoration(
                                          color: AllColors.ripple_green,
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: AllColors.lightgreyColor,width: .5)

                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Container(
                                                height: 60,
                                                width: 60, // Set the desired image width
                                                child: imageWidget
                                            ),
                                          ),
                                          //SizedBox(height: 5,),
                                          //Spacer(),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 3.0),
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                globalMenuList[index].title.toString(),
                                                style: TextStyle(
                                                  color: AllColors.primaryDark1,
                                                  fontWeight: AllFontWeight.subtitle_weight,
                                                  fontSize: AllFontSize.twelve,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          Visibility(
                            visible: isSecondGridViewVisible,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4, // Number of columns in the grid
                              ),
                              itemCount: globalchildList.length,
                              // Number of items in the grid
                              itemBuilder: (BuildContext context, int index) {
                                String title = globalchildList[index].title.toString();
                                Widget imageWidget;
                                switch (title) {
                                  case 'Check In/Out':
                                    imageWidget = Image.asset(
                                      "assets/images/checkin.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'Check In':
                                    imageWidget = Image.asset(
                                      "assets/images/approval.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;

                                  case 'Expense':
                                    imageWidget = Image.asset(
                                      "assets/images/expapprove.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;

                                  case 'Orders Approval':
                                    imageWidget = Image.asset(
                                      "assets/images/order_approver.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'Order':
                                    imageWidget = Image.asset(
                                      "assets/images/orders.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'CheckIn Approval':
                                    imageWidget = Image.asset(
                                      "assets/images/approval.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'User Route':
                                    imageWidget = Image.asset(
                                      "assets/images/route.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'User Expense':
                                    imageWidget = Image.asset(
                                      "assets/images/user_expense.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'User List':
                                  imageWidget = Image.asset(
                                    "assets/images/user_list.png",
                                    fit: BoxFit.cover,
                                  );
                                  break;
                                  case 'Order List':
                                    imageWidget = Image.asset(
                                      "assets/images/orderslist.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;

                                  case 'User Role':
                                    imageWidget = Image.asset(
                                      "assets/images/user_role.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;

                                  case 'Shift Master':
                                    imageWidget = Image.asset(
                                      "assets/images/shift_master.png",
                                     // color: AllColors.primaryDark1,
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'Grade Master':
                                    imageWidget = Image.asset(
                                      "assets/images/grade_master.png",
                                      //color: AllColors.primaryDark1,
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'Travel Type':
                                    imageWidget = Image.asset(
                                      "assets/images/travel_type.png",
                                      //color: AllColors.primaryDark1,
                                      fit: BoxFit.cover,
                                    );
                                    break;

                                  case 'Planting List':
                                    imageWidget = Image.asset(
                                      "assets/images/planting_list.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;

                                  case 'Online Inspection':
                                    imageWidget = Image.asset(
                                      "assets/images/onlineInspection.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;

                                  case 'Offline Inspection':
                                    imageWidget = Image.asset(
                                      "assets/images/oflineInspection.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'Customer':
                                    imageWidget = Image.asset(
                                      "assets/images/customer.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'Seed Dispatch Note':
                                    imageWidget = Image.asset(
                                      "assets/images/seeddispetch.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'Collection':
                                    imageWidget = Image.asset(
                                      "assets/images/collections.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'POG':
                                    imageWidget = Image.asset(
                                      "assets/images/product_on_ground.png",
                                      fit: BoxFit.cover,
                                    );
                                  case 'POG Approval':
                                    imageWidget = Image.asset(
                                      "assets/images/pog_approve.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'Event List':
                                    imageWidget = Image.asset(
                                      "assets/images/event_list.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'Event Approval':
                                    imageWidget = Image.asset(
                                      "assets/images/event_approval.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;

                                  case 'CustomerRequest':
                                    imageWidget = Image.asset(
                                      "assets/images/customer-support.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;

                                  case 'IPT':
                                    imageWidget = Image.asset(
                                      "assets/images/ipt_list.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;

                                  case 'IPT Approval':
                                    imageWidget = Image.asset(
                                      "assets/images/ipt_approval.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  case 'Shipped Order':
                                    imageWidget = Image.asset(
                                      "assets/images/shippedOrder.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;

                                  case 'C R Approver':
                                    imageWidget = Image.asset(
                                      "assets/images/customerRequestApproval.png",
                                      fit: BoxFit.cover,
                                    );
                                    break;
                                  default:
                                    imageWidget = Image.asset(
                                      "assets/images/shift.png",
                                      fit: BoxFit.cover,
                                    );
                                }

                                return GestureDetector(
                                  onTap: () {
                                    switch(title){
                                      case "Check In/Out":
                                        Get.toNamed(RoutesName.checkInScreen,preventDuplicates: false);
                                        break;
                                      case "Check In":
                                        Get.toNamed(RoutesName.checkInApproverScreen,preventDuplicates: false);
                                        break;
                                      case "User Route":
                                        Get.toNamed(RoutesName.userRoutesScreen,preventDuplicates: false);
                                        break;
                                      case "User Expense":
                                        Get.toNamed(RoutesName.myExpensesScreen,preventDuplicates: false);
                                        break;
                                      case "Order List":
                                        Get.toNamed(RoutesName.ordersScreen,preventDuplicates: false);
                                        break;
                                      case "Expense":
                                        Get.toNamed(RoutesName.expanseApproverScreen,preventDuplicates: false);
                                        break;
                                      case "Orders Approval":
                                        Get.toNamed(RoutesName.orderApproverScreen,preventDuplicates: false);
                                        break;

                                      case "Planting List":
                                        Get.toNamed(RoutesName.planting_list,preventDuplicates: false);
                                        break;

                                      case "Online Inspection":
                                        Get.toNamed(RoutesName.onlineInspaction,preventDuplicates: false);
                                        break;

                                      case "Offline Inspection":
                                        Get.toNamed(RoutesName.offlineInspection,preventDuplicates: false);
                                        break;

                                      case "Customer":
                                        Get.toNamed(RoutesName.customerList,preventDuplicates: false);
                                        break;
                                      case "Seed Dispatch Note":
                                        Get.toNamed(RoutesName.seedDispatchList,preventDuplicates: false);
                                        break;
                                      case "Collection":
                                        Get.toNamed(RoutesName.collectionScreen,preventDuplicates: false);
                                        break;

                                      case "POG":
                                        Get.toNamed(RoutesName.productongroundScreen,preventDuplicates: false);
                                        break;

                                      case "POG Approval":
                                        Get.toNamed(RoutesName.productOnGroundApproval,preventDuplicates: false);
                                        break;

                                      case "Event List":
                                        Get.toNamed(RoutesName.eventMngGetList,preventDuplicates: false);
                                        break;

                                      case "Event Approval":
                                        Get.toNamed(RoutesName.eventApproval,preventDuplicates: false);
                                        break;

                                      case "CustomerRequest":
                                        Get.toNamed(RoutesName.customerRequestList,preventDuplicates: false);
                                        break;


                                      case "IPT":
                                        Get.toNamed(RoutesName.iptHeaderList,preventDuplicates: false);
                                        break;
                                      case "IPT Approval":
                                        Get.toNamed(RoutesName.iptApproverScreen,preventDuplicates: false);
                                        break;


                                      case "Shipped Order":
                                        Get.toNamed(RoutesName.shippedOrderScreen,preventDuplicates: false);
                                        break;


                                      case "C R Approver":
                                        Get.toNamed(RoutesName.customerRequestApproverList,preventDuplicates: false);
                                        break;


                                    }
                                    print('Item $index clicked');
                                    // You can replace the print statement with your custom logic.
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                    child: Container(
                                      height: _container_height,
                                      decoration: BoxDecoration(
                                          color: AllColors.ripple_green,
                                          borderRadius: BorderRadius.circular(8.0),
                                          border: Border.all(color: AllColors.lightgreyColor,width: .5)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4.0),
                                            child: Container(
                                                width: 60,
                                                height: 60,// Set the desired image width
                                                child: imageWidget
                                            ),
                                          )
                                          ,
                                          //Spacer(),
                                          //SizedBox(height: 5.0),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 3.0),
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                globalchildList[index].title.toString(),
                                                style: TextStyle(
                                                  color: AllColors.primaryDark1,
                                                  fontWeight: AllFontWeight.bodyeight,
                                                  fontSize: AllFontSize.ten,
                                                ),
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          // Add other content here if needed
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }


  Future<List<Menu>?> MenuList() async {
    await sessionManagement.getMenuList().then((menuList) {
      globalMenuList = menuList;
      return globalMenuList;
    });
  }
}