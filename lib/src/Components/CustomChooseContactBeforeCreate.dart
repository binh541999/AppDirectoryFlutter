import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/models/GroupMember.dart';
import 'package:redux_example/src/models/Groups.dart';
import 'package:redux_example/src/providers/GroupMemberModel.dart';
import 'package:redux_example/src/providers/MemberModel.dart';
import 'package:redux_example/src/scenes/ContactDetail.dart';
import 'package:redux_example/src/models/Member.dart';
import 'package:redux_example/src/scenes/Group.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomChooseContactBeforeCreateGroup extends StatefulWidget {
  CustomChooseContactBeforeCreateGroup({
    Key key,
    @required this.employeeData,
  }) : super(key: key);

  final Member employeeData;

  @override
  _CustomChooseContact createState() => _CustomChooseContact();
}

class _CustomChooseContact extends State<CustomChooseContactBeforeCreateGroup> {
  String imageUrl = '';
  bool _isSelected = false;

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onPressContact() {
    setState(() {
      _isSelected = !_isSelected;
      if (_isSelected) {
        Provider.of<MemberModel>(context, listen: false)
            .addTempMember(widget.employeeData);
      } else {
        Provider.of<MemberModel>(context, listen: false)
            .removeTempMember(widget.employeeData);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RawMaterialButton(
                    splashColor: Colors.grey,
                    onPressed: () {
                      _onPressContact();
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 60,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                height: 70,
                                alignment: Alignment.topCenter,
                                fit: BoxFit.fitWidth,
                                imageUrl: widget.employeeData.employeePicUrl,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Image.asset(
                                    'lib/src/assets/Image/avatarDefault.png'),
                              )),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                widget.employeeData.shortName,
                                style: TextStyle(fontSize: 16.0),
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                              ),
                              Text(
                                widget.employeeData.titleName,
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 50.0,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Consumer<MemberModel>(
                                    builder: (context, membersData, child) {
                                  var isSelected = false;
                                  var temp = membersData.tempMembers.indexWhere(
                                      (element) =>
                                          element.employeeId ==
                                          widget.employeeData.employeeId);
                                  if (temp > -1) {
                                    print(temp);
                                    isSelected = true;
                                  }
                                  return Checkbox(
                                    value: isSelected,
                                    onChanged: (newValue) {
                                      print(isSelected);
                                    },
                                  );
                                }),
                              )),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
