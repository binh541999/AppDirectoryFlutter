
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:redux_example/src/models/Groups.dart';
import 'package:redux_example/src/services/sqlLite/dboGroup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupModel extends ChangeNotifier {
  List<Groups> _groups= [];
  Groups _currentGroup = new Groups();

  UnmodifiableListView<Groups> get groups => UnmodifiableListView(_groups);
  Groups get currentGroup => _currentGroup;

  Future<void> loadData() async {
    _groups =  await selectAllGroup();
    if(_groups.length != 0)
      _currentGroup = _groups[0];
    // print('_members $_members');
    notifyListeners();
  }

  set currentGroup(Groups newValue) {
    if (newValue == _currentGroup) return;
    _currentGroup = newValue;
    notifyListeners();
  }


  void deleteGroup(int groupID) {
    if(_groups.length != 0) {
    //  _groups.removeWhere((group) => group.id == groupID);
      _groups.removeWhere((group) {
        return group.id == groupID;
      });
      deleteItemGroup(groupID);
      notifyListeners();
    }
  }

  void updateGroup(Groups group) {
    if(_groups.length != 0) {
      //  _groups.removeWhere((group) => group.id == groupID);
      var index  = _groups.indexWhere((element) => element.id == group.id);
      _groups[index].name = group.name;
      updateItemGroup(group);
      notifyListeners();
    }
  }

  void addGroup(Groups group) {
    _groups.add(group);
    insertItemGroup(group.name);
    notifyListeners();
  }

  void removeAll() {
    _groups.clear();
    _currentGroup = new Groups();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}