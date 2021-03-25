import 'package:redux_example/src/services/sqlLite/dboGroup.dart';
import 'package:redux_example/src/services/sqlLite/dboGroupMember.dart';
import 'package:redux_example/src/services/sqlLite/dboMember.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String DB_NAME = "directory_database.db";
Database _database;

Future<Database> get database async {
  if (_database != null) return _database;
  _database = await _initDatabase();
  return _database;
}

_initDatabase() async {
  return await openDatabase(
    join(await getDatabasesPath(), DB_NAME),
    onCreate: (db, version) => _createDb(db),
    version: 1,
  );
}

void _createDb(Database db) {
  populateDbMember(db);
  populateDbGroup(db);
  populateDbGroupMember(db);
}

void _deleteDb() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, DB_NAME);
  await deleteDatabase(path);
}