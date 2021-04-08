import 'package:tiny_kms_directory/src/models/GroupMember.dart';
import 'package:tiny_kms_directory/src/models/Groups.dart';
import 'package:tiny_kms_directory/src/models/Member.dart';
import 'package:tiny_kms_directory/src/services/sqlLite/dboGroup.dart';
import 'package:tiny_kms_directory/src/services/sqlLite/dboGroupMember.dart';
import 'package:tiny_kms_directory/src/services/sqlLite/dboMember.dart';

void dispatchContact(List<dynamic> json) {
  try {
    if (json != null) {
      for (final value in json) {
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
      }

    }
  } catch (error) {
    print('fetch data Failed $error');
  }
}

void dispatchGroup(List<dynamic> json) {
  try {
    if (json != null) {
      for (final value in json) {
        var group = new Groups(
          id: value['group_id'],
          name: value['group_name'],
        );
        insertItemGroup(group);
      }
    }
  } catch (error) {
    print('fetch data group Failed $error');
  }
}

void dispatchGroupMember(Map<String, dynamic> json) {
  try {
    if (json != null) {
      for (final member in json['members']) {
        var groupMember = new GroupMember(
            idGroup: json['group_id'], userName: member['username']);
        insertItemGroupMember(groupMember);
      }
    }
  } catch (error) {
    print('fetch data group member Failed $error');
  }
}
