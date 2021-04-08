import 'package:tiny_kms_directory/src/models/GroupMember.dart';
import 'package:tiny_kms_directory/src/services/sqlLite/dboDB.dart';
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

  final db = await database;

  final List<Map<String, dynamic>> maps = await db.query('GroupMember');

  return List.generate(maps.length, (i) {
    return GroupMember(
      idGroup: maps[i]['idGroup'],
      userName: maps[i]['userName'],
    );
  });
}

Future<void> insertItemGroupMember(GroupMember groupMember) async {

  final db = await database;

  await db.transaction((txn) async {
    var batch = txn.batch();
    batch.rawInsert('INSERT INTO $TABLE_NAME(idGroup,userName) VALUES(?,?)',
        [groupMember.idGroup, groupMember.userName]);

    await batch.commit();
  });
}

Future<void> deleteItemGroupMember(GroupMember groupMember) async {
  final db = await database;

  await db.transaction((txn) async {
    var batch = txn.batch();
    batch.delete(TABLE_NAME,
        where: 'idGroup = ? AND userName = ?',
        whereArgs: [groupMember.idGroup, groupMember.userName]);
    await batch.commit();
  });

}

Future<void> deleteItemGroupMemberWithGroupID(int groupID) async {

  final db = await database;

      await db.delete(TABLE_NAME, where: 'idGroup = ? ', whereArgs: [groupID]);
}

Future<void> deleteDataGroupMember() async {
  final db = await database;

  await db.delete(TABLE_NAME);
}
