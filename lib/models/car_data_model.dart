class CarDataModel {
  String? company;
  String? model;

  CarDataModel({this.company, this.model});

  CarDataModel.fromJson(Map<String, dynamic> json) {
    company = json['company'];
    model = json['model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company'] = company;
    data['model'] = model;
    return data;
  }

  @override
  String toString() {
    return 'CarDataModel{company: $company, model: $model}';
  }
}
