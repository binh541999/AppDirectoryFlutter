import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:redux_example/src/Components/CustomContact.dart';
import 'package:redux_example/src/Components/CustomCreateGroup.dart';
import 'package:redux_example/src/Components/CustomGroupAvatar.dart';
import 'package:redux_example/src/Components/CustomGroupAvatarTesting.dart';
import 'package:redux_example/src/Components/CustomUpdateGroup.dart';
import 'package:redux_example/src/models/GroupMember.dart';
import 'package:redux_example/src/models/Groups.dart';
import 'package:redux_example/src/models/Member.dart';
import 'package:redux_example/src/providers/GroupMemberModel.dart';
import 'package:redux_example/src/providers/GroupModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux_example/src/providers/MemberModel.dart';
import 'package:redux_example/src/scenes/AddMemberToGroup.dart';

class Group extends StatefulWidget {
  Group({
    Key key,
  }) : super(key: key);

  @override
  _MyGroupPageState createState() => _MyGroupPageState();
}

class _MyGroupPageState extends State<Group> {
  List<Member> groupMembers = [];
  bool isVisible = false;
  @override
  void initState() {
    // Provider.of<GroupMemberModel>(context, listen: false).changeIDGroup(
    //   Provider.of<GroupModel>(context, listen: false).currentGroup.id
    // );

    super.initState();
  }

  void _onPressAddMember() {
    Navigator.of(context).push(MaterialPageRoute(
      // we'll look at ColorDetailPage later
      builder: (context) => AddMember(
        idCurrentGroup:
            Provider.of<GroupModel>(context, listen: false).currentGroup.id,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var members = Provider.of<MemberModel>(context, listen: false).members;
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          setState(() {
            isVisible=false;
          });
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: 100,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Consumer<GroupModel>(
                          builder: (context, groupsData, child) {
                        return Consumer<GroupMemberModel>(
                            builder: (context, membersData, child) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: groupsData.groups.length,
                              itemBuilder: (BuildContext context, int index) {
                                List<String> imageLists = [];
                                var test = members.where((member) {
                                  var temp = membersData.groupMems.indexWhere(
                                      (element) =>
                                          element.idMember == member.employeeId &&
                                          element.idGroup ==
                                              groupsData.groups[index].id);
                                  return temp > -1 ? true : false;
                                }).toList();
                                for (int i = 0; i < 3; i++) {
                                  if (test.isNotEmpty) {
                                    if (i < test.length) {
                                      imageLists.add(test[i].employeePicUrl);
                                      continue;
                                    }
                                    imageLists.add('');
                                  }
                                }
                                return Stack(
                                  children: [
                                    Positioned(
                                      child: RawMaterialButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onPressed: () {
                                          Provider.of<GroupModel>(context, listen: false)
                                              .currentGroup = groupsData.groups[index];
                                          Provider.of<GroupMemberModel>(context, listen: false)
                                              .changeIDGroup(groupsData.groups[index].id);
                                        },
                                        onLongPress: () {
                                          setState(() {
                                            isVisible = true;
                                          });
                                        },
                                        child: CustomGroupAvatar(
                                            groupData: groupsData.groups[index],
                                            currentGroupID:
                                                groupsData.currentGroup.id,
                                            imageList: imageLists),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 3,
                                      child: Center(
                                        child: Container(
                                          height: 20,
                                          width: 70,
                                          child: RawMaterialButton(
                                            fillColor: !isVisible ? null : Colors.grey,
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            shape: new StadiumBorder(),
                                            onPressed: () => isVisible
                                                ? customUpdateGroup(context, groupsData.groups[index])
                                                : null,
                                            child: RichText(
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              strutStyle: StrutStyle(fontSize: 16.0),
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      color:
                                                      groupsData.currentGroup.id == groupsData.groups[index].id
                                                          ? Colors.blueAccent
                                                          : Colors.black),
                                                  text: groupsData.groups[index].name),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isVisible,
                                      child: Positioned(
                                        top: 3,
                                        right: 1,
                                        child: Center(
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey,
                                              border: Border.all(
                                                color: Colors.grey,
                                                width: 0.5,
                                              ),
                                            ),
                                            child: FloatingActionButton(
                                                heroTag: groupsData.groups[index].id,
                                                backgroundColor: Colors.grey,
                                                foregroundColor: Colors.white,
                                                elevation: 0,
                                                onPressed: () {
                                                  Provider.of<GroupMemberModel>(context, listen: false)
                                                      .deleteGroupMemberWithGroupId(
                                                      groupsData.groups[index].id);
                                                  Provider.of<GroupModel>(context, listen: false)
                                                      .deleteGroup(groupsData.groups[index].id);
                                                },
                                                child: Icon(Icons.clear)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                                //   CustomGroupAvatar(
                                //   currentGroupID: groupsData.currentGroup.id,
                                //   imageList: imageLists,
                                //   groupData: groupsData.groups[index],
                                //   key:
                                //       Key(groupsData.groups[index].id.toString()),
                                // );
                              }
                              //children: _buildPosts(posts),
                              );
                        });
                      }),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              clipBehavior: Clip.antiAlias,
                              child: FloatingActionButton(
                                  heroTag: 'btnAddGroup',
                                  tooltip: 'Add new group',
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  onPressed: () {
                                    customCreateGroup(context);
                                  },
                                  child: Icon(Icons.add)),
                            )),
                        Flexible(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            strutStyle: StrutStyle(fontSize: 16.0),
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                text: 'New Group'),
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.blueAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                      heroTag: 'btnMessageGroup',
                      tooltip: 'Message group',
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      disabledElevation: 0,
                      onPressed: () => print('Add group'),
                      child: Icon(Icons.message)),
                  FloatingActionButton(
                      heroTag: 'btnMailGroup',
                      tooltip: 'Mail group',
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      onPressed: () => print('Add group'),
                      child: Icon(Icons.mail)),
                  FloatingActionButton(
                    heroTag: 'btnAddMem',
                    tooltip: 'Add mem group',
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    child: FaIcon(FontAwesomeIcons.userCheck, size: 18),
                    onPressed: () => _onPressAddMember(),
                    // {
                    //   Navigator.push(
                    //       context,
                    //     new  MaterialPageRoute(
                    //         builder: (BuildContext context) =>
                    //             AddMember(),
                    //       ));
                    // },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<GroupMemberModel>(
                  builder: (context, membersData, child) {
                if (membersData.currentGroupMembers.length > 0) {
                  //print('member ID group ${membersData.groupMems.last.idMember}');
                  //var members =  Provider.of<MemberModel>(context, listen: false).members;
                  var test = members.where((member) {
                    var index = membersData.currentGroupMembers.indexWhere(
                        (element) => element.idMember == member.employeeId);
                    // var index = notes.indexWhere((element) =>
                    // element == member.employeeId);
                    return index > -1 ? true : false;
                  }).toList();
                  return ListView.builder(
                    itemCount: test.length,
                    itemBuilder: (BuildContext context, int index) =>
                        CustomContact(
                      employeeData: test[index],
                      key: Key(test[index].employeeId.toString()),
                    ),
                    //children: _buildPosts(posts),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Don\'t have member yet'),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
