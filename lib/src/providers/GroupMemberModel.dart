
import 'package:flutter/material.dart';
import 'package:redux_example/src/models/GroupMember.dart';
import 'package:redux_example/src/services/sqlLite/dboGroupMember.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupMemberModel extends ChangeNotifier {
  List<GroupMember> _groupMems= [];

  Future<void> loadData() async {
    _groupMems =  await selectAllGroupMember();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print('_members $_members');
    notifyListeners();
  }


  void addGroup(GroupMember groupMember) {
    _groupMems.add(groupMember);
    insertItemGroupMember(groupMember);
    notifyListeners();
  }

  void removeAll() {
    _groupMems.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}