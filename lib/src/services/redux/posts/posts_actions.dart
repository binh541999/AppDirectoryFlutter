import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:redux_example/src/services/models/i_post.dart';
import 'package:redux_example/src/services/redux/posts/posts_state.dart';
import 'package:redux_example/src/services/redux/store.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class SetPostsStateAction {
  final PostsState postsState;

  SetPostsStateAction(this.postsState);
}

Future<void> fetchPostsAction(Store<AppState> store) async {
  store.dispatch(SetPostsStateAction(PostsState(isLoading: true)));
  try {
    final response = await http.post(
        Uri.parse('https://home.kms-technology.com/api/Account/login'),
        headers: {
          "content-type" : "application/json",
          "accept" : "application/json",
        },
        body: json.encode({
          'username': 'binhtatnguyen',
          'password': 'T61b2541999',
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
    store.dispatch(SetPostsStateAction(PostsState(isLoading: false)));
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
    print(response.statusCode);
    assert(response.statusCode == 200);
    final jsonData = json.decode(response.body);

    store.dispatch(
      SetPostsStateAction(
        PostsState(
          isLoading: false,
          posts: IPost.listFromJson(jsonData['items']),
        ),
      ),
    );
  } catch (error) {
    print('Get Contact Failed $error');
    store.dispatch(SetPostsStateAction(PostsState(isLoading: false)));
  }
}
