import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tiny_kms_directory/src/providers/GroupModel.dart';
import 'package:tiny_kms_directory/src/providers/StatusModel.dart';
import 'package:tiny_kms_directory/src/services/api/groupMemberApi/groupMemberApi.dart';
import 'package:tiny_kms_directory/src/services/function/fetchDataintoDb.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String url = 'http://10.0.2.2:8001/api';
String urlPython = 'http://10.0.2.2:8000/api';

Future<bool> fetchGetGroup(BuildContext context) async {
  Provider.of<StatusModel>(context, listen: false).isLoading = true;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  try {
    final response = await http.get(Uri.parse(
        //'https://hr.kms-technology.com/api/Contact/ReturnContactList/0/0'
        '$url/groups'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    assert(response.statusCode == 200);

    final jsonData = json.decode(response.body);

    for (var group in jsonData) {
      fetchGetGroupMember(context, group['group_id']);
    }
    Provider.of<GroupModel>(context, listen: false).loadDataJson(jsonData);
    Provider.of<StatusModel>(context, listen: false).isLoading = false;
    Provider.of<StatusModel>(context, listen: false).isError = false;
    Provider.of<StatusModel>(context, listen: false).isFirstOpen = false;
    dispatchGroup(jsonData);
    return true;
  } catch (error) {
    print('Get group Failed $error');
    Provider.of<StatusModel>(context, listen: false).isLoading = false;
    Provider.of<StatusModel>(context, listen: false).isError = true;
    return false;
  }
}

Future<int> fetchPostGroup(String groupName, List<dynamic> members) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  try {
    final response = await http.post(
        //Uri.parse('https://home.kms-technology.com/api/Account/login'),
        Uri.parse('$url/groups'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({"group_name": groupName, "members": members}));
    assert(response.statusCode == 200);
    final jsonData = json.decode(response.body);
    return jsonData['group_id'];
  } catch (error) {
    print('Get Contact Failed $error');
    return -1;
  }
}

Future<int> fetchPutGroup(
    int groupID, String groupName, List<dynamic> members) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  try {
    final response = await http.put(
        //Uri.parse('https://home.kms-technology.com/api/Account/login'),
        Uri.parse('$url/groups/$groupID'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({"group_name": groupName, "members": members}));
    print('$groupID + $groupName');

    print(json.decode(response.body));
    assert(response.statusCode == 200);
    final jsonData = json.decode(response.body);
    return jsonData['group_id'];
  } catch (error) {
    print('Get put group Failed $error');
    return -1;
  }
}

Future<int> fetchDeleteGroup(int groupId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  print(token);
  print('$url/groups/$groupId');
  try {
    final response = await http.delete(
        //Uri.parse('https://home.kms-technology.com/api/Account/login'),
        Uri.parse('$url/groups/$groupId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    print(json.decode(response.body));
    assert(response.statusCode == 200);
    final jsonData = json.decode(response.body);
    return jsonData['group_id'];
  } catch (error) {
    print('Get Contact Failed $error');
    return -1;
  }
}
