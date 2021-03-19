import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/models/Groups.dart';
import 'package:redux_example/src/providers/GroupModel.dart';

customCreateGroup(BuildContext context) {
  final groupName = TextEditingController();

  // set up the buttons
  Widget cancelButton = RawMaterialButton(
    splashColor: Colors.blue,
    fillColor: Colors.blueAccent,
    child: Text(
      "Cancel",
      style: TextStyle(color: Colors.white),
    ),
    onPressed: () {},
  );
  Widget continueButton = RawMaterialButton(
    splashColor: Colors.blue,
    fillColor: Colors.blueAccent,
    child: Text(
      "Save",
      style: TextStyle(color: Colors.white),
    ),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Create Group",
      textAlign: TextAlign.center,
    ),
    content: TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        border: OutlineInputBorder(),
        labelText: 'Group name',
      ),
      controller: groupName,
    ),
    actions: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
        RawMaterialButton(
          splashColor: Colors.blue,
          fillColor: Colors.blueAccent,
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        Consumer<GroupModel>(
          builder: (context, groupsData, child) {
            return RawMaterialButton(
              
              splashColor: Colors.blue,
              fillColor: Colors.blueAccent,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                groupsData.groups.forEach((element) {
                  if(element.id ==  groupsData.groups.last.id && element.name != groupName.text )
                    {
                      var group = new Groups(
                          id:groupsData.groups[groupsData.groups.length-1].id +1,
                          name:groupName.text
                      );

                      groupsData.addGroup(group);
                      Navigator.of(context, rootNavigator: true).pop();
                    }

                });

              },
            );
          },
        ), // button 2
      ])
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
