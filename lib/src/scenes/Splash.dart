import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiny_kms_directory/src/navigations/index.dart';
import 'package:tiny_kms_directory/src/providers/GroupMemberModel.dart';
import 'package:tiny_kms_directory/src/providers/GroupModel.dart';
import 'package:tiny_kms_directory/src/providers/MemberModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  startTimeForLogin() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationLogin);
  }

  Future<void> navigation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool statusFirstOpen = prefs.getBool('isFirstOpen') ?? true;
    if (statusFirstOpen) {
      startTimeForLogin();
    } else {
      await navigationHomePage(context);
    }
  }

  void initState() {
    super.initState();
    navigation();
  }

  void navigationLogin() {
    Navigator.of(context).pushReplacementNamed('/');
  }

  Future<void> navigationHomePage(BuildContext context) async {
    await Provider.of<MemberModel>(context, listen: false).loadData();
    await Provider.of<GroupModel>(context, listen: false).loadData();
    await Provider.of<GroupMemberModel>(context, listen: false).loadData();
    Provider.of<GroupMemberModel>(context, listen: false).changeIDGroup(
        Provider.of<GroupModel>(context, listen: false).currentGroup.id);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => RootNavigation()),
      ModalRoute.withName('/homePage'),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
