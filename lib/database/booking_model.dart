
class Booking {
  final int id;
  final String bName;
  final String bEmail;
  final String bPhone;
  final String bServTp;
  final String bDate;
  final String bComment;
  final int bCar;

  Booking({this.id, this.bName, this.bEmail, this.bPhone, this.bServTp,
      this.bDate, this.bComment, this.bCar});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bName': bName,
      'bEmail': bEmail,
      'bPhone': bPhone,
      'bServTp': bServTp,
      'bDate': bDate,
      'bComment': bComment,
      // 'bCar': bCar,
    };
  }

  @override
  String toString() {
    return 'Booking("id": ${this.id}, "bName": ${this.bName}, '
        '"bEmail": ${this.bEmail}, "bPhone": ${this.bPhone}, '
        '"bServTp": ${this.bServTp}, "bDateTime": ${this.bDate}, '
        '"bComment": ${this.bComment}, "bCar": ${this.bCar});';
  }
}
