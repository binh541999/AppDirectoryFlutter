import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:redux_example/src/models/Member.dart';
import 'package:redux_example/src/services/sqlLite/dboMember.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberModel extends ChangeNotifier {
  String _searchString = "";
  List<Member> _members= [];
  List<Member> _userInfo = [];

  UnmodifiableListView<Member> get members => _searchString.isEmpty
      ? UnmodifiableListView(_members)
      : UnmodifiableListView(
      _members.where((member) => member.shortName.toLowerCase().contains(_searchString)).toList());

  UnmodifiableListView<Member> get userInfo => UnmodifiableListView(_userInfo);

  void changeSearchString(String searchString) {
    _searchString = searchString;
    //print(_searchString);
    notifyListeners();
  }

  Future<void> loadData() async {
    _members =  await selectAll();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userCode = prefs.getString('userCode');
    print('_members $_members');
    _userInfo = _members.where((i) => i.employeeCode == userCode).toList();
    print('_userinfo $_userInfo');
   // print('_members $_members');
    notifyListeners();
  }


  void addMember(Member member) {
    _members.add(member);
    notifyListeners();
  }

  void removeAll() {
    _members.clear();
    _userInfo.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}