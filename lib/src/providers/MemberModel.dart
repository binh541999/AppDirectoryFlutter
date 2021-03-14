import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:redux_example/src/models/Member.dart';
import 'package:redux_example/src/services/sqlLite/dboMember.dart';

class MemberModel extends ChangeNotifier {
  String _searchString = "";
  List<Member> _members= [];

  UnmodifiableListView<Member> get members => _searchString.isEmpty
      ? UnmodifiableListView(_members)
      : UnmodifiableListView(
      _members.where((member) => member.shortName.toLowerCase().contains(_searchString)).toList());

  void changeSearchString(String searchString) {
    _searchString = searchString;
    //print(_searchString);
    notifyListeners();
  }

  void loadData() async {
    _members =  await selectAll();
    print('_members $_members');
    notifyListeners();
  }

  void addMember(Member member) {
    _members.add(member);
    notifyListeners();
  }
}