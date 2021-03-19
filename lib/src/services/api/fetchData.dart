import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/providers/GroupModel.dart';
import 'package:redux_example/src/providers/MemberModel.dart';
import 'package:redux_example/src/providers/StatusModel.dart';
import 'package:redux_example/src/services/function/fetchDataintoDb.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> fetchLogin(BuildContext context,String username,String password) async {
  Provider.of<StatusModel>(context, listen: false).isLoading = true;
  try {
    final response = await http.post(
        Uri.parse('https://home.kms-technology.com/api/Account/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'username': '$username',
          'password': '$password',
          'rememberMe': true,
        }));

    assert(response.statusCode == 200);
    var body = json.decode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', body['token']);
    await prefs.setString('userCode', body['employeeCode']);
    await fetchGetContact(context).then((value) {
      if(value) return true;
    }).catchError((onError)=>  false);
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
            'https://hr.kms-technology.com/api/Contact/ReturnContactList/0/0'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    assert(response.statusCode == 200);
    //print(response.body.length);
    final jsonData = json.decode(response.body);
    jsonData['items'].sort((a, b) => a['shortName'].toString().toLowerCase().compareTo(b['shortName'].toString().toLowerCase()));
    //await
   // Future.wait([
    dispatchContact(jsonData['items']);
    //]).catchError((onError)=> print(onError));
    await Provider.of<MemberModel>(context, listen: false).loadData();
    await Provider.of<GroupModel>(context, listen: false).loadData();
    Provider.of<StatusModel>(context, listen: false).isLoading = false;
    Provider.of<StatusModel>(context, listen: false).isError = false;
    Provider.of<StatusModel>(context, listen: false).isFirstOpen = false;
return true;
    // print (jsonData['items'].where((item) => (item["employeeCode"].toString().contains(userCode))));
    //  await prefs.setStringList('userInfo',jsonData['items'].where((item) => (item["employeeCode"].toString().contains(userCode))));
    //  print(prefs.getString('userInfo'));

  } catch (error) {
    print('Get Contact Failed $error');
    Provider.of<StatusModel>(context, listen: false).isLoading = false;
    Provider.of<StatusModel>(context, listen: false).isError = true;
  return false;
  }
}
