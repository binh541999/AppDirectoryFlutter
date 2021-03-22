import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:redux_example/src/models/GroupMember.dart';
import 'package:redux_example/src/services/sqlLite/dboGroupMember.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupMemberModel extends ChangeNotifier {
  int _idGroup = -1;
  List<GroupMember> _groupMems = [];
  List<GroupMember> _currentGroupMembers = [];

  UnmodifiableListView<GroupMember> get groupMems => UnmodifiableListView(_groupMems);
  UnmodifiableListView<GroupMember> get currentGroupMembers => _idGroup == -1
      ? null
      : UnmodifiableListView(
          _groupMems.where((member) => member.idGroup == _idGroup).toList());

  Future<void> loadData() async {
    _groupMems = await selectAllGroupMember();

    //if (_groupMems.length != 0) _idGroup = _groupMems[0].idGroup;
    // print('_members $_members');
    notifyListeners();
  }

  void changeIDGroup(int idGroup) {
    _idGroup = idGroup;
    notifyListeners();
  }

  void addGroupMember(GroupMember groupMember) {
    _groupMems.add(groupMember);
    insertItemGroupMember(groupMember);
    notifyListeners();
  }

  void deleteGroupMember(GroupMember groupMember) {
    _groupMems.removeWhere((member) =>
        member.idMember == groupMember.idMember &&
        member.idGroup == groupMember.idGroup);
    deleteItemGroupMember(groupMember);
    notifyListeners();
  }

  void removeAll() {
    _groupMems.clear();
    _currentGroupMembers.clear();
    _idGroup = -1;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
