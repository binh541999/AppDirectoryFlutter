import 'package:flutter/material.dart';
import 'package:redux_example/src/Components/CustomDrawer.dart';

import 'package:redux_example/src/services/models/TabNavigationItem.dart';

class RootNavigation extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Navigation(),
      
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class Navigation extends StatefulWidget {
  Navigation({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<Navigation> {
  int _selectedIndex = 0;



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            (_selectedIndex==0)? 'Contact' : 'Group',
        ),

      ),
      body: IndexedStack(
        index:_selectedIndex,
        children: [
          for (final tabItem in TabNavigationItem.items )
            tabItem.screen,
        ],
      ),
      // drawer: Drawer(
      //   child: CustomDrawer()
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          for (final tabItem in TabNavigationItem.items )
            BottomNavigationBarItem(
                icon: tabItem.icon,
                label: tabItem.title,
            )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
