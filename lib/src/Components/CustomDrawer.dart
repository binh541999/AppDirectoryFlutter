// import 'package:flutter/material.dart';
// import 'package:redux_example/src/services/models/TabNavigationItem.dart';
// import 'package:redux_example/src/services/models/i_post.dart';
// import 'package:redux_example/src/services/redux/store.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class CustomDrawer extends StatelessWidget {
//   static const String _title = 'Flutter Code Sample';
//   // SharedPreferences prefs = await SharedPreferences.getInstance();
//   // String token = prefs.getString('token');
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: ListView(
//         // Important: Remove any padding from the ListView.
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           DrawerHeader(
//             child: Column(children: [
//               StoreConnector<AppState, List<IPost>>(
//                   distinct: true,
//                   converter: (store) {
//                     return store.state.postsState.posts;
//                   },
//                   builder: (context, posts) {
//                     return(
//                         Container(
//                           width: 100,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(90),
//                             child: Image.network(
//                               //employeeData['employeePicUrl'],
//                               height: 100,
//                               alignment: Alignment.topCenter,
//                               fit: BoxFit.fitWidth,
//                               errorBuilder: (BuildContext context, Object exception,
//                                   StackTrace stackTrace) {
//                                 return Image.asset(
//                                     'lib/src/assets/Image/avatarDefault.png');
//                               },
//                             ),
//                           ),
//                         ),
//                     );
//                   }),
//
//             ]),
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//           ),
//           ListTile(
//             title: Text('Item 1'),
//             onTap: () {
//               // Update the state of the app
//               // ...
//               // Then close the drawer
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             title: Text('Item 2'),
//             onTap: () {
//               // Update the state of the app
//               // ...
//               // Then close the drawer
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
