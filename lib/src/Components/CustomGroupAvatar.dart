import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux_example/src/models/GroupMember.dart';
import 'package:redux_example/src/scenes/ContactDetail.dart';
import 'package:redux_example/src/models/Member.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomGroupAvatar extends StatefulWidget {
  CustomGroupAvatar({
    Key key,
    //@required this.groupData,
  }) : super(key: key);

  // final Map<String, dynamic> employeeData;
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

  Widget _buildAvatar(double avatarRadius, Color color) {
    return Expanded(
      child: Container(
        color: color,
        height: 35,
        width: 35,
        child: CachedNetworkImage(
          alignment: Alignment.topCenter,
          height: 35,
          imageUrl: '',
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              Image.asset('lib/src/assets/Image/avatarDefault.png'),
        ),
      ),
    );
  }

  final double _containerRadius = 70.0;

  @override
  Widget build(BuildContext context) {
    final double avatarRadius = _containerRadius * 0.5;
    return Material(
      child: Column(
        children: [
          Container(
            width: 60,
            color: Colors.grey,
            child: ClipOval(
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 0.0),
                    child: CachedNetworkImage(
                      width: 40,
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitHeight,
                      imageUrl: '',
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Image.asset('lib/src/assets/Image/avatarDefault.png'),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          height: 35,
                          alignment: Alignment.topCenter,
                          fit: BoxFit.fitWidth,
                          imageUrl: '',
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Image.asset(
                              'lib/src/assets/Image/avatarDefault.png'),
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              height: 35,
                              alignment: Alignment.topCenter,
                              fit: BoxFit.fitWidth,
                              imageUrl: '',
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Image.asset(
                                  'lib/src/assets/Image/avatarDefault.png'),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            'Ten Group',
            style: TextStyle(fontSize: 16.0),
            maxLines: 2,
            overflow: TextOverflow.clip,
          ),
          Center(
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
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
                            color: Colors.green,
                            height: 35,
                            width: 35,
                            child: Stack(children: [
                              Positioned(
                                top: 5,
                                bottom: 10,
                                left: 0,
                                child: CachedNetworkImage(
                                  alignment: Alignment.topCenter,
                                  height: 70,
                                  fit: BoxFit.fitWidth,
                                  imageUrl: '',
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Image.asset(
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
                        _buildAvatar(avatarRadius, Colors.yellow),
                        _buildAvatar(avatarRadius, Colors.red),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
