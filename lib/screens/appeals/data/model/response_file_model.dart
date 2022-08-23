class ResponseFileModel {
  String? status;
  String? code;
  Data? data;

  ResponseFileModel({this.status, this.code, this.data});

  ResponseFileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  dynamic phone;
  dynamic code;
  String? codeVerifiedAt;
  bool? isVerified;
  String? deletedAt;
  String? photo;
  String? birthDate;
  String? citizen;
  String? address;
  String? mobPhoneNo;
  String? birthPlace;
  String? midName;
  String? userType;
  String? sessId;
  String? retCd;
  bool? isOneId;
  String? oneIdCode;

  Data(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.firstName,
      this.lastName,
      this.phone,
      this.code,
      this.codeVerifiedAt,
      this.isVerified,
      this.deletedAt,
      this.photo,
      this.birthDate,
      this.citizen,
      this.address,
      this.mobPhoneNo,
      this.birthPlace,
      this.midName,
      this.userType,
      this.sessId,
      this.retCd,
      this.isOneId,
      this.oneIdCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    code = json['code'];
    codeVerifiedAt = json['code_verified_at'];
    isVerified = json['is_verified'];
    deletedAt = json['deleted_at'];
    photo = json['photo'];
    birthDate = json['birth_date'];
    citizen = json['citizen'];
    address = json['address'];
    mobPhoneNo = json['mob_phone_no'];
    birthPlace = json['birth_place'];
    midName = json['mid_name'];
    userType = json['user_type'];
    sessId = json['sess_id'];
    retCd = json['ret_cd'];
    isOneId = json['is_one_id'];
    oneIdCode = json['one_id_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['code'] = code;
    data['code_verified_at'] = codeVerifiedAt;
    data['is_verified'] = isVerified;
    data['deleted_at'] = deletedAt;
    data['photo'] = photo;
    data['birth_date'] = birthDate;
    data['citizen'] = citizen;
    data['address'] = address;
    data['mob_phone_no'] = mobPhoneNo;
    data['birth_place'] = birthPlace;
    data['mid_name'] = midName;
    data['user_type'] = userType;
    data['sess_id'] = sessId;
    data['ret_cd'] = retCd;
    data['is_one_id'] = isOneId;
    data['one_id_code'] = oneIdCode;
    return data;
  }
}
