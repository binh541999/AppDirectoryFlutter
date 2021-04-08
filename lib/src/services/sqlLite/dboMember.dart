import 'package:tiny_kms_directory/src/models/Member.dart';
import 'package:tiny_kms_directory/src/services/sqlLite/dboDB.dart';
import 'package:sqflite/sqflite.dart';

const String TABLE_NAME = "Members";

void populateDbMember(Database db) async {
  await db.execute(
    """CREATE TABLE $TABLE_NAME(    id INTEGER PRIMARY KEY AUTOINCREMENT, 
                                        employeeId INTEGER,
                                        skype VARCHAR(255),
                                        email VARCHAR(255),
                                        userName VARCHAR(255),
                                        employeeCode VARCHAR(255),
                                        currentOffice VARCHAR(255),
                                        currentOfficeFullName VARCHAR(255),
                                        empVietnameseName VARCHAR(255),
                                        titleName VARCHAR(255),
                                        mobilePhone VARCHAR(255),
                                        employeePicUrl VARCHAR(255),
                                        fullName VARCHAR(255),
                                        shortName VARCHAR(255) 
            )""",
  );
}

Future<List<Member>> selectAllMember() async {
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('Members');
  //List<Movie> movies = maps.map((e) => Movie.formJson(e)).toList();
  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Member(
      employeeId: maps[i]['employeeId'],
      employeeCode: maps[i]['employeeCode'],
      shortName: maps[i]["shortName"],
      email: maps[i]["email"],
      skype: maps[i]["skype"],
      mobilePhone: maps[i]["mobilePhone"],
      userName: maps[i]["userName"],
      currentOfficeFullName: maps[i]["currentOfficeFullName"],
      currentOffice: maps[i]["currentOffice"],
      empVietnameseName: maps[i]["empVietnameseName"],
      titleName: maps[i]["titleName"],
      employeePicUrl: maps[i]["employeePicUrl"],
      fullName: maps[i]["fullName"],
    );
  });
}

Future<void> insertItemMember(Member member) async {
  // Get a reference to the database.
  final db = await database;

  await db.transaction((txn) async {
    var batch = txn.batch();
    batch.insert(
      'Members',
      member.toMap(),
    );
    await batch.commit();
  });
}

Future<void> deleteDataMember() async {
  // Get a reference to the database.
  final db = await database;

  await db.transaction((txn) async {
    var batch = txn.batch();
    batch.delete('Members');
    await batch.commit();
  });
}
