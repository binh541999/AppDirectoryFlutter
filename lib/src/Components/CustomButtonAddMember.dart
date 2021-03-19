import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux_example/src/scenes/AddMemberToGroup.dart';

class CustomButtonAddMember extends StatelessWidget  {


  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
        heroTag: 'btnAddMem',
        tooltip: 'Add mem group',
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
        onPressed: () {
          Navigator.push(
              context,
             MaterialPageRoute(
                builder: ( context) =>
                    AddMember(),
              ));
        },
        child: FaIcon(FontAwesomeIcons.userCheck,size: 18)

    );

  }
}
