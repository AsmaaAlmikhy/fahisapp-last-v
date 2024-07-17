class CarPlateModel {
  String? plateAlphabet;
  String? plateNum;

  CarPlateModel({this.plateAlphabet, this.plateNum});

  CarPlateModel.fromJson(Map<String, dynamic> json) {
    plateAlphabet = json['plateAlphabet'];
    plateNum = json['plateNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plateAlphabet'] = plateAlphabet;
    data['plateNum'] = plateNum;
    return data;
  }

  @override
  String toString() {
    return 'CarPlateModel{plateAlphabet: $plateAlphabet, plateNum: $plateNum}';
  }
}
