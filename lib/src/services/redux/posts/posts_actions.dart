import 'dart:convert';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:redux_example/src/services/function/fetchDataintoDb.dart';
import 'package:redux_example/src/models/i_post.dart';
import 'package:redux_example/src/services/redux/posts/posts_state.dart';
import 'package:redux_example/src/services/redux/store.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class SetPostsStateAction {
  final PostsState postsState;

  SetPostsStateAction(this.postsState);
}

Future<void> fetchPostsAction(Store<AppState> store,String username,String password) async {
  store.dispatch(SetPostsStateAction(PostsState(isLoading: true)));
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
    fetchGetsAction(store);
  } catch (error) {
    print('Log in Failed $error');
    store.dispatch(SetPostsStateAction(PostsState(isLoading: false,isError: true)));
  }
}

Future<void> fetchGetsAction(Store<AppState> store) async {
  store.dispatch(SetPostsStateAction(PostsState(isLoading: true)));
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
    print(response.body.length);
    final jsonData = json.decode(response.body);
    jsonData['items'].sort((a, b) => a['shortName'].toString().toLowerCase().compareTo(b['shortName'].toString().toLowerCase()));
    await  dispatchContact(jsonData['items']);


    // print (jsonData['items'].where((item) => (item["employeeCode"].toString().contains(userCode))));
    //  await prefs.setStringList('userInfo',jsonData['items'].where((item) => (item["employeeCode"].toString().contains(userCode))));
    //  print(prefs.getString('userInfo'));
    store.dispatch(
      SetPostsStateAction(
        PostsState(
          isLoading: false,
          isError: false,
          posts: IPost.listFromJson(jsonData['items']),
        ),
      ),
    );
  } catch (error) {
    print('Get Contact Failed $error');
    store.dispatch(SetPostsStateAction(PostsState(isLoading: false,isError: true)));
  }
}
