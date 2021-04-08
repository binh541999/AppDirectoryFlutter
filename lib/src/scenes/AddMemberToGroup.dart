import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiny_kms_directory/src/Components/CustomChooseContact.dart';
import 'package:tiny_kms_directory/src/models/Groups.dart';
import 'package:tiny_kms_directory/src/models/MemberUsernameOnly.dart';
import 'package:tiny_kms_directory/src/providers/GroupMemberModel.dart';
import 'package:tiny_kms_directory/src/providers/MemberModel.dart';
import 'package:tiny_kms_directory/src/services/api/groupApi/groupAPI.dart';

class AddMember extends StatefulWidget {
  AddMember({Key key, @required this.currentGroup}) : super(key: key);
  final Groups currentGroup;
  @override
  _AddMember createState() => _AddMember();
}

class _AddMember extends State<AddMember> {
  var _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _onBackPressed() {
    var memberList = Provider.of<GroupMemberModel>(context, listen: false)
        .currentGroupMembers;
    List<MemberUsernameOnly> members = [];
    if (memberList?.isNotEmpty ?? false) {
      memberList.forEach((element) {
        members.add(new MemberUsernameOnly(username: element.userName));
      });
      List jsonList = [];
      members.map((item) => jsonList.add(item.toJson())).toList();
      print(jsonList);
      fetchPutGroup(widget.currentGroup.id, widget.currentGroup.name, jsonList);
      Navigator.of(context).pop(true);
    }

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Member'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      Provider.of<MemberModel>(context, listen: false)
                          .changeSearchString('');
                      return _controller.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                  hintText: 'Search ',
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                ),
                onChanged: (text) {
                  text = text.toLowerCase();
                  Provider.of<MemberModel>(context, listen: false)
                      .changeSearchString(text);
                },
              ),
            ),
            Expanded(
              child:
                  Consumer<MemberModel>(builder: (context, membersData, child) {
                var memberlist = membersData.members
                    .where((member) => member.userName != null)
                    .toList();
                return ListView.builder(
                  itemCount: memberlist.length,
                  itemBuilder: (BuildContext context, int index) =>
                      CustomChooseContact(
                    employeeData: memberlist[index],
                    idCurrentGroup: widget.currentGroup.id,
                    key: Key(memberlist[index].employeeId.toString()),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
