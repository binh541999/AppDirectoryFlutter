import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:tiny_kms_directory/src/models/GroupMember.dart';
import 'package:tiny_kms_directory/src/services/sqlLite/dboGroupMember.dart';

class GroupMemberModel extends ChangeNotifier {
  int _idGroup = -1;
  List<GroupMember> _groupMems = [];
  List<GroupMember> _currentGroupMembers = [];

  int get idGroup => _idGroup;
  UnmodifiableListView<GroupMember> get groupMems =>
      UnmodifiableListView(_groupMems);
  UnmodifiableListView<GroupMember> get currentGroupMembers => _idGroup == -1
      ? null
      : UnmodifiableListView(
          _groupMems.where((member) => member.idGroup == _idGroup).toList());

  Future<void> loadData() async {
    _groupMems = await selectAllGroupMember();
    notifyListeners();
  }

  void loadDataJson(Map<String, dynamic> json) {
    try {
      if (json != null) {
        for (final member in json['members']) {
          var groupMember = new GroupMember(
              idGroup: json['group_id'], userName: member['username']);
          _groupMems.add(groupMember);
        }
      }
    } catch (error) {
      print('fetch data group member Failed $error');
    }
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
        member.userName == groupMember.userName &&
        member.idGroup == groupMember.idGroup);
    deleteItemGroupMember(groupMember);
    notifyListeners();
  }

  void deleteGroupMemberWithGroupId(int groupID) {
    if (_groupMems.length == 0) return;
    _groupMems.removeWhere((member) => member.idGroup == groupID);
    deleteItemGroupMemberWithGroupID(groupID);
    notifyListeners();
  }

  void removeAll() {
    _groupMems.clear();
    _currentGroupMembers.clear();
    _idGroup = -1;
    notifyListeners();
  }
}
