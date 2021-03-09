import 'package:flutter/material.dart';
import 'package:redux_example/src/Components/CustomContact.dart';



class Contact extends StatelessWidget {
  @override
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContact(
        shortName:'Test Name',
        titleName: 'Test titleName',
        picURL:'https://hr.kms-technology.com/api/employees/photo/600?code=WWlMYMQAzAC4VlscblYs3YsoAT0xvymkddOQyyA4Pdz4',
      )
    );
  }
}

