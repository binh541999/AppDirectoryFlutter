import 'package:flutter/material.dart';
import 'package:tiny_kms_directory/src/scenes/Contact.dart';
import 'package:tiny_kms_directory/src/scenes/Group.dart';

class TabNavigationItem {
  final Widget screen;
  final String title;
  final Icon icon;

  TabNavigationItem({
    @required this.screen,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
            screen: Contact(), icon: Icon(Icons.contacts), title: 'Contacts'),
        TabNavigationItem(
            screen: Group(), icon: Icon(Icons.group), title: 'Group'),
      ];
}
