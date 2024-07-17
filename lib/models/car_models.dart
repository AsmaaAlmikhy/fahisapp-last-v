class Company {
  final String name;
  final List<CarModel> carModels;

  Company({required this.name, required this.carModels});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      carModels: List<CarModel>.from(json['carModel'].map((model) => CarModel.fromJson(model))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'carModel': carModels.map((model) => model.toJson()).toList(),
    };
  }
}

class CarModel {
  final String name;
  final List<String> features;

  CarModel({required this.name, required this.features});

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      name: json['name'],
      features: List<String>.from(json['features']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'features': features,
    };
  }
}
