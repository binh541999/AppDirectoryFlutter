import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiny_kms_directory/src/models/GroupMember.dart';
import 'package:tiny_kms_directory/src/models/Groups.dart';
import 'package:tiny_kms_directory/src/models/Member.dart';
import 'package:tiny_kms_directory/src/models/MemberUsernameOnly.dart';
import 'package:tiny_kms_directory/src/providers/GroupMemberModel.dart';
import 'package:tiny_kms_directory/src/providers/GroupModel.dart';
import 'package:tiny_kms_directory/src/services/api/groupApi/groupAPI.dart';

customChooseGroup(BuildContext context, Member contactData) {
  bool _isSelected = false;

  void _onPressGroup(Groups group) {
    var newGroupMember =
        new GroupMember(idGroup: group.id, userName: contactData.userName);
    _isSelected = !_isSelected;
    if (_isSelected) {
      Provider.of<GroupMemberModel>(context, listen: false)
          .addGroupMember(newGroupMember);
      var memberList = Provider.of<GroupMemberModel>(context, listen: false)
          .groupMems
          .where((member) => member.idGroup == group.id)
          .toList();
      List<MemberUsernameOnly> members = [];
      if (memberList?.isNotEmpty ?? false) {
        memberList.forEach((element) {
          members.add(new MemberUsernameOnly(username: element.userName));
        });
      }

      List jsonList = [];
      members.map((item) => jsonList.add(item.toJson())).toList();
      print(jsonList);
      fetchPutGroup(group.id, group.name, jsonList);
    } else {
      Provider.of<GroupMemberModel>(context, listen: false)
          .deleteGroupMember(newGroupMember);
      var memberList = Provider.of<GroupMemberModel>(context, listen: false)
          .groupMems
          .where((member) => member.idGroup == group.id)
          .toList();
      List<MemberUsernameOnly> members = [];
      if (memberList?.isNotEmpty ?? false) {
        memberList.forEach((element) {
          members.add(new MemberUsernameOnly(username: element.userName));
        });
      }

      List jsonList = [];
      members.map((item) => jsonList.add(item.toJson())).toList();
      print(jsonList);
      fetchPutGroup(group.id, group.name, jsonList);
    }
  }

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Modal",
    pageBuilder: (_, __, ___) {
      return Dialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: const Color(0xfff8f8f8),
                width: 1,
              ),
            ),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Consumer<GroupModel>(builder: (context, groupsData, child) {
              if (groupsData.groups?.isNotEmpty ?? false) {
                return Container(
                  height: 80,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: groupsData.groups.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RawMaterialButton(
                            splashColor: Colors.grey,
                            onPressed: () {
                              _onPressGroup(groupsData.groups[index]);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(groupsData.groups[index].name),
                                SizedBox(
                                  width: 50.0,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Consumer<GroupMemberModel>(builder:
                                          (context, membersData, child) {
                                        var isSelected = false;
                                        var temp = membersData.groupMems
                                            .indexWhere((element) =>
                                                element.idGroup ==
                                                    groupsData
                                                        .groups[index].id &&
                                                element.userName ==
                                                    contactData.userName);
                                        if (temp > -1) {
                                          isSelected = true;
                                        }
                                        print('isSelected $isSelected');
                                        return Checkbox(
                                          value: isSelected,
                                        );
                                      }),
                                    ),
                                  ),
                                )
                              ],
                            ));
                      }),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Don\'t have any group yet '),
              );
            }),
          ),
        ),
      );
    },
  );
}
