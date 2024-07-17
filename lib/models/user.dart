import 'add_car_model.dart';

class UserData {
  String? email;
  String? name;
  String? address;
  String? phone;
  String? uid;
  List<VehicleModel>? vehicle;

  UserData({
    required this.uid,
    required this.email,
    required this.address,
    required this.name,
    required this.phone,
    required this.vehicle,
  });

  // function that convert "Map<String, Object>" to a User
  UserData.fromJson(Map<String, dynamic> mapData, uId) {
    String uName = mapData["Name"];
    List<VehicleModel>? myVehicles = mapData["vehicle"] != null
        ? mapData["vehicle"]
            .map<VehicleModel>((car) => VehicleModel.fromJson(car))
            .toList()
        : [];

    email = mapData["Email"];
    phone = mapData["PhoneNo"];
    address = mapData["Address"];
    name = uName;
    uid = uId;
    vehicle = myVehicles;
  }

// To convert the UserData(Data type) to   Map<String, Object>
  Map<String, dynamic> toJson() {
    return {
      "Email": email,
      "PhoneNo": phone,
      "Address": address,
      "Name": name, // Consider updating "Name" to "name" for consistency
      "uId": uid,
      "vehicle": vehicle?.map((car) => car.toJson()).toList(),
    };
  }

  // function that convert "DocumentSnapshot" to a User
// function that takes "DocumentSnapshot" and return a User
}
