import 'package:fahisapp/screens/my_services/past_services.dart';
import 'package:flutter/material.dart';

import 'current_services.dart';

class MyServices extends StatefulWidget {
  const MyServices({super.key});

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xffFFF8F1),
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: const Text(
              "خدماتي",
              style: TextStyle(color: Colors.black),
            ),
            bottom: TabBar(
              indicatorColor: Colors.orange,
              tabs: [
                Tab(
                  child: Container(
                    height: 50,
                    width: 180,
                    decoration: const BoxDecoration(
                      color: Color(0xffF2CDAD),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "السابقة",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    height: 50,
                    width: 180,
                    decoration: const BoxDecoration(
                      color: Color(0xffF2CDAD),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "الحالية",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          body: const TabBarView(
            children: [
              PastServices(),
              CurrentServices(),
            ],
          ),

          // bottomNavigationBar: FABBottomAppBarItem(iconData: Icons.access_alarm, text: "h",),
          // body: Container(
          //   color: const Color(0xffFFF8F1),
          //   child: Column(
          //     children: [
          //       Container(
          //         margin: const EdgeInsets.all(10),
          //         width: double.infinity,
          //         height: 90,
          //         decoration: const BoxDecoration(
          //           borderRadius: BorderRadius.all(
          //             Radius.circular(20),
          //           ),
          //           color: Colors.white,
          //         ),
          //         child: Stack(
          //           children: [
          //             const Positioned(
          //               right: 25,
          //               bottom: 50,
          //               child: Text(
          //                 "تغيير زيت المحرك ",
          //                 style: TextStyle(color: Colors.black, fontSize: 18),
          //               ),
          //             ),
          //             Positioned(
          //               right: 25,
          //               bottom: 20,
          //               child: Text(
          //                 "1234 ABC",
          //                 style: TextStyle(color: Colors.grey[600]),
          //               ),
          //             ),
          //             const Positioned(
          //               left: 20,
          //               top: 16,
          //               child: Text(
          //                 " 12/5/2023",
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
