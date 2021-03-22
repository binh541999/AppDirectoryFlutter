import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/models/Groups.dart';
import 'package:redux_example/src/providers/GroupModel.dart';

customCreateGroup(BuildContext context) {
  final groupName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  // set up the buttons

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Create Group",
      textAlign: TextAlign.center,
    ),
    content: Form(
      key: _formKey,
      child: TextFormField(
        validator: (value){
          if(_validate)
            return 'Name isn\'t valid';
          else return null;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          border: OutlineInputBorder(),
          labelText: 'Group name',

          errorText: _validate ? 'Name isn\'t valid' : null,
        ),
        controller: groupName,
      ),
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
                print('validate $_validate');
                groupsData.groups.forEach((element) {
                   if( element.name == groupName.text) {
                     _validate = true;
                  }
                });
                print('validate 2 $_validate');
                if(!_validate){
                  _validate = false;

                  var group = new Groups(
                      id: groupsData.groups[groupsData.groups.length - 1].id +
                          1,
                      name: groupName.text);
                  groupsData.addGroup(group);
                  Navigator.of(context, rootNavigator: true).pop();
                }
                else {
                  _formKey.currentState.validate();
                  _validate = false;
                };
                print('validate 3 $_validate');
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
