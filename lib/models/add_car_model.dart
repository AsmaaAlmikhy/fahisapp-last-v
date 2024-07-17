import 'car_plate_model.dart';
import 'service_model.dart';

class VehicleModel {
  String? id;
  String? carCompany;
  String? carModel;
  CarPlateModel? carPlate;
  String? carProductionYear;
  String? carChassisNumber;
  String? carMileage;
  String? imageUrl;
  List<ServiceModel>? services = [];
  VehicleModel({
    this.id,
    required this.carCompany,
    required this.carModel,
    required this.carPlate,
    this.carProductionYear,
    this.carChassisNumber,
    required this.carMileage,
    this.imageUrl,
    this.services,
  });

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carCompany = json['carCompany'];
    carModel = json['carModel'];
    carPlate = json['carPlate'] != null
        ? CarPlateModel.fromJson(json['carPlate'])
        : null;
    carProductionYear = json['carProductionYear'];
    carChassisNumber = json['carChassisNumber'];
    carMileage = json['carMileage'];
    imageUrl = json['imageUrl'];
    if (json['services'] != null) {
      services = <ServiceModel>[];
      json['services'].forEach((v) {
        services!.add(ServiceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['carCompany'] = carCompany;
    data['carModel'] = carModel;
    if (carPlate != null) {
      data['carPlate'] = carPlate!.toJson();
    }
    data['carProductionYear'] = carProductionYear;
    data['carChassisNumber'] = carChassisNumber;
    data['carMileage'] = carMileage;
    data['imageUrl'] = imageUrl;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'AddCarModel{id: $id, carCompany: $carCompany, carModel: $carModel, carPlate: ${carPlate.toString()}, carProductionYear: $carProductionYear, carChassisNumber: $carChassisNumber, carMileage: $carMileage}';
  }
}
