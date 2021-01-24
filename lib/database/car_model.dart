
class Car {
  final int id;
  final String vType;
  final String vMake;
  final String vModel;
  final String vYear;
  final String vFuelTp;
  final String vLPlate;

  Car({this.id, this.vType, this.vMake, this.vModel,
      this.vYear, this.vFuelTp, this.vLPlate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vType': vType,
      'vMake': vMake,
      'vModel': vModel,
      'vYear': vYear,
      'vFuelTp': vFuelTp,
      'vLPlate': vLPlate,
    };
  }

  @override
  String toString() {
    return 'Car("id": ${this.id}, "vType": ${this.vType}, "vMake": ${this.vMake}, '
    '"vModel": ${this.vModel}, "vYear": ${this.vYear}, "vFuelTp": ${this.vFuelTp}, '
    '"vLPlate": ${this.vLPlate});';
  }

}
