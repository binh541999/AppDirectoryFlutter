import 'dart:async';
import 'package:redux_example/src/models/Groups.dart';
import 'package:redux_example/src/models/Member.dart';
import 'package:redux_example/src/services/sqlLite/dboGroup.dart';
import 'package:redux_example/src/services/sqlLite/dboMember.dart';

Future<void> dispatchContact(List<dynamic> json){
  try{
    print('dispatchContact');
    if(json !=  null) {
      for (final value in json )
      {
        //print('value $json');
        var member = new Member(
          employeeId: value['employeeId'],
          employeeCode: value['employeeCode'],
          shortName: value["shortName"],
          email: value["email"],
          skype: value["skype"],
          mobilePhone: value["mobilePhone"],
          userName: value["userName"],
          currentOfficeFullName: value["currentOfficeFullName"],
          currentOffice: value["currentOffice"],
          empVietnameseName: value["empVietnameseName"],
          titleName: value["titleName"],
          employeePicUrl: value["employeePicUrl"],
          fullName: value["fullName"],
        );
        insertItemMember(member);
      };


    }
  }
  catch (error) {
    print('fetch data Failed $error');

  }



}