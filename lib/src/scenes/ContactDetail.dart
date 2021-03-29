import 'package:cached_network_image/cached_network_image.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:redux_example/src/Components/CustomChooseGroup.dart';
import 'package:redux_example/src/models/Member.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

/// This is the stateful widget that the main application instantiates.
class ContactDetail extends StatelessWidget {
  ContactDetail({Key key, @required this.employeeData}) : super(key: key);

  //final Map<String, dynamic> employeeData;
  final Member employeeData;

  checkPermission() async {
    var status = await Permission.contacts.request();
    if (status.isGranted) {
      // Either the permission was already granted before or the user just granted it.

      // Contact newContact = new Contact(
      //     company: 'KMS Technology, Inc',
      //     emails:[
      //       Item.fromMap(
      //           {'label': 'emails', 'value': employeeData.email})
      //     ],
      //     displayName: employeeData['shortName'],
      //     jobTitle: employeeData['titleName'],
      //     phones: [
      //       Item.fromMap(
      //           {'label': 'phones', 'value': employeeData['mobilePhone']})
      //     ]);
      //
      //
      // await ContactsService.addContact(newContact);
      //
       await ContactsService.openContactForm();
    } else {
      print('not granted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(employeeData.shortName),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(90),
                              child: CachedNetworkImage(
                                height: 100,
                                alignment: Alignment.topCenter,
                                fit: BoxFit.fitWidth,
                                imageUrl: employeeData.employeePicUrl,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Image.asset(
                                    'lib/src/assets/Image/avatarDefault.png'),
                              )
                              ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                employeeData.fullName,
                                style: TextStyle(fontSize: 16.0),
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                              ),
                              Text(
                                employeeData.titleName,
                                overflow: TextOverflow.clip,
                              ),
                              Text(
                                employeeData.employeeCode,
                                overflow: TextOverflow.clip,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Phone',
                              style: TextStyle(
                                fontSize: 16,
                              )),
                          Text(employeeData.mobilePhone,
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50.0,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FloatingActionButton(
                                      heroTag: employeeData.employeeId.toString(),
                                      tooltip: 'Message',
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.black,
                                      elevation: 0,
                                      onPressed: () => launch(
                                          'sms:${employeeData.mobilePhone}'),
                                      child: Icon(Icons.message)),
                                )),
                          ),
                          SizedBox(
                            width: 50.0,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FloatingActionButton(
                                      heroTag: employeeData.employeeCode,
                                      tooltip: 'Call',
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.black,
                                      elevation: 0,
                                      onPressed: () => launch(
                                          'tel:${employeeData.mobilePhone}'),
                                      child: Icon(Icons.phone)),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                child: RawMaterialButton(
                  splashColor: Colors.grey,
                  //shape: const StadiumBorder(),
                  onPressed: () => launch('mailto:${employeeData.email}'),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email',
                              style: TextStyle(
                                fontSize: 16,
                              )),
                          Text(employeeData.email,
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                child: RawMaterialButton(
                  splashColor: Colors.grey,
                  //shape: const StadiumBorder(),
                  onPressed: () async {
                    if (await canLaunch('skype:${employeeData.skype}?chat')) {
                      await launch(
                        'skype:${employeeData.skype}?chat',
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Skype',
                              style: TextStyle(
                                fontSize: 16,
                              )),
                          Text(employeeData.skype,
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location',
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        Text(employeeData.currentOfficeFullName,
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                child: RawMaterialButton(
                  splashColor: Colors.grey,
                  //shape: const StadiumBorder(),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text('Share Contact',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                          )),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                child: RawMaterialButton(
                  splashColor: Colors.grey,
                  //shape: const StadiumBorder(),
                  onPressed: () {
                    checkPermission();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text('Add Phone Contact',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                          )),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                child: RawMaterialButton(
                  splashColor: Colors.grey,
                  //shape: const StadiumBorder(),
                  onPressed: () {
                    customChooseGroup(context, employeeData);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text('Groups',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                          )),
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
