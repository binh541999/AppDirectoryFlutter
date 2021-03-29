
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

  void loadDataJson(List<dynamic> json) {
    try {
      if (json != null) {
        for (final value in json) {
          //print('value $json');
          var group = new Groups(
            id: value['group_id'],
            name: value['group_name'],
          );
          _groups.insert(0,group);
        }
      }
    } catch (error) {
      print('fetch data group Failed $error');
    }
  }

  Future<void> loadData() async {
    _groups =  ((await selectAllGroup()).reversed).toList();
    if(_groups.length != 0)
      _currentGroup = _groups[0];
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
    _groups.insert(0,group);
    insertItemGroup(group);
    notifyListeners();
  }

  void removeAll() {
    _groups.clear();
    _currentGroup = new Groups();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}