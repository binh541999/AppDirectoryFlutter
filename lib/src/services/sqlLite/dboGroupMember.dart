import 'package:redux_example/src/models/GroupMember.dart';
import 'package:redux_example/src/services/sqlLite/dboDB.dart';
import 'package:sqflite/sqflite.dart';


const String TABLE_NAME = "GroupMember";


void populateDbGroupMember(Database db) async {
  await db.execute(
    """CREATE TABLE $TABLE_NAME(   id INTEGER PRIMARY KEY AUTOINCREMENT,
                                        idGroup INTEGER , 
                                         userName VARCHAR(255)  
            )""",
  );
}

Future<List<GroupMember>> selectAllGroupMember() async {
  // Get a reference to the database.
  final db = await database;

  final List<Map<String, dynamic>> maps = await db.query('GroupMember');

  return List.generate(maps.length, (i) {
    return
      GroupMember(
        idGroup: maps[i]['idGroup'],
        userName: maps[i]['userName'],
      );
  });
}

Future<void> insertItemGroupMember(GroupMember groupMember) async {
  // Get a reference to the database.
  final db = await database;

  await db.transaction((txn) async {
    var batch = txn.batch();
    batch.rawInsert('INSERT INTO $TABLE_NAME(idGroup,userName) VALUES(?,?)', [groupMember.idGroup,groupMember.userName]);

    await batch.commit();
  });

}

Future<void> deleteItemGroupMember(GroupMember groupMember) async {
  // Get a reference to the database.
  final db = await database;

  await db.transaction((txn) async {
    var batch = txn.batch();
    batch.delete(
        TABLE_NAME,
        where: 'idGroup = ? AND userName = ?',
        whereArgs: [groupMember.idGroup,groupMember.userName]

    );
    await batch.commit();
  });

  // int test = await db.delete(
  //   TABLE_NAME,
  //   where: 'idGroup = ? AND userName = ?',
  //   whereArgs: [groupMember.idGroup,groupMember.userName]
  //
  // );
}

Future<void> deleteItemGroupMemberWithGroupID(int  groupID) async {
  // Get a reference to the database.
  final db = await database;
  //print('insertItem');
  // Insert the Dog into the correct table. Also specify the
  // `conflictAlgorithm`. In this case, if the same dog is inserted
  // multiple times, it replaces the previous data.
  int test = await db.delete(
      TABLE_NAME,
      where: 'idGroup = ? ',
      whereArgs: [groupID]

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
    TABLE_NAME
  );
}
