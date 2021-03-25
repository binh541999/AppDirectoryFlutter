import 'package:redux_example/src/models/Groups.dart';
import 'package:redux_example/src/services/sqlLite/dboDB.dart';
import 'package:sqflite/sqflite.dart';


const String TABLE_NAME = "Groups";


void populateDbGroup(Database db) async {
  await db.execute(
    """CREATE TABLE $TABLE_NAME(    id INTEGER PRIMARY KEY ,                                      
                                     name VARCHAR(255) 
            )""",
  );
}

Future<List<Groups>> selectAllGroup() async {
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('Groups');
  //List<Movie> movies = maps.map((e) => Movie.formJson(e)).toList();
  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return
      Groups(
        id: maps[i]['id'],
        name: maps[i]['name'],

      );
  });
}

Future<void> insertItemGroup(Groups groups) async {
  // Get a reference to the database.
  final db = await database;
  //print('insertItem');
  // Insert the Dog into the correct table. Also specify the
  // `conflictAlgorithm`. In this case, if the same dog is inserted
  // multiple times, it replaces the previous data.
 await db.rawInsert('INSERT INTO $TABLE_NAME(id,name) VALUES(?,?)', [groups.id,groups.name]);
  // await db.insert(
  //   'Groups',
  //   groupName,
  // );

}

Future<void> updateItemGroup(Groups groups) async {
  // Get a reference to the database.
  final db = await database;
  //print('insertItem');
  // Insert the Dog into the correct table. Also specify the
  // `conflictAlgorithm`. In this case, if the same dog is inserted
  // multiple times, it replaces the previous data.
  await db.rawUpdate('UPDATE $TABLE_NAME SET name =  ? WHERE id = ?', [groups.name,groups.id]);
  // await db.update(
  //   'Groups',
  //   groups.toMap(),
  //   where: "id = ?",
  //   whereArgs: [groups.id]
  // );
}

Future<void> deleteItemGroup(int groupID) async {
  // Get a reference to the database.
  final db = await database;
  //print('insertItem');
  // Insert the Dog into the correct table. Also specify the
  // `conflictAlgorithm`. In this case, if the same dog is inserted
  // multiple times, it replaces the previous data.
  await db.delete(
      TABLE_NAME,
      where: 'id = ?',
      whereArgs: [groupID]

  );
}


Future<void> deleteDataGroup() async {
  // Get a reference to the database.
  final db = await database;
  //print('insertItem');
  // Insert the Dog into the correct table. Also specify the
  // `conflictAlgorithm`. In this case, if the same dog is inserted
  // multiple times, it replaces the previous data.
  await db.delete(
      'Groups'
  );
}
