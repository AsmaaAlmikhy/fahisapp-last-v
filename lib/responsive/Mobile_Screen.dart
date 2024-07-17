// ignore: file_names

import 'package:fahisapp/controllers/add_vehicle_controller.dart';
import 'package:fahisapp/screens/AddVehicle.dart';
import 'package:fahisapp/screens/HomePage.dart';
import 'package:fahisapp/screens/NotificationsPage.dart';
import 'package:fahisapp/screens/Profile.dart';
import 'package:fahisapp/screens/my_services/MyServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  // To get data from DB using provider
  // getDataFromDB() async {
  //   UserProvider userProvider = Provider.of(context, listen: false);
  //   await userProvider.refreshUser();
  // }

  @override
  void initState() {
    super.initState();
    // getDataFromDB();
  }

  final PageController _pageController = PageController();

  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.delete<AddVehicleController>();
          Get.to(() => const AddVehicle());
        },
        backgroundColor: const Color.fromARGB(255, 236, 142, 54),
        //Floating action button on Scaffold
        //  onPressed:   _incrementCounter ,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
          ],
        ), //icon inside button
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //floating action button position to center

      bottomNavigationBar: CupertinoTabBar(
        height: 55,
        backgroundColor: Colors.white,
        onTap: (index) {
          // navigate to the tabed page
          _pageController.jumpToPage(index);
          setState(() {
            currentPage = index;
          });

          // print(   "---------------    $index "  );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: currentPage == 0
                  ? const Color.fromARGB(255, 236, 142, 54)
                  : Colors.grey,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.checklist,
              color: currentPage == 1
                  ? const Color.fromARGB(255, 236, 142, 54)
                  : Colors.grey,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: currentPage == 2
                  ? const Color.fromARGB(255, 236, 142, 54)
                  : Colors.grey,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: currentPage == 3
                  ? const Color.fromARGB(255, 236, 142, 54)
                  : Colors.grey,
            ),
            label: "",
          ),
        ],
      ),
      body: PageView(
        onPageChanged: (index) {},
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          HomePage(),
          MyServices(),
          NotificationPage(),
          Profile(),
        ],
      ),
    );
  }
}
