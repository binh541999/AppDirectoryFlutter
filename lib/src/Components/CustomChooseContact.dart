import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/models/GroupMember.dart';
import 'package:redux_example/src/models/Groups.dart';
import 'package:redux_example/src/providers/GroupMemberModel.dart';
import 'package:redux_example/src/scenes/ContactDetail.dart';
import 'package:redux_example/src/models/Member.dart';
import 'package:redux_example/src/scenes/Group.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomChooseContact extends StatefulWidget {
  CustomChooseContact({
    Key key,
    @required this.employeeData,
    @required this.idCurrentGroup,
  }) : super(key: key);

  final Member employeeData;
  final int idCurrentGroup;

  @override
  _CustomChooseContact createState() => _CustomChooseContact();
}

class _CustomChooseContact extends State<CustomChooseContact> {
  String imageUrl = '';
  bool _isSelected = false;

  void checkChecked() {
    var members =  Provider.of<GroupMemberModel>(context, listen: false).currentGroupMembers;
    var index = members.indexWhere(
            (element) => element.idMember == widget.employeeData.employeeId);
    // var index = notes.indexWhere((element) =>
    // element == member.employeeId);
   if(index > -1 )
      _isSelected = true;

  }
  void initState() {
    // TODO: implement initState
    super.initState();
    checkChecked();

  }
  void _onPressContact() {
    setState(() {
      _isSelected = !_isSelected;
      print('select ted $_isSelected');
      if(_isSelected) {
        var newGroupMember = new GroupMember(
          idGroup:  widget.idCurrentGroup,
          idMember: widget.employeeData.employeeId
        );
        Provider.of<GroupMemberModel>(context, listen: false).addGroupMember(
            newGroupMember);
      }
      else {
        var newGroupMember = new GroupMember(
            idGroup:  widget.idCurrentGroup,
            idMember: widget.employeeData.employeeId
        );
        Provider.of<GroupMemberModel>(context, listen: false).deleteGroupMember(
            newGroupMember);
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
                    onPressed:() {
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
                                child: Checkbox(
                                  value: _isSelected,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _isSelected = newValue;
                                    });
                                  },
                                )),
                          ),
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
