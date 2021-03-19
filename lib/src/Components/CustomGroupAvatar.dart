import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/models/Groups.dart';
import 'package:redux_example/src/providers/GroupModel.dart';

class CustomGroupAvatar extends StatefulWidget {
  CustomGroupAvatar({
    Key key,
    @required this.groupData,
    @required this.currentGroupID,
  }) : super(key: key);
  final int currentGroupID;
  final Groups groupData;

  // final List<GroupMember> groupData;

  @override
  _CustomGroupAvatar createState() => _CustomGroupAvatar();
}

class _CustomGroupAvatar extends State<CustomGroupAvatar> {
  String imageUrl = '';

  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   checkURL();
  // }
  void _onPressContact() {}

  Widget _buildAvatar() {
    return Expanded(
      child: Container(
        height: 33,
        width: 33,
        child: Stack(
          children: [
            Positioned(
              right: 5,
              child: CachedNetworkImage(
                alignment: Alignment.topCenter,
                height: 35,
                imageUrl: '',
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

        child: Column(
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
                  child: RawMaterialButton(
                    splashColor: Colors.blueAccent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      Provider.of<GroupModel>(context, listen: false)
                          .currentGroup = widget.groupData;
                    },
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
                                    top: 10,
                                    bottom: 5,
                                    left: -5,
                                    child: CachedNetworkImage(
                                      alignment: Alignment.topCenter,
                                      height: 70,
                                      fit: BoxFit.fitWidth,
                                      imageUrl: '',
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
                            _buildAvatar(),
                            _buildAvatar(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                strutStyle: StrutStyle(fontSize: 16.0),
                text: TextSpan(
                    style: TextStyle(
                        color:  widget.currentGroupID == widget.groupData.id
                            ? Colors.blueAccent
                            : Colors.black
                    ),
                    text: widget.groupData.name),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
