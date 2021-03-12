
class Member {
  int employeeId;
  String employeeCode;
  String shortName;
  String email;
  String skype;
  String mobilePhone;
  String userName;
  String currentOffice;
  String currentOfficeFullName;
  String empVietnameseName;
  String titleName;
  String employeePicUrl;
  String fullName;

  Member({
    this.employeeId,
    this.employeeCode,
    this.shortName,
    this.email,
    this.skype,
    this.mobilePhone,
    this.userName,
    this.currentOffice,
    this.currentOfficeFullName,
    this.empVietnameseName,
    this.titleName,
    this.employeePicUrl,
    this.fullName,
  });

  @override
  List<Object> get props => [employeeId, userName];
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>()
      ..["employeeId"] = employeeId
      ..["employeeCode"] = employeeCode
      ..["shortName"] = shortName
      ..["email"] = email
      ..["skype"] = skype
      ..["mobilePhone"] = mobilePhone
      ..["userName"] = userName
      ..["currentOfficeFullName"] = currentOfficeFullName
      ..["currentOffice"] = currentOffice
      ..["empVietnameseName"] = empVietnameseName
      ..["titleName"] = titleName
      ..["employeePicUrl"] = employeePicUrl
      ..["fullName"] = fullName
    ;
  }
  static Member formJson(Map<String, dynamic> json) {
    return Member()
      ..employeeId = json["employeeId"]
      ..employeeCode = json["employeeCode"]
      ..shortName = json["shortName"]
      ..email = json["email"]
      ..skype = json["skype"]
      ..mobilePhone = json["mobilePhone"]
      ..userName = json["userName"]
      ..currentOfficeFullName= json["currentOfficeFullName"]
      ..currentOffice = json["currentOffice"]
      ..empVietnameseName = json["empVietnameseName"]
      ..titleName = json["titleName"]
      ..employeePicUrl = json["employeePicUrl"]
      ..fullName = json["fullName"];
  }

}

