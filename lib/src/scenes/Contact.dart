import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_example/src/Components/CustomContact.dart';
import 'package:redux_example/src/services/models/Member.dart';
import 'package:redux_example/src/services/models/i_post.dart';
import 'package:redux_example/src/services/redux/store.dart';
import 'package:redux_example/src/services/sqlLite/dboMember.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
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
  List<Member> filteredList = [];
  List<Member> members = [];
  bool doItJustOnce = false;
  var _controller = TextEditingController();

  @override
  void initState() {
    //filteredList= testPress();
    super.initState();
  }



  void deleteDB() async {
    String path = join(await getDatabasesPath(), 'directory_database.db');
    deleteDatabase(path);
  }

  void _onFetchPostsPressed() {
    Redux.store.dispatch(
        fetchPostsAction(Redux.store, 'binhtatnguyen', 'T61b2541999'));
  }

  void filter(String inputString) {
    filteredList = members
        .where((i) => i.shortName.toLowerCase().contains(inputString))
        .toList();
   // print(filteredList[0].fullName);
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
                //deleteDB,
                //testPress,
                _onFetchPostsPressed,
          ),
          RawMaterialButton(
            child: Text("Delete DB Posts"),
            onPressed: deleteDB,
            //testPress,
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
          // Expanded(
          //   child:
          //   StoreConnector<AppState, List<IPost>>(
          //     distinct: true,
          //     converter: (store) {
          //       fooList = store.state.postsState.posts;
          //       filteredList = fooList;
          //       return store.state.postsState.posts;
          //     },
          //     builder: (context, posts) {
          //       return ListView.builder(
          //         itemCount: members.length,
          //         itemBuilder: (BuildContext context, int index) =>
          //             CustomContact(
          //               employeeData: members[index],
          //               key: Key(members[index].employeeId.toString()),
          //             ),
          //
          //         // itemCount: filteredList.length,
          //         // itemBuilder: (BuildContext context, int index) =>
          //         //     CustomContact(
          //         //   employeeData: filteredList[index].employee,
          //         //   key: Key(filteredList[index].id.toString()),
          //         // ),
          //         //children: _buildPosts(posts),
          //       );
          //     },
          //   ),
          // )

          Expanded(
            child: FutureBuilder(
                future: selectAll(),
                builder: (BuildContext context, AsyncSnapshot<List<Member>> data) {
              if (data.hasData) {
                if (!doItJustOnce) {

                  //You should define a bool like (bool doItJustOnce = false;) on your state.
                  members = data.data;
                  filteredList = members;
                  doItJustOnce = !doItJustOnce; //this line helps to do just once.
                }
              }
              return ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (BuildContext context, int index) => CustomContact(
                  employeeData: filteredList[index],
                  key: Key(filteredList[index].employeeId.toString()),
                ),
                //children: _buildPosts(posts),
              );
            }),
          ),
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
