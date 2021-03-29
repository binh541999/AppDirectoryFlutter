import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/Components/CustomChooseContactBeforeCreate.dart';
import 'package:redux_example/src/models/GroupMember.dart';
import 'package:redux_example/src/models/Groups.dart';
import 'package:redux_example/src/models/MemberUsernameOnly.dart';
import 'package:redux_example/src/providers/GroupMemberModel.dart';
import 'package:redux_example/src/providers/GroupModel.dart';
import 'package:redux_example/src/providers/MemberModel.dart';
import 'package:redux_example/src/services/api/groupApi/groupAPI.dart';


customCreateGroup(BuildContext context) {
  final groupName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _controller = TextEditingController();
  bool _validate = false;

  // show the dialog
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: "Modal",
    pageBuilder: (_, __, ___) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  Provider.of<MemberModel>(context, listen: false)
                      .removeAllTempMember();
                  Navigator.of(context, rootNavigator: true).pop();
                }),
            title: Text(
              "Create Group",
              style: TextStyle(
                  color: Colors.black87, fontFamily: 'Overpass', fontSize: 20),
            ),
            actions: [
              Consumer<GroupModel>(
                builder: (context, groupsData, child) {
                  return RawMaterialButton(
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Overpass',
                          fontSize: 20),
                    ),
                    onPressed: () async {
                      groupsData.groups.forEach((element) {
                        if (element.name == groupName.text || groupName.text == '') {
                          _validate = true;

                        }
                      });

                      if (!_validate) {
                        _validate = false;

                        List<MemberUsernameOnly> members = [];
                        var tempMembers =
                            Provider.of<MemberModel>(context, listen: false)
                                .tempMembers;
                        var userInfo =
                            Provider.of<MemberModel>(context, listen: false)
                                .userInfo;
                        members.add(new MemberUsernameOnly(
                            username: userInfo.first.userName));
                        if (tempMembers?.isNotEmpty ?? false) {
                          tempMembers.forEach((element) {
                            members.add(new MemberUsernameOnly(
                                username: element.userName));
                          });
                          Provider.of<MemberModel>(context, listen: false)
                              .removeAllTempMember();
                        }

                        List jsonList = [];
                        members
                            .map((item) => jsonList.add(item.toJson()))
                            .toList();

                        int groupID =
                            await fetchPostGroup(groupName.text, jsonList);
                        if (groupID > -1) {
                          var group =
                              new Groups(id: groupID, name: groupName.text);
                          groupsData.addGroup(group);
                          groupsData.currentGroup = groupsData.groups[0];
                          Provider.of<GroupMemberModel>(context, listen: false)
                              .changeIDGroup(groupsData.groups[0].id);
                          members.forEach((element) {
                            Provider.of<GroupMemberModel>(context,
                                    listen: false)
                                .addGroupMember(new GroupMember(
                              idGroup: groupID,
                              userName: element.username,
                            ));
                          });
                        }
                        Navigator.of(context, rootNavigator: true).pop();
                      } else {
                        _formKey.currentState.validate();
                        _validate = false;
                      };
                    },
                  );
                },
              ),
            ],
            elevation: 0.0),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: const Color(0xfff8f8f8),
                width: 1,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
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
                  controller: groupName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text('Members'),
              ),
              Container(
                child: Consumer<MemberModel>(
                    builder: (context, membersData, child) {
                  if (membersData.tempMembers?.isNotEmpty ?? false) {
                    return Container(
                      height: 80,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: membersData.tempMembers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Positioned(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      width: 60,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            height: 70,
                                            alignment: Alignment.topCenter,
                                            fit: BoxFit.fitWidth,
                                            imageUrl: membersData
                                                .tempMembers[index]
                                                .employeePicUrl,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    'lib/src/assets/Image/avatarDefault.png'),
                                          )),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 3,
                                  right: 0,
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
                                          heroTag: 'tempMember $index',
                                          backgroundColor: Colors.grey,
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                          onPressed: () {
                                            Provider.of<MemberModel>(context,
                                                    listen: false)
                                                .removeTempMember(membersData
                                                    .tempMembers[index]);
                                          },
                                          child: Icon(Icons.clear)),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('0 member '),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text('List of contacts'),
              ),
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
                child: Consumer<MemberModel>(
                    builder: (context, membersData, child) {
                  var memberlist = membersData.members.where((member) => member.userName != null).toList();

                  return ListView.builder(
                      itemCount: memberlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomChooseContactBeforeCreateGroup(
                          employeeData: memberlist[index],
                          key: Key(
                              memberlist[index].employeeId.toString()),
                        );
                      });
                }),
              ),
            ],
          ),
        ),
      );
    },
  );
}
