import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_example/src/Components/CustomContact.dart';
import 'package:redux_example/src/services/models/Member.dart';
import 'package:redux_example/src/services/models/i_post.dart';
import 'package:redux_example/src/services/redux/store.dart';
import 'package:redux_example/src/services/sqlLite/dboMember.dart';
import 'package:sqflite/sqflite.dart';

import '../Components/CustomContact.dart';
import '../services/models/i_post.dart';
import '../services/redux/posts/posts_actions.dart';

class Contact extends StatefulWidget {
  Contact({
    Key key,
  }) : super(key: key);

  @override
  _Contact createState() => _Contact();
}

class _Contact extends State<Contact> {
  List<IPost> fooList = [];
  List<IPost> filteredList = [];
  List<Member> members=[];
  var _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void testPress() async{
    members= await selectAll();
    List<Member> members2= members.where(
            (i) => i.employeeCode == '0001')
        .toList();
    print(members2[1].fullName);
   // deleteDatabase(await getDatabasesPath());
  }

  void _onFetchPostsPressed() {
    Redux.store.dispatch(fetchPostsAction(Redux.store,'binhtatnguyen','T61b2541999'));
  }

  void filter(String inputString) {
    filteredList = fooList
        .where(
            (i) => i.employee['shortName'].toLowerCase().contains(inputString))
        .toList();
    print(filteredList[0].employee);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: _controller.clear,
                  icon: Icon(Icons.clear),
                ),
                hintText: 'Search ',
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
              onChanged: (text) {
                text = text.toLowerCase();
                filter(text);
              },
            ),
          ),
          RawMaterialButton(
            child: Text("Fetch Posts"),
            onPressed:
            testPress,
            //_onFetchPostsPressed,
          ),
          StoreConnector<AppState, bool>(
            distinct: true,
            converter: (store) => store.state.postsState.isLoading,
            builder: (context, isLoading) {
              if (isLoading) {
                return CircularProgressIndicator();
              } else {
                return SizedBox.shrink();
              }
            },
          ),
          StoreConnector<AppState, bool>(
            distinct: true,
            converter: (store) => store.state.postsState.isError,
            builder: (context, isError) {
              if (isError) {
                return Text("Failed to get posts");
              } else {
                return SizedBox.shrink();
              }
            },
          ),
          Expanded(
            child:
            StoreConnector<AppState, List<IPost>>(
              distinct: true,
              converter: (store) {
                fooList = store.state.postsState.posts;
                filteredList = fooList;
                return store.state.postsState.posts;
              },
              builder: (context, posts) {
                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (BuildContext context, int index) =>
                      CustomContact(
                    employeeData: filteredList[index].employee,
                    key: Key(filteredList[index].id.toString()),
                  ),
                  //children: _buildPosts(posts),
                );
              },
            ),
          )
          // Expanded(
          //   child:
          //       ListView.builder(
          //         itemCount: filteredList.length,
          //         itemBuilder: (BuildContext context, int index) =>
          //             CustomContact(
          //           employeeData: filteredList[index].employee,
          //           key: Key(filteredList[index].id.toString()),
          //         ),
          //         //children: _buildPosts(posts),
          //       ),
          // ),
        ],
      ),
    );
  }

  // List<Widget> _buildPosts(List<IPost> posts) {
  //   return posts
  //       .map(
  //         (post) => CustomContact(
  //           employeeData: post.employee,
  //           key: Key(post.id.toString()),
  //         ),
  //       )
  //       .toList();
  // }
}

//
// ListView.builder(itemBuilder: (
// context, index) {
// return CustomContact(
// shortName: 'Test Name',
// titleName: 'Test titleName',
// picURL: 'https://hr.kms-technology.com/api/employees/photo/600?code=WWlMYMQAzAC4VlscblYs3YsoAT0xvymkddOQyyA4Pdz4',
// )
// ;
// }
// )
