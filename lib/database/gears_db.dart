
import 'package:ger_garage/database/booking_model.dart';
import 'package:ger_garage/database/car_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sql.dart';

// final dataB = openDB();

Future<Database> openDB() async {
  return openDatabase(
    join(await getDatabasesPath(), 'gears_db.db'),
    version: 1,
    onCreate: _createDB,
  );
}

void _createDB(Database db, int version) async {
  await db.execute(
      "CREATE TABLE IF NOT EXISTS cars (id INTEGER PRIMARY KEY, vType TEXT, "
          "vMake TEXT, vModel TEXT, vYear TEXT, vFuelTp TEXT, vLPlate TEXT)");
  await db.execute(
      '''CREATE TABLE IF NOT EXISTS bookings (id INTEGER PRIMARY KEY, bName TEXT, 
             bEmail TEXT, bPhone TEXT, bServTp TEXT, bDate TEXT, bComment TEXT)''');
}

/* ----  Operation for cars table  ---- */
Future<void> insertCar(Car car) async {
  // Get reference of the database
  final Database db = await openDB();

  // Insert in the table a new object
  await db.insert('cars', car.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Car>> allCars() async {
  final Database db = await openDB();

  // Query the table for all The cars.
  final List<Map<String, dynamic>> cMaps = await db.query('cars');

  for (var n in cMaps) {
    print(n['id'].toString() + "--" + n['vModel']);
  }

  // Convert the List<Map<String, dynamic> into a List<Product>.
  return List.generate(cMaps.length, (i) => Car(
    id: cMaps[i]['id'],
    vType: cMaps[i]['vType'],
    vMake: cMaps[i]['vMake'],
    vModel: cMaps[i]['vModel'],
    vYear: cMaps[i]['vYear'],
    vFuelTp: cMaps[i]['vFuelTp'],
    vLPlate: cMaps[i]['vLPlate'],
  ),);
}

Future<void> updateCar(Car car) async {
  final Database db = await openDB();

  // Update the given object.
  await db.update('cars', car.toMap(), where: "id = ?", whereArgs: [car.id]);
}

Future<void> deleteCar(int id) async {
  final Database db = await openDB();

  // Remove the object from the database.
  await db.delete('cars', where: "id= ?", whereArgs: [id]);
}


class DBOperation {


/* ----  Operation for bookings table  ---- */
  Future<void> insertBkn(Booking booking) async {
    // Get reference of the database
    final Database db = await openDB();

    // Insert in the table a new object
    await db.insert('bookings', booking.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Booking>> allBkns() async {
    final Database db = await openDB();

    // Query the table for all The cars.
    final List<Map<String, dynamic>> bMaps = await db.query('bookings');

    // Convert the List<Map<String, dynamic> into a List<Product>.
    return List.generate(bMaps.length, (i) => Booking(
      id: bMaps[i]['id'],
      bName: bMaps[i]['bName'],
      bEmail: bMaps[i]['bEmail'],
      bPhone: bMaps[i]['bPhone'],
      bServTp: bMaps[i]['bServTp'],
      bDate: bMaps[i]['bDate'],
      bComment: bMaps[i]['bComment'],
      bCar: bMaps[i]['bCar'],
    ));
  }

  Future<void> updateBkn(Booking booking) async {
    final Database db = await openDB();

    // Update the given object.
    await db.update('bookings', booking.toMap(), where: "id = ?", whereArgs: [booking.id]);
  }

  Future<void> deleteBkn(int id) async {
    final Database db = await openDB();

    // Remove the object from the database.
    await db.delete('bookings', where: "id= ?", whereArgs: [id]);
  }


}
