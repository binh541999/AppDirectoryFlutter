import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiny_kms_directory/src/providers/GroupMemberModel.dart';
import 'package:tiny_kms_directory/src/providers/GroupModel.dart';
import 'package:tiny_kms_directory/src/providers/MemberModel.dart';
import 'package:tiny_kms_directory/src/providers/StatusModel.dart';
import 'package:tiny_kms_directory/src/scenes/LogIn.dart';
import 'package:tiny_kms_directory/src/services/api/memberApi/fetchData.dart';
import 'package:tiny_kms_directory/src/services/sqlLite/dboDB.dart';

Future<void> showAlert(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var expireDate = DateTime.parse(prefs.getString('tokenExpiredDate'));
  var updateDate = DateTime.parse(prefs.getString('updateDate'));
  var now = DateTime.now();
  if (expireDate.isBefore(now)) {
    alertLogOut(context);
  } else if (now.difference(updateDate).inDays > -1) {
    alertUpdate(context, now.difference(updateDate).inDays.toString());
  }
  print(expireDate);
  print(expireDate.isAfter(now));
  print(now.difference(updateDate).inDays);
  print(updateDate);
}

Future<void> alertLogOut(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Session Expired'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('it\'s has been 90 days since your last log in'),
              Text('Please log in again'),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              child: Text('Log out'),
              onPressed: () async {
                deleteAllData();
                Provider.of<MemberModel>(context, listen: false).removeAll();
                Provider.of<StatusModel>(context, listen: false).removeAll();
                Provider.of<GroupModel>(context, listen: false).removeAll();
                Provider.of<GroupMemberModel>(context, listen: false).removeAll();
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LogIn()));
              },
            ),
          ),
        ],
      );
    },
  );
}

Future<void> alertUpdate(BuildContext context, String date) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Contact'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('It\'s has been $date days since your last update contact '),
              Text('Wanna update your contact ?'),
            ],
          ),
        ),
        actions: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Update'),
                  onPressed: () {
                    deleteAllData();
                    fetchGetContact(context).then((value){
                      if(value){
                        Navigator.of(context).pop();
                      }

                    });
                  },
                ),
              ])
        ],
      );
    },
  );
}
