import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/Components/CustomUpdateGroup.dart';
import 'package:redux_example/src/models/Groups.dart';
import 'package:redux_example/src/models/Member.dart';
import 'package:redux_example/src/providers/GroupMemberModel.dart';
import 'package:redux_example/src/providers/GroupModel.dart';
import 'package:redux_example/src/providers/MemberModel.dart';

class CustomGroupAvatarTest extends StatefulWidget {
  CustomGroupAvatarTest({
    Key key,
    @required this.groupData,
    @required this.currentGroupID,
    @required this.imageList,
  }) : super(key: key);
  final int currentGroupID;
  final Groups groupData;
  final List<String> imageList;

  // final List<GroupMember> groupData;

  @override
  _CustomGroupAvatar createState() => _CustomGroupAvatar();
}

class _CustomGroupAvatar extends State<CustomGroupAvatarTest> {
  String imageUrl = '';
  bool isVisible = false;

  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   //setImageAvatar();
  // }

  void _onPressContact() {}

  Widget _buildAvatar(String picUrl) {
    return Expanded(
      child: Container(
        height: 33,
        width: 33,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              left: -5,
              bottom: 0,
              top: 0,
              child: CachedNetworkImage(
                alignment: Alignment.center,
                height: 33,
                fit: BoxFit.fitWidth,
                imageUrl: picUrl.isNotEmpty ? picUrl : '',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Image.asset('lib/src/assets/Image/avatarDefault.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 80,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0, left: 5.0),
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.currentGroupID == widget.groupData.id
                        ? Colors.blueAccent
                        : Colors.grey,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 70,
                              width: 33,
                              child: Stack(children: [
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: -5,
                                  child: CachedNetworkImage(
                                    alignment: Alignment.topCenter,
                                    height: 70,
                                    fit: BoxFit.fitWidth,
                                    imageUrl: widget.imageList.isNotEmpty
                                        ? widget.imageList[0]
                                        : '',
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            'lib/src/assets/Image/avatarDefault.png'),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          _buildAvatar(widget.imageList.isNotEmpty
                              ? widget.imageList[1]
                              : ''),
                          _buildAvatar(widget.imageList.isNotEmpty
                              ? widget.imageList[2]
                              : ''),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
