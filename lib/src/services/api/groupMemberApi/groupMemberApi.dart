import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tiny_kms_directory/src/providers/GroupMemberModel.dart';
import 'package:tiny_kms_directory/src/providers/GroupModel.dart';
import 'package:tiny_kms_directory/src/providers/StatusModel.dart';
import 'package:tiny_kms_directory/src/services/function/fetchDataintoDb.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String url = 'http://10.0.2.2:8001/api';
String urlPython = 'http://10.0.2.2:8000/api';

Future<bool> fetchGetGroupMember(BuildContext context, int groupId) async {
  Provider.of<StatusModel>(context, listen: false).isLoading = true;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  try {
    final response = await http.get(Uri.parse(
        //'https://hr.kms-technology.com/api/Contact/ReturnContactList/0/0'
        '$url/groups/$groupId'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    //print(json.decode(response.body));
    assert(response.statusCode == 200);
    final jsonData = json.decode(response.body);

    Provider.of<GroupMemberModel>(context, listen: false)
        .loadDataJson(jsonData);
    Provider.of<GroupMemberModel>(context, listen: false).changeIDGroup(
        Provider.of<GroupModel>(context, listen: false).currentGroup.id);
    Provider.of<StatusModel>(context, listen: false).isLoading = false;
    Provider.of<StatusModel>(context, listen: false).isError = false;
    Provider.of<StatusModel>(context, listen: false).isFirstOpen = false;
    dispatchGroupMember(jsonData);
    return true;
  } catch (error) {
    print('Get group member Failed $error');
    Provider.of<StatusModel>(context, listen: false).isLoading = false;
    Provider.of<StatusModel>(context, listen: false).isError = true;
    return false;
  }
}
