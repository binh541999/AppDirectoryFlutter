import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/models/GroupMember.dart';
import 'package:redux_example/src/models/MemberUsernameOnly.dart';
import 'package:redux_example/src/providers/GroupModel.dart';
import 'package:redux_example/src/providers/MemberModel.dart';
import 'package:redux_example/src/providers/StatusModel.dart';
import 'package:redux_example/src/services/function/fetchDataintoDb.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

 String url = 'http://10.0.2.2:8000/api';
String urlPython = 'http://10.0.2.2:8000/api';

//final String url = 'http://172.26.240.1:5432/api';

Future<bool> fetchLogin(BuildContext context,String username,String password) async {
  Provider.of<StatusModel>(context, listen: false).isLoading = true;
  try {
    print(url);
    print('$urlPython/auth/login/');
    final response = await http.post(
       //Uri.parse('https://home.kms-technology.com/api/Account/login'),
        Uri.parse('$url/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'username': '$username',
          'password': '$password',
          'rememberMe': true,
        }));
    assert(response.statusCode == 200);
    if(response.statusCode == 200) {
      var body = json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', body['token']);
      await prefs.setString('userCode', body['employeeCode']);
      await fetchGetContact(context).then((value) {
        if (value) return true;
      }).catchError((onError) => false);
    }
    return true;
  } catch (error) {
    print('Log in Failed $error');
    Provider.of<StatusModel>(context, listen: false).isLoading = false;
    Provider.of<StatusModel>(context, listen: false).isError = true;
    return false;
  }
}

Future<bool> fetchGetContact(BuildContext context) async {
  Provider.of<StatusModel>(context, listen: false).isLoading = true;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');

  try {
    final response = await http.get(
        Uri.parse(
            //'https://hr.kms-technology.com/api/Contact/ReturnContactList/0/0'
            '$url/employees?page=0&items=0'
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    assert(response.statusCode == 200);

    final jsonData = json.decode(response.body);
    jsonData['items'].sort((a, b) => a['shortName'].toString().toLowerCase().compareTo(b['shortName'].toString().toLowerCase()));
    dispatchContact(jsonData['items']);

    await Provider.of<MemberModel>(context, listen: false).loadData();
    //await Provider.of<GroupModel>(context, listen: false).loadData();
    Provider.of<StatusModel>(context, listen: false).isLoading = false;
    Provider.of<StatusModel>(context, listen: false).isError = false;
    Provider.of<StatusModel>(context, listen: false).isFirstOpen = false;
return true;


  } catch (error) {
    print('Get Contact Failed $error');
    Provider.of<StatusModel>(context, listen: false).isLoading = false;
    Provider.of<StatusModel>(context, listen: false).isError = true;
  return false;
  }
}


Future<bool> fetchGetGroup(BuildContext context) async {
  Provider.of<StatusModel>(context, listen: false).isLoading = true;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');

  try {
    final response = await http.get(
        Uri.parse(
          //'https://hr.kms-technology.com/api/Contact/ReturnContactList/0/0'
            '$url/group'
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    assert(response.statusCode == 200);

    final jsonData = json.decode(response.body);
    dispatchContact(jsonData['items']);

    await Provider.of<MemberModel>(context, listen: false).loadData();
    //await Provider.of<GroupModel>(context, listen: false).loadData();
    Provider.of<StatusModel>(context, listen: false).isLoading = false;
    Provider.of<StatusModel>(context, listen: false).isError = false;
    Provider.of<StatusModel>(context, listen: false).isFirstOpen = false;
    return true;


  } catch (error) {
    print('Get Contact Failed $error');
    Provider.of<StatusModel>(context, listen: false).isLoading = false;
    Provider.of<StatusModel>(context, listen: false).isError = true;
    return false;
  }
}


Future<bool> fetchPostGroup(BuildContext context,String groupName,List<dynamic> members) async {
  Provider.of<StatusModel>(context, listen: false).isLoading = true;
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
        body: json.encode({
          "group_name": groupName,
          "members": members
        })
    );
    print(json.decode(response.body));
    assert(response.statusCode == 200);

    final jsonData = json.decode(response.body);
    // dispatchContact(jsonData['items']);
    //
    // await Provider.of<MemberModel>(context, listen: false).loadData();
    // //await Provider.of<GroupModel>(context, listen: false).loadData();
    // Provider.of<StatusModel>(context, listen: false).isLoading = false;
    // Provider.of<StatusModel>(context, listen: false).isError = false;
    // Provider.of<StatusModel>(context, listen: false).isFirstOpen = false;
     return true;


  } catch (error) {
    print('Get Contact Failed $error');
    Provider.of<StatusModel>(context, listen: false).isLoading = false;
    Provider.of<StatusModel>(context, listen: false).isError = true;
    return false;
  }
}