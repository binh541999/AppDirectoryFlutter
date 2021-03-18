import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_example/src/models/i_post.dart';
import 'package:redux_example/src/providers/MemberModel.dart';
import 'package:redux_example/src/providers/StatusModel.dart';
import 'package:redux_example/src/scenes/LogIn.dart';
import 'package:provider/provider.dart';
import 'src/navigations/index.dart';

void main() async {

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MemberModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => StatusModel(),
        ),
      ],
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute:Provider.of<StatusModel>(context).isFirstOpen ?
        '/' : '/homePage',
        routes: {
          '/':(_)=> LogIn(),
          '/homePage':(_)=>RootNavigation()
        },
        // home:
        //   RootNavigation(),

        // StoreProvider<AppState>(
        //   store: Redux.store,
        //   child:
        //   //MyHomePage(title:'hello')
        //   RootNavigation(),
        // ),
        );
  }
}
