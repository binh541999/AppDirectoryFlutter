import 'package:redux_example/src/models/GroupMember.dart';
import 'package:redux_example/src/services/sqlLite/dboDB.dart';
import 'package:sqflite/sqflite.dart';


const String TABLE_NAME = "GroupMember";


void populateDbGroupMember(Database db) async {
  await db.execute(
    """CREATE TABLE $TABLE_NAME(   id INTEGER PRIMARY KEY AUTOINCREMENT,
                                        idGroup INTEGER , 
                                         idMember INTEGER 
            )""",
  );
}

Future<List<GroupMember>> selectAllGroupMember() async {
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('GroupMember');
  //List<Movie> movies = maps.map((e) => Movie.formJson(e)).toList();
  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return
      GroupMember(
        idGroup: maps[i]['idGroup'],
        idMember: maps[i]['idMember'],

      );
  });
}

Future<void> insertItemGroupMember(GroupMember groupMember) async {
  // Get a reference to the database.
  final db = await database;
  //print('insertItem');
  // Insert the Dog into the correct table. Also specify the
  // `conflictAlgorithm`. In this case, if the same dog is inserted
  // multiple times, it replaces the previous data.
  await db.insert(
    'GroupMember',
    groupMember.toMap(),
  );
}


Future<void> deleteDataGroupMember() async {
  // Get a reference to the database.
  final db = await database;
  //print('insertItem');
  // Insert the Dog into the correct table. Also specify the
  // `conflictAlgorithm`. In this case, if the same dog is inserted
  // multiple times, it replaces the previous data.
  await db.delete(
      'GroupMember'
  );
}
