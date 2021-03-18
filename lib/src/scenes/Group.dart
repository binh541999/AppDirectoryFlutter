import 'package:flutter/material.dart';
import 'package:redux_example/src/Components/CustomGroupAvatar.dart';


class Group extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyGroupPage(),
    );
  }
}

class MyGroupPage extends StatefulWidget {
  MyGroupPage({
    Key key,
  }) : super(key: key);

  @override
  _MyGroupPageState createState() => _MyGroupPageState();
}

class _MyGroupPageState extends State<MyGroupPage> {
  List fooList = ['one', 'two', 'three', 'four', 'five'];
  List filteredList = [];
  @override
  void initState() {
    super.initState();
    filteredList = fooList;
  }

  void filter(String inputString) {
    filteredList =
        fooList.where((i) => i.toLowerCase().contains(inputString)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomGroupAvatar(),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text(filteredList[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Display(
                        text: filteredList[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Display extends StatelessWidget {
  final String text;

  const Display({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(text),
      ),
    );
  }
}