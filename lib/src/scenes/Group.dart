import 'package:flutter/material.dart';



/// This is the stateful widget that the main application instantiates.
class Group extends StatefulWidget {
  Group({Key key}) : super(key: key);

  @override
  _GroupScreen createState() => _GroupScreen();
}

class _GroupScreen extends State<Group> {
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Index 0: Group',
      style: optionStyle,
    );
  }
}