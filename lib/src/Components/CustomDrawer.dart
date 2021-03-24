import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/providers/GroupMemberModel.dart';
import 'package:redux_example/src/providers/GroupModel.dart';
import 'package:redux_example/src/providers/MemberModel.dart';
import 'package:redux_example/src/providers/StatusModel.dart';
import 'package:redux_example/src/scenes/LogIn.dart';
import 'package:redux_example/src/services/sqlLite/dboGroup.dart';
import 'package:redux_example/src/services/sqlLite/dboGroupMember.dart';
import 'package:redux_example/src/services/sqlLite/dboMember.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CustomDrawer extends StatelessWidget {

  Future<void> deleteDB(BuildContext context) async {
    deleteDataMember();
    deleteDataGroup();
    deleteDataGroupMember();
    //     var databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'directory_database.db');
//
// // Delete the database
//     await deleteDatabase(path);
    Provider.of<StatusModel>(context, listen: false).removeAll();
    Provider.of<GroupModel>(context, listen: false).removeAll();
    Provider.of<GroupMemberModel>(context, listen: false).removeAll();
    Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => LogIn()))
        .then((value) {


      Provider.of<MemberModel>(context, listen: false).removeAll();

    });
    //Navigator.pushNamed(context, '/');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(children: [
              Consumer<MemberModel>(builder: (context, membersData, child) {
                return Column(
                  children: [
                    Container(
                      width: 80,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: CachedNetworkImage(
                            height: 80,
                            alignment: Alignment.topCenter,
                            fit: BoxFit.fitWidth,
                            imageUrl:
                                membersData.userInfo[0].employeePicUrl ?? null,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Image.asset(
                                'lib/src/assets/Image/avatarDefault.png'),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        membersData.userInfo[0].shortName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'kms/${membersData.userInfo[0].userName}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }),

            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(right:8.0,left: 20),
            child: Column(
              children: [
                RawMaterialButton(
                  child: Row(

                    children: [
                      Icon(Icons.refresh),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Update Contact"),
                    ],
                  ),

                  onPressed: () {},
                  //testPress,
                ),
                RawMaterialButton(
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Log Out"),
                    ],
                  ),

                  onPressed: () {
                    deleteDB(context);
                  },
                  //testPress,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
