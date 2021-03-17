import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_example/src/models/i_post.dart';
import 'package:redux_example/src/providers/MemberModel.dart';
import 'package:redux_example/src/providers/StatusModel.dart';
import 'package:redux_example/src/scenes/LogIn.dart';
import 'package:redux_example/src/services/redux/posts/posts_actions.dart';
import 'package:redux_example/src/services/redux/store.dart';
import 'package:provider/provider.dart';
import 'src/navigations/index.dart';

void main() async {
  await Redux.init();

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _onFetchPostsPressed() {
    Redux.store.dispatch(fetchPostsAction);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          RawMaterialButton(
            child: Text("Fetch Posts"),
            onPressed: _onFetchPostsPressed,
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
            child: StoreConnector<AppState, List<IPost>>(
              distinct: true,
              converter: (store) => store.state.postsState.posts,
              builder: (context, posts) {
                return ListView(
                  children: _buildPosts(posts),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPosts(List<IPost> posts) {
    return posts
        .map(
          (post) => ListTile(
            title: Text(post.employee['fullName']),
            subtitle: Text(post.employee['titleName']),
            key: Key(post.id.toString()),
          ),
        )
        .toList();
  }
}

// Define a custom Form widget.
