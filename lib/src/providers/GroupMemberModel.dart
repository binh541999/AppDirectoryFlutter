import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:redux_example/src/models/GroupMember.dart';
import 'package:redux_example/src/services/sqlLite/dboGroupMember.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupMemberModel extends ChangeNotifier {
  int _idGroup = -1;
  List<GroupMember> _groupMems = [];
  List<GroupMember> _currentGroupMembers = [];

  int get idGroup => _idGroup;
  UnmodifiableListView<GroupMember> get groupMems => UnmodifiableListView(_groupMems);
  UnmodifiableListView<GroupMember> get currentGroupMembers => _idGroup == -1
      ? null
      : UnmodifiableListView(
          _groupMems.where((member) => member.idGroup == _idGroup).toList());

  Future<void> loadData() async {
    _groupMems = await selectAllGroupMember();
    notifyListeners();
  }

  void changeIDGroup(int idGroup) {
    _idGroup = idGroup;
    notifyListeners();
  }

  void addGroupMember(GroupMember groupMember) {
    print(groupMember.idGroup);
    print(groupMember.idMember);
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

  void deleteGroupMemberWithGroupId(int groupID)  {
    if(_groupMems.length ==0) return ;
    _groupMems.removeWhere((member) =>
        member.idGroup == groupID);
    deleteItemGroupMemberWithGroupID(groupID);
    notifyListeners();
  }

  void removeAll() {
    _groupMems.clear();
    _currentGroupMembers.clear();
    _idGroup = -1;
    print('clear group member');
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
