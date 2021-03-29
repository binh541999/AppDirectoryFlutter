import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/providers/GroupMemberModel.dart';
import 'package:redux_example/src/providers/GroupModel.dart';
import 'package:redux_example/src/providers/MemberModel.dart';
import 'package:redux_example/src/providers/StatusModel.dart';
import 'package:redux_example/src/scenes/LogIn.dart';
import 'package:redux_example/src/services/api/groupApi/groupAPI.dart';
import 'package:redux_example/src/services/api/groupMemberApi/groupMemberApi.dart';
import 'package:redux_example/src/services/api/memberApi/fetchData.dart';
import 'package:redux_example/src/services/sqlLite/dboDB.dart';
import 'package:redux_example/src/services/sqlLite/dboGroup.dart';
import 'package:redux_example/src/services/sqlLite/dboGroupMember.dart';
import 'package:redux_example/src/services/sqlLite/dboMember.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CustomDrawer extends StatelessWidget {

  Future<void> deleteDB(BuildContext context) async {

    // deleteDataMember();
    // deleteDataGroup();
    // deleteDataGroupMember();
    deleteAllData();

    Provider.of<MemberModel>(context, listen: false).removeAll();
    Provider.of<StatusModel>(context, listen: false).removeAll();
    Provider.of<GroupModel>(context, listen: false).removeAll();
    Provider.of<GroupMemberModel>(context, listen: false).removeAll();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LogIn()));
    //Navigator.pushNamed(context, '/');

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
                            errorWidget: (context, url, error) =>
                                Image.asset(
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
            padding: const EdgeInsets.only(right: 8.0, left: 20),
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
                      Consumer<StatusModel>(
                          builder: (context, statusData, child) {
                            if (statusData.isLoading) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 50),
                                child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator()),
                              );
                            } else {
                              return SizedBox(
                                height: 20,
                                width: 40,
                              );
                            }
                          }),
                    ],
                  ),

                  onPressed: () {
                    // deleteDataMember();
                    // fetchGetContact(context);

                  },
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
