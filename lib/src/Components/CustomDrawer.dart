import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:redux_example/src/services/models/Member.dart';
import 'package:redux_example/src/services/models/i_post.dart';
import 'package:redux_example/src/services/redux/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_example/src/services/sqlLite/dboMember.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';


  getCurrentUser() async {
    List<Member> members = await selectAll();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userCode = prefs.getString('userCode');
    List<Member> userInfo = members.where((i) => i.employeeCode == userCode).toList();
    return userInfo[0];
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
              FutureBuilder(
                  future: getCurrentUser(),
                  builder: (context, userInfo) {

                    return (Container(
                      width: 100,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: CachedNetworkImage(
                            height: 100,
                            alignment: Alignment.topCenter,
                            fit: BoxFit.fitWidth,
                            imageUrl: userInfo.data.employeePicUrl,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Image.asset(
                                'lib/src/assets/Image/avatarDefault.png'),
                          )),
                    ));
                  }),
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
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
