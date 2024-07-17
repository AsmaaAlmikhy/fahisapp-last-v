// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({
//     Key? key,
//     this.title = '',
//   }) : super(key: key);

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       centerTitle: true,
//       actions: [
//         IconButton(
//           onPressed: () {},
//           icon: const Icon(
//             Icons.arrow_forward,
//             color: Colors.black,
//             size: 30,
//           ),
//         ),
//       ],
//       backgroundColor: Colors.transparent,
//       elevation: 1,
//       toolbarHeight: 90,
//       title: Text(
//         title,
//         style: const TextStyle(
//           color: Colors.black,
//           fontSize: 25,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       flexibleSpace: Container(
//         decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20),
//             ),
//             color: Colors.white),
//       ),
//     );
//   }

//   @override
//   dynamic noSuchMethod(Invocation invocation) => const Size(
//         double.maxFinite,
//         80,
//       );
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title = '',
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_forward,
            color: Colors.black,
            size: 30,
          ),
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 1,
      toolbarHeight: 90,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => const Size(
        double.maxFinite,
        80,
      );
}
