import 'package:flutter/material.dart';
//import 'package:percent_indicator/circular_percent_indicator.dart';

//import 'DeleteDropDown.dart';

class ServicesContainer extends StatelessWidget {
  final String imageTextService;
  final String textService;

  const ServicesContainer({
    Key? key,
    required this.textService,
    required this.imageTextService,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      // color: Colors.red,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 234, 224, 224),
      ),
      child: Row(
        children: [
          Image.asset(imageTextService, height: 50, width: 100),
          Text(
            textService,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}



// Container(
//         height: 370,
//         padding: const EdgeInsets.all(10),
//         child: Stack(
//           children: [
            
//             Positioned(
//               child: Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         Theme.of(context).colorScheme.primaryContainer,
//                         Theme.of(context).colorScheme.secondaryContainer,
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   width: 350,
//                   height: 300,
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 215,
//               left: 30,
//               child: Text(
//                 TextService,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
           
//             Positioned(
//               left: 85,
//               bottom: 230,
//               child: Image.asset(imageTextService, height: 20, width: 20),
//             ),
//             Positioned(
//               bottom: 100,
//               right: 45,
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Theme.of(context).colorScheme.primary,
//                       Theme.of(context).colorScheme.secondary,
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(13),
//                 ),
//                 height: 40,
//                 width: 250,
                
//               ),
//             ),
//             Positioned(
//               bottom: 50,
//               right: 45,
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Theme.of(context).colorScheme.primary,
//                       Theme.of(context).colorScheme.secondary,
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(13),
//                 ),
//                 height: 40,
//                 width: 250,
               
                
//                 ),
//             ),
//             Positioned(
//               bottom: 160,
//               left: 30,
//               child: Container(
//                 padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
//                 decoration: BoxDecoration(
//                   // color: Color.fromARGB(31, 130, 66, 66),
//                   borderRadius: BorderRadius.circular(15),
//                   border: Border.all(),
//                 ),
//                 child: const Text(
//                   "123-ABC",
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
           
          
           
//           ],
//         ),

//     );