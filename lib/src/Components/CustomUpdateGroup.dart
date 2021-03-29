import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/models/Groups.dart';
import 'package:redux_example/src/models/MemberUsernameOnly.dart';
import 'package:redux_example/src/providers/GroupMemberModel.dart';
import 'package:redux_example/src/providers/GroupModel.dart';
import 'package:redux_example/src/services/api/groupApi/groupAPI.dart';

customUpdateGroup(BuildContext context, Groups groupData) {
  final newName = TextEditingController(text: groupData.name);
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  // set up the buttons

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Update Group",
      textAlign: TextAlign.center,
    ),
    content: Form(
      key: _formKey,
      child: TextFormField(
        validator: (value) {
          if (_validate)
            return 'Name isn\'t valid';
          else
            return null;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          border: OutlineInputBorder(),
          labelText: 'Group name',
          errorText: _validate ? 'Name isn\'t valid' : null,
        ),
        controller: newName,
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
                //groupsData.groups.forEach((element) {
                for (final element in groupsData.groups) {
                  if (element.name == newName.text &&
                      newName.text != groupData.name) {
                    _validate = true;
                    break;
                  }
                }
                ;
                if (!_validate) {
                  _validate = false;
                  var group = new Groups(
                      id: groupData.id,
                      name: newName.text);
                  groupsData.updateGroup(group);
                  var memberList = Provider
                      .of<GroupMemberModel>(context, listen: false)
                      .groupMems.where((member) => member.idGroup == groupData.id).toList();
                  List<MemberUsernameOnly> members = [];
                  if (memberList?.isNotEmpty ?? false) {
                    memberList.forEach((element) {
                      members.add(new MemberUsernameOnly(
                          username: element.userName));
                      });
                    };
                  List jsonList = [];
                  members
                      .map((item) => jsonList.add(item.toJson()))
                      .toList();
                  print(jsonList);
                        fetchPutGroup(group.id, group.name, jsonList);
                        Navigator.of(context, rootNavigator: true).pop();
                  } else {
                    _formKey.currentState.validate();
                    _validate = false;
                  }
                  ;
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
