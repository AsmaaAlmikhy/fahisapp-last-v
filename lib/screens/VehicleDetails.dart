//import 'package:untitled3/firebase_services/firestore.dart';
//import 'package:untitled3/shared/constant/app-bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahisapp/shared/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_vehicle_controller.dart';
import '../models/add_car_model.dart';

class VehicleDetails extends StatelessWidget {
  final VehicleModel selectedVehicle;
  const VehicleDetails({
    super.key,
    required this.selectedVehicle,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddVehicleController>(
      init: AddVehicleController(),
      builder: (_) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              appBar: const CustomAppBar(
                title: "تفاصيل المركبه",
              ),
              body: _.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        color: const Color.fromARGB(255, 240, 238, 234),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: CachedNetworkImage(
                                imageUrl: selectedVehicle.imageUrl ?? "",
                                height: 100,
                                width: 200,
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                            const Text(
                              "تفاصيل المركبة",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffE36D00),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 30),
                              decoration: const BoxDecoration(
                                color: Color(0x59D5D4D0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "شركة السيارة",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 55,
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 15.0,
                                          ), // C
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                        ),
                                        isExpanded: true,
                                        value: _.selectedVehicleCompany,
                                        items: _.vehicleCompanyList.map((e) {
                                          return DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          );
                                        }).toList(),
                                        onChanged: _.onChangeVehicleCompany,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      "موديل السيارة",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                    DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        enabled: _.vehicleModel.isNotEmpty,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                        ), // C
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                      ),
                                      isExpanded: true,
                                      value: _.selectedVehicleModel,
                                      items: _.vehicleModel.map((e) {
                                        return DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        );
                                      }).toList(),
                                      onChanged: _.onChangeVehicleModel,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      "سنة صنع السيارة",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                    DropdownButtonFormField(
                                      padding: null,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                        ), // C
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                      ),
                                      isExpanded: true,
                                      value: _.selectedVehicleYear,
                                      items: _.vehicleYear.map((e) {
                                        return DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        );
                                      }).toList(),
                                      onChanged: _.onChangeVehicleYear,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      "رقم لوحة السيارة",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller:
                                                _.plateAlphabetController,
                                            textAlign: TextAlign.left,
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLength: 3,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                              ), // Controls vertical padding
                                              hintText: "ex: ABC",
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            controller: _.plateNumController,
                                            textAlign: TextAlign.left,
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.done,
                                            maxLength: 4,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                              ), // C
                                              hintText: "ex:1234",
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      "رقم هيكل السيارة",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _.carChassisController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      maxLength: 17,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                        ), // C
                                        hintText:
                                            "الرجاء ادخال رقم هيكل السيارة",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      "عدد الأميال",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _.carMileageController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                        ), // C
                                        hintText: "الرجاء ادخال عدد الأميال",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 35,
                                    ),
                                    Center(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(13),
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0x33FEC163),
                                              Color(0xBFDE4313),
                                            ],
                                          ),
                                        ),
                                        height: 40,
                                        width: 250,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                              0,
                                              253,
                                              229,
                                              216,
                                            ),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                            ),
                                          ),
                                          onPressed: () =>
                                              _.updateVehicle(selectedVehicle),
                                          child: const Text(
                                            "تعديل المركبة",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

///to get Company list
// ///
// final CollectionReference<Map<String, dynamic>> companiesCollection =
// FirebaseFirestore.instance.collection('companies');
//
// void addCompanyToFirestore(Company company) {
//   companiesCollection.add(company.toJson());
// }
//
// Future<List<Company>> getCompaniesFromFirestore() async {
//   final snapshot = await companiesCollection.get();
//   return snapshot.docs.map((doc) => Company.fromJson(doc.data())).toList();
// }

////
// List<Company> companies = [];
//   List<CarModel> carModels = [];
//   List<String> features = [];
//   String selectedCompany = '';
//   String selectedCarModel = '';
//   String selectedFeature = '';

///to get the compnies you can get it when app start or any thing like you want
// @override
// void initState() {
//   super.initState();
//   fetchCompanies();
// }
///here Companies the first part of the vehcile call it in onchange
// Future<void> fetchCompanies() async {
//   final List<Company> fetchedCompanies = await getCompaniesFromFirestore();
//   setState(() {
//     companies = fetchedCompanies;
//     companies.forEach((element) {
//       companiessssssss.add(element.name);
//       print(element.name);
//     });
//   });
// }
///here CarModels the second part of the vehcile call it in onchange
// Future<void> fetchCarModels() async {
//   final selectedCompanyObj = companies.firstWhere((company) => company.name == selectedCompany);
//   setState(() {
//     carModels = selectedCompanyObj.carModels;
//     selectedCarModel = '';
//     selectedFeature = '';
//   });
// }
///here fetch the therd part of the vehcile call it in onchange
// Future<void> fetchFeatures() async {
//   final selectedCompanyObj = companies.firstWhere((company) => company.name == selectedCompany);
//   final selectedCarModelObj =
//   selectedCompanyObj.carModels.firstWhere((carModel) => carModel.name == selectedCarModel);
//   setState(() {
//     features = selectedCarModelObj.features;
//     selectedFeature = '';
//   });
// }
///this methoud to upload data update it  in the documentRef just change the uid that you will get it from the user model when you call it
// void uploadData() {
//   print('Selected Company: $selectedCompany');
//   print('Selected Car Model: $selectedCarModel');
//   print('Selected Feature: $selectedFeature');
//DocumentReference documentRef = FirebaseFirestore.instance.collection('Users').doc('JNlu4vWmoKS363gfqkBWd6opLPk2');
//
// // Add an item to a list field
//           documentRef.update({
//             'vehicle': FieldValue.arrayUnion([
//               {  'companyName': "$selectedCompany",
//           'carModel': "$selectedCarModel",
//           'uid': "uidwww",
//           'loogo': "loogso",
//           'latterPlate': "$selectedFeature",
//           'numPlate': 22,}
//             ]),
//           })
//               .then((value) {
//             print('Item added to list field successfully!');
//           })
//               .catchError((error) {
//             print('Failed to add item to list field: $error');
//           });
//
//         },

// }
///how to chose the value in drop down look to the  onchanged and gett the data like you want  and put it into the items
//  DropdownButtonFormField<String>(
//               value: selectedCompany,
//               onChanged: ( newValue) {
//                 setState(() {
//                   selectedCompany = newValue??'';
//                   // Perform additional operations as needed
//                 });
//               },
//               items: companies.map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               hint: Text('Select Company'),
//             ),
//             SizedBox(height: 16),
//             // DropdownButtonFormField<String>(
//             //   value: selectedCarModel,
//             //   onChanged: (value) {
//             //     setState(() {
//             //       selectedCarModel = value ?? '';
//             //       selectedFeature = '';
//             //       fetchFeatures();
//             //     });
//             //   },
//             //   items: carModels.map((model) {
//             //     return DropdownMenuItem<String>(
//             //       value: model.name,
//             //       child: Text(model.name),
//             //     );
//             //   }).toList(),
//             //   hint: Text('Select Car Model'),
//             // ),
//             // SizedBox(height: 16),
//             // DropdownButtonFormField<String>(
//             //   value: selectedFeature,
//             //   onChanged: (value) {
//             //     setState(() {
//             //       selectedFeature = value ?? '';
//             //     });
//             //   },
//             //   items: features.map((feature) {
//             //     return DropdownMenuItem<String>(
//             //       value: feature,
//             //       child: Text(feature),
//             //     );
//             //   }).toList(),
//             //   hint: Text('Select Feature'),
//             // ),
/// to add car model
//  final company = Company(
//             name: 'Company C',
//             carModels: [
//               CarModel(
//                 name: 'Model W',
//                 features: ['Feature 9', 'Feature 10', 'Feature 11'],
//               ),
//             ],
//           );
//           addCompanyToFirestore(company);
//           fetchCompanies();
///to add vehicle to the list
// onPressed: () {
// // Assuming you have a reference to the document you want to update
//           DocumentReference documentRef = FirebaseFirestore.instance.collection('Users').doc('JNlu4vWmoKS363gfqkBWd6opLPk2');
//
// // Add an item to a list field
//           documentRef.update({
//             'vehicle': FieldValue.arrayUnion([
//               {  'companyName': "companyNdame",
//           'carModel': "carModelss",
//           'uid': "uidwww",
//           'loogo': "loogso",
//           'latterPlate': "latterPlate",
//           'numPlate': 22,}
//             ]),
//           })
//               .then((value) {
//             print('Item added to list field successfully!');
//           })
//               .catchError((error) {
//             print('Failed to add item to list field: $error');
//           });
//
//         },