import 'package:redux_example/src/services/models/Member.dart';
import 'package:redux_example/src/services/sqlLite/dboMember.dart';

Future<void> dispatchContact(List<dynamic> json){
  print('dispatchContact');
  for (final value in json )
    {
      //print('value $json');
      insertItem(Member(
        employeeId: value['employeeId'],
        employeeCode: value['employeeCode'],
        shortName: value["shortName"],
        email: value["email"],
        skype: value["skype"],
        userName: value["userName"],
        currentOfficeFullName: value["currentOfficeFullName"],
        currentOffice: value["currentOffice"],
        empVietnameseName: value["empVietnameseName"],
        titleName: value["titleName"],
        employeePicUrl: value["employeePicUrl"],
        fullName: value["fullName"],
      ));
    }

}