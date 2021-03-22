import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux_example/src/scenes/ContactDetail.dart';
import 'package:redux_example/src/models/Member.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomContact extends StatefulWidget {
  CustomContact({
    Key key,
    @required this.employeeData,
  }) : super(key: key);


  final Member employeeData;

  @override
  _CustomContact createState() => _CustomContact();
}

class _CustomContact extends State<CustomContact> {
  String imageUrl = '';

  // void checkURL() async{
  //   if (await canLaunch(widget.employeeData['employeePicUrl']))
  //   {
  //     print('can access');
  //     imageUrl = widget.employeeData['employeePicUrl'];
  //   }
  // }
  //
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   checkURL();
  // }
  void _onPressContact() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ContactDetail(employeeData: widget.employeeData),
        ));
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
                    onPressed: _onPressContact,
                    child: Row(children: <Widget>[
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
                    ])),
              ),
              SizedBox(
                width: 50.0,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                          // heroTag: widget.employeeData.mobilePhone,
                          // tooltip: 'Call',
                          // backgroundColor: Colors.transparent,
                          // foregroundColor: Colors.black,
                          // elevation: 0,
                        icon: Icon(Icons.phone),
                          onPressed: () =>
                              launch('tel:${widget.employeeData.mobilePhone}'),
                          //child: Icon(Icons.phone)),
                    ),
                    ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
