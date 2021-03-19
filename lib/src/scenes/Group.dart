import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/Components/CustomButtonAddMember.dart';
import 'package:redux_example/src/Components/CustomCreateGroup.dart';
import 'package:redux_example/src/Components/CustomGroupAvatar.dart';
import 'package:redux_example/src/models/Groups.dart';
import 'package:redux_example/src/providers/GroupModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux_example/src/scenes/AddMemberToGroup.dart';

class Group extends StatefulWidget {
  Group({
    Key key,
  }) : super(key: key);

  @override
  _MyGroupPageState createState() => _MyGroupPageState();
}

class _MyGroupPageState extends State<Group> {
  Groups currentGroup = new Groups();
  @override
  void initState() {
    super.initState();
  }
  void _onPressAddMember() {
    Navigator.of(context).push(MaterialPageRoute(
      // we'll look at ColorDetailPage later
      builder: (context) => AddMember(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Container(
              height: 100,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Consumer<GroupModel>(
                        builder: (context, groupsData, child) {
                          print(groupsData.currentGroup.name);
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: groupsData.groups.length,
                        itemBuilder: (BuildContext context, int index) =>
                            CustomGroupAvatar(
                              currentGroupID: groupsData.currentGroup.id,
                          groupData: groupsData.groups[index],
                          key: Key(groupsData.groups[index].id.toString()),
                        ),
                        //children: _buildPosts(posts),
                      );
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
                    child: FaIcon(FontAwesomeIcons.userCheck,size: 18),
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
          )
        ],
      ),
    );
  }
}
