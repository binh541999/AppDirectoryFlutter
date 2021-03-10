import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// This is the stateful widget that the main application instantiates.
class ContactDetail extends StatelessWidget {
  ContactDetail({Key key, @required this.employeeData}) : super(key: key);
  final Map<String, dynamic> employeeData;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(employeeData['shortName']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.green,
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: Image.network(
                            employeeData['employeePicUrl'],
                            height: 100,
                            alignment: Alignment.topCenter,
                            fit: BoxFit.fitWidth,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace stackTrace) {
                              return Image.asset(
                                  'lib/src/assets/Image/avatarDefault.png');
                            },
                          ),
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
                              employeeData['fullName'],
                              style: TextStyle(fontSize: 16.0),
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                            ),
                            Text(
                              employeeData['titleName'],
                              overflow: TextOverflow.clip,
                            ),
                            Text(
                              employeeData['employeeCode'],
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
              Container(
                color: Colors.amber,
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
                        Text(employeeData['mobilePhone'],
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
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.message)),
                              )),
                        ),
                        SizedBox(
                          width: 50.0,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: IconButton(
                                    tooltip: 'Call',
                                    onPressed: ()=> launch('tel:${employeeData['mobilePhone']}'),
                                    icon: Icon(Icons.phone)),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                child: RawMaterialButton(
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
                        Text(employeeData['email'],
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
                        Text(employeeData['skype'],
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
                color: Colors.amber,
                child: RawMaterialButton(
                  onPressed: () {},
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
                        Text(employeeData['currentOfficeFullName'],
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
                color: Colors.amber,
                child: RawMaterialButton(
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
              Container(
                height: 60,
                color: Colors.amber,
                child: RawMaterialButton(
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
              Container(
                height: 60,
                color: Colors.amber,
                child: RawMaterialButton(
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
            ],
          ),
        ),
      ),
    );
  }
}
