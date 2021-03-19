import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/providers/MemberModel.dart';
import 'package:redux_example/src/providers/StatusModel.dart';
import 'package:redux_example/src/scenes/LogIn.dart';
import 'package:redux_example/src/services/sqlLite/dboGroup.dart';
import 'package:redux_example/src/services/sqlLite/dboMember.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CustomDrawer extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';
  Future<void> deleteDB(BuildContext context) async {
    deleteDataMember();
    deleteDataGroup() ;
    //     var databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'directory_database.db');
//
// // Delete the database
//     await deleteDatabase(path);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LogIn())).then((value){

      Provider.of<StatusModel>(context, listen: false).removeAll();
      Provider.of<MemberModel>(context, listen: false).removeAll();
    });
      //Navigator.pushNamed(context, '/');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();



  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(children: [
              Consumer<MemberModel>(builder: (context, membersData, child) {

                return (Container(
                  width: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: CachedNetworkImage(
                        height: 100,
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fitWidth,
                        imageUrl: membersData.userInfo[0].employeePicUrl ?? null,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.asset(
                            'lib/src/assets/Image/avatarDefault.png'),
                      )),
                ));
              }

              ),
              // FutureBuilder(
              //     future: getCurrentUser(),
              //     builder: (context, userInfo) {
              //
              //       return (Container(
              //         width: 100,
              //         child: ClipRRect(
              //             borderRadius: BorderRadius.circular(90),
              //             child: CachedNetworkImage(
              //               height: 100,
              //               alignment: Alignment.topCenter,
              //               fit: BoxFit.fitWidth,
              //               imageUrl: userInfo.data.employeePicUrl,
              //               placeholder: (context, url) =>
              //                   CircularProgressIndicator(),
              //               errorWidget: (context, url, error) => Image.asset(
              //                   'lib/src/assets/Image/avatarDefault.png'),
              //             )),
              //       ));
              //     }),

            ]),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          RawMaterialButton(
            child: Text("Log Out"),
            onPressed:() {
              deleteDB(context);

              },
            //testPress,
          ),
        ],
      ),
    );
  }
}
