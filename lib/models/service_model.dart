class ServiceModel {
  String? name;
  String? carId;
  String? carCompany;
  String? carModel;
  String? imageUrl;
  String? duration;
  String? mileage;
  String? nextCheckup;
  bool? isPassed;
  String? mileagePassed;

  ServiceModel({
    this.name,
    this.carId,
    this.carCompany,
    this.carModel,
    this.imageUrl,
    this.duration,
    this.mileage,
    this.nextCheckup,
    this.isPassed,
    this.mileagePassed,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    carId = json['id'];
    carCompany = json['carCompany'];
    carModel = json['carModel'];

    imageUrl = json['imageUrl'];
    duration = json['duration'];
    mileage = json['mileage'];
    nextCheckup = json['nextCheckup'];
    isPassed = json['isPassed'];
    mileagePassed = json['mileagePassed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = carId;
    data['carCompany'] = carCompany;
    data['carModel'] = carModel;

    data['imageUrl'] = imageUrl;
    data['duration'] = duration;
    data['mileage'] = mileage;
    data['nextCheckup'] = nextCheckup;
    data['isPassed'] = isPassed;
    data['mileagePassed'] = mileagePassed;
    return data;
  }

  @override
  String toString() {
    return 'ServiceModel{name: $name, carId: $carId, carCompany: $carCompany, carModel: $carModel, imageUrl: $imageUrl, duration: $duration, mileage: $mileage, nextCheckup: $nextCheckup, isPassed: $isPassed, mileagePassed: $mileagePassed}';
  }
}
