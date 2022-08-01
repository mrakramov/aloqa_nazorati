import 'dart:convert';

UserDataResponse userDataResponseFromJson(String str) =>
    UserDataResponse.fromJson(json.decode(str));

String userDataResponseToJson(UserDataResponse data) =>
    json.encode(data.toJson());

class UserDataResponse {
  UserDataResponse({
    required this.status,
    required this.data,
    required this.token,
    required this.message,
  });

  String status;
  Data data;
  String token;
  String message;

  UserDataResponse copyWith({
    required String status,
    required Data data,
    required String token,
    required String message,
  }) =>
      UserDataResponse(
        status: status,
        data: data,
        token: token,
        message: message,
      );

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      UserDataResponse(
        status: json["status"],
        data: json["data"] = Data.fromJson(json["data"]),
        token: json["token"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data = data.toJson() as Data,
        "token": token,
        "message": message,
      };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.code,
    required this.codeVerifiedAt,
    required this.isVerified,
    this.deletedAt,
    this.photo,
    required this.birthDate,
    required this.citizen,
    required this.address,
    required this.mobPhoneNo,
    required this.birthPlace,
    required this.midName,
    required this.userType,
    required this.sessId,
    required this.retCd,
    required this.isOneId,
    required this.oneIdCode,
  });

  int id;
  String name;
  String email;
  DateTime emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String firstName;
  String lastName;
  dynamic phone;
  dynamic code;
  DateTime codeVerifiedAt;
  bool isVerified;
  dynamic deletedAt;
  dynamic photo;
  DateTime birthDate;
  String citizen;
  String address;
  String mobPhoneNo;
  String birthPlace;
  String midName;
  String userType;
  String sessId;
  String retCd;
  bool isOneId;
  String oneIdCode;

  Data copyWith({
    int? id,
    String? name,
    String? email,
    DateTime? emailVerifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? firstName,
    String? lastName,
    dynamic phone,
    dynamic code,
    DateTime? codeVerifiedAt,
    bool? isVerified,
    dynamic deletedAt,
    dynamic photo,
    DateTime? birthDate,
    String? citizen,
    String? address,
    String? mobPhoneNo,
    String? birthPlace,
    String? midName,
    String? userType,
    String? sessId,
    String? retCd,
    bool? isOneId,
    String? oneIdCode,
  }) =>
      Data(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        code: code ?? this.code,
        codeVerifiedAt: codeVerifiedAt ?? this.codeVerifiedAt,
        isVerified: isVerified ?? this.isVerified,
        deletedAt: deletedAt ?? this.deletedAt,
        photo: photo ?? this.photo,
        birthDate: birthDate ?? this.birthDate,
        citizen: citizen ?? this.citizen,
        address: address ?? this.address,
        mobPhoneNo: mobPhoneNo ?? this.mobPhoneNo,
        birthPlace: birthPlace ?? this.birthPlace,
        midName: midName ?? this.midName,
        userType: userType ?? this.userType,
        sessId: sessId ?? this.sessId,
        retCd: retCd ?? this.retCd,
        isOneId: isOneId ?? this.isOneId,
        oneIdCode: oneIdCode ?? this.oneIdCode,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] =
            DateTime.parse(json["email_verified_at"]),
        createdAt: json["created_at"] = DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] = DateTime.parse(json["updated_at"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        code: json["code"],
        codeVerifiedAt: json["code_verified_at"] =
            DateTime.parse(json["code_verified_at"]),
        isVerified: json["is_verified"],
        deletedAt: json["deleted_at"],
        photo: json["photo"],
        birthDate: json["birth_date"] = DateTime.parse(json["birth_date"]),
        citizen: json["citizen"],
        address: json["address"],
        mobPhoneNo: json["mob_phone_no"],
        birthPlace: json["birth_place"],
        midName: json["mid_name"],
        userType: json["user_type"],
        sessId: json["sess_id"],
        retCd: json["ret_cd"],
        isOneId: json["is_one_id"],
        oneIdCode: json["one_id_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at":
            emailVerifiedAt == null ? null : emailVerifiedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "code": code,
        "code_verified_at":
            codeVerifiedAt == null ? null : codeVerifiedAt.toIso8601String(),
        "is_verified": isVerified,
        "deleted_at": deletedAt,
        "photo": photo,
        "birth_date": birthDate == null
            ? null
            : "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "citizen": citizen,
        "address": address,
        "mob_phone_no": mobPhoneNo,
        "birth_place": birthPlace,
        "mid_name": midName,
        "user_type": userType,
        "sess_id": sessId,
        "ret_cd": retCd,
        "is_one_id": isOneId,
        "one_id_code": oneIdCode,
      };
}
