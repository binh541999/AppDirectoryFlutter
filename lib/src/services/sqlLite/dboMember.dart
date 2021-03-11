import 'package:redux_example/src/services/models/Member.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String DB_NAME = "directory_database.db";
Database _database;

Future<Database> get database async {
  if (_database != null) return _database;
  _database = await _initDatabase();
  return _database;
}

const String TABLE_NAME = "Members";

_initDatabase() async {
  return await openDatabase(
    join(await getDatabasesPath(), DB_NAME),
    onCreate: (db, version) {
      return db.execute(
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
    },
    version: 1,
  );
}

Future<List<Member>> selectAll() async {
  // Get a reference to the database.
  var db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('Members');
  //List<Movie> movies = maps.map((e) => Movie.formJson(e)).toList();
  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return
      Member(
      employeeId: maps[i]['employeeId'],
        employeeCode: maps[i]['employeeCode'],
      shortName: maps[i]["shortName"],
      email: maps[i]["email"],
      skype: maps[i]["skype"],
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

Future<void> insertItem(Member member) async {
  // Get a reference to the database.
  var db = await database;
  print('insertItem');
  // Insert the Dog into the correct table. Also specify the
  // `conflictAlgorithm`. In this case, if the same dog is inserted
  // multiple times, it replaces the previous data.
  await db.insert(
    'Members',
    member.toMap(),
  );
}
