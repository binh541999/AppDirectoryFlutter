import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:tiny_kms_directory/src/models/Member.dart';
import 'package:tiny_kms_directory/src/services/sqlLite/dboMember.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberModel extends ChangeNotifier {
  String _searchString = "";
  List<Member> _members = [];
  List<Member> _tempMembers = [];
  List<Member> _userInfo = [];

  UnmodifiableListView<Member> get members => _searchString.isEmpty
      ? UnmodifiableListView(_members)
      : UnmodifiableListView(_members
          .where((member) =>
              member.shortName.toLowerCase().contains(_searchString) ||
              member.titleName.toLowerCase().contains(_searchString) ||
              member.mobilePhone.toLowerCase().contains(_searchString))
          .toList());

  UnmodifiableListView<Member> get userInfo => UnmodifiableListView(_userInfo);

  UnmodifiableListView<Member> get tempMembers =>
      UnmodifiableListView(_tempMembers);

  void changeSearchString(String searchString) {
    _searchString = searchString;
    notifyListeners();
  }

  void loadDataJson(List<dynamic> json) async {
    try {
      _members.clear();
      _userInfo.clear();
      _searchString = '';
      if (json != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String userCode = prefs.getString('userCode');
        for (final value in json) {
          var member = new Member(
            employeeId: value['employeeId'],
            employeeCode: value['employeeCode'],
            shortName: value["shortName"],
            email: value["email"],
            skype: value["skype"],
            mobilePhone: value["mobilePhone"],
            userName: value["userName"],
            currentOfficeFullName: value["currentOfficeFullName"],
            currentOffice: value["currentOffice"],
            empVietnameseName: value["empVietnameseName"],
            titleName: value["titleName"],
            employeePicUrl: value["employeePicUrl"],
            fullName: value["fullName"],
          );
          if (value['employeeCode'] == userCode) {
            _userInfo.add(member);
          }
          _members.add(member);
        }
      }
    } catch (error) {
      print('fetch data Failed $error');
    }
  }

  Future<void> loadData() async {
    _members.clear();
    _userInfo.clear();
    _searchString = '';
    _members = await selectAllMember();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userCode = prefs.getString('userCode');
    _userInfo = _members.where((i) => i.employeeCode == userCode).toList();
    notifyListeners();
  }

  void addMember(Member member) {
    _members.add(member);
    notifyListeners();
  }

  void removeTempMember(Member member) {
    _tempMembers.add(member);
    _tempMembers.removeWhere(
        (tempMember) => tempMember.employeeId == member.employeeId);
    notifyListeners();
  }

  void addTempMember(Member member) {
    _tempMembers.add(member);
    notifyListeners();
  }

  void removeAllTempMember() {
    _tempMembers.clear();
    notifyListeners();
  }

  void removeAll() {
    _members.clear();
    //_userInfo.clear();
    _searchString = '';
    notifyListeners();
  }
}
