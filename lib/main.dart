import 'package:flutter/material.dart';
import 'package:redux_example/src/providers/GroupMemberModel.dart';
import 'package:redux_example/src/providers/GroupModel.dart';
import 'package:redux_example/src/providers/MemberModel.dart';
import 'package:redux_example/src/providers/StatusModel.dart';
import 'package:redux_example/src/scenes/LogIn.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/scenes/Splash.dart';
import 'src/navigations/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MemberModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => StatusModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => GroupModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => GroupMemberModel(),
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
        initialRoute: '/splash',
        // Provider.of<StatusModel>(context).isFirstOpen ?
        // '/' :
        // '/homePage',
        routes: {
          '/splash':(_)=>SplashScreen(),
          '/':(_)=> LogIn(),
          '/homePage':(_)=>RootNavigation(),

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
