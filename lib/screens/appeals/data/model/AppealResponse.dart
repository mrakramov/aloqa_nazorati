import 'dart:convert';

AppealResponse appealResponseFromJson(String str) =>
    AppealResponse.fromJson(json.decode(str));

String appealResponseToJson(AppealResponse data) => json.encode(data.toJson());

class AppealResponse {
  AppealResponse({
    required this.status,
    required this.code,
    required this.data,
  });

  String status;
  String code;
  List<Datum> data;

  AppealResponse copyWith({
    String? status,
    String? code,
    List<Datum>? data,
  }) =>
      AppealResponse(
        status: status ?? this.status,
        code: code ?? this.code,
        data: data ?? this.data,
      );

  factory AppealResponse.fromJson(Map<String, dynamic> json) => AppealResponse(
        status: json["status"],
        code: json["code"],
        data: json["data"] =
            List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": data = List<Datum>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.code,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.address,
    required this.phone,
    required this.userType,
    required this.source,
    required this.description,
    required this.ticketRegionId,
    required this.ticketDistrictId,
    required this.referenceParentId,
    required this.referenceId,
    required this.subjectParentId,
    required this.subjectId,
    required this.senderId,
    required this.receiverId,
    required this.isSend,
    required this.sentAt,
    required this.createdAt,
    required this.updatedAt,
    required this.extraPhone,
    required this.deletedAt,
    required this.email,
    required this.letterId,
    required this.file,
    required this.extraCode,
    required this.userId,
    required this.status,
    required this.ticketRegion,
    required this.ticketDistrict,
    required this.responseLetter,
    required this.referenceParent,
    required this.reference,
  });

  int id;
  String code;
  String firstName;
  String lastName;
  dynamic middleName;
  String address;
  String phone;
  String userType;
  String source;
  String description;
  int ticketRegionId;
  int ticketDistrictId;
  int referenceParentId;
  int referenceId;
  dynamic subjectParentId;
  dynamic subjectId;
  dynamic senderId;
  dynamic receiverId;
  bool isSend;
  DateTime sentAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic extraPhone;
  dynamic deletedAt;
  dynamic email;
  int letterId;
  dynamic file;
  dynamic extraCode;
  int userId;
  String status;
  Reference ticketRegion;
  Reference ticketDistrict;
  ResponseLetter responseLetter;
  Reference referenceParent;
  Reference reference;

  Datum copyWith({
    int? id,
    String? code,
    String? firstName,
    String? lastName,
    dynamic middleName,
    String? address,
    String? phone,
    String? userType,
    String? source,
    String? description,
    int? ticketRegionId,
    int? ticketDistrictId,
    int? referenceParentId,
    int? referenceId,
    dynamic subjectParentId,
    dynamic subjectId,
    dynamic senderId,
    dynamic receiverId,
    bool? isSend,
    DateTime? sentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic extraPhone,
    dynamic deletedAt,
    dynamic email,
    int? letterId,
    dynamic file,
    dynamic extraCode,
    int? userId,
    String? status,
    Reference? ticketRegion,
    Reference? ticketDistrict,
    ResponseLetter? responseLetter,
    Reference? referenceParent,
    Reference? reference,
  }) =>
      Datum(
        id: id ?? this.id,
        code: code ?? this.code,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        middleName: middleName ?? this.middleName,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        userType: userType ?? this.userType,
        source: source ?? this.source,
        description: description ?? this.description,
        ticketRegionId: ticketRegionId ?? this.ticketRegionId,
        ticketDistrictId: ticketDistrictId ?? this.ticketDistrictId,
        referenceParentId: referenceParentId ?? this.referenceParentId,
        referenceId: referenceId ?? this.referenceId,
        subjectParentId: subjectParentId ?? this.subjectParentId,
        subjectId: subjectId ?? this.subjectId,
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        isSend: isSend ?? this.isSend,
        sentAt: sentAt ?? this.sentAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        extraPhone: extraPhone ?? this.extraPhone,
        deletedAt: deletedAt ?? this.deletedAt,
        email: email ?? this.email,
        letterId: letterId ?? this.letterId,
        file: file ?? this.file,
        extraCode: extraCode ?? this.extraCode,
        userId: userId ?? this.userId,
        status: status ?? this.status,
        ticketRegion: ticketRegion ?? this.ticketRegion,
        ticketDistrict: ticketDistrict ?? this.ticketDistrict,
        responseLetter: responseLetter ?? this.responseLetter,
        referenceParent: referenceParent ?? this.referenceParent,
        reference: reference ?? this.reference,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        code: json["code"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
        address: json["address"],
        phone: json["phone"],
        userType: json["user_type"],
        source: json["source"],
        description: json["description"],
        ticketRegionId: json["ticket_region_id"],
        ticketDistrictId: json["ticket_district_id"],
        referenceParentId: json["reference_parent_id"],
        referenceId: json["reference_id"],
        subjectParentId: json["subject_parent_id"],
        subjectId: json["subject_id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        isSend: json["is_send"],
        sentAt:
            json["sent_at"] = DateTime.parse(json["sent_at"]),
        createdAt: json["created_at"] = DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] = DateTime.parse(json["updated_at"]),
        extraPhone: json["extra_phone"],
        deletedAt: json["deleted_at"],
        email: json["email"],
        letterId: json["letter_id"],
        file: json["file"],
        extraCode: json["extra_code"],
        userId: json["user_id"],
        status: json["status"],
        ticketRegion: json["ticket_region"] = Reference.fromJson(json["ticket_region"]),
        ticketDistrict: json["ticket_district"] = Reference.fromJson(json["ticket_district"]),
        responseLetter: json["response_letter"] = ResponseLetter.fromJson(json["response_letter"]),
        referenceParent: json["reference_parent"] = Reference.fromJson(json["reference_parent"]),
        reference: json["reference"] = Reference.fromJson(json["reference"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "address": address,
        "phone": phone,
        "user_type": userType,
        "source": source,
        "description": description,
        "ticket_region_id": ticketRegionId,
        "ticket_district_id": ticketDistrictId,
        "reference_parent_id": referenceParentId,
        "reference_id": referenceId,
        "subject_parent_id": subjectParentId,
        "subject_id": subjectId,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "is_send": isSend,
        "sent_at": sentAt == null ? null : sentAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "extra_phone": extraPhone,
        "deleted_at": deletedAt,
        "email": email,
        "letter_id": letterId,
        "file": file,
        "extra_code": extraCode,
        "user_id": userId,
        "status": status,
        "ticket_region": ticketRegion == null ? null : ticketRegion.toJson(),
        "ticket_district":
            ticketDistrict == null ? null : ticketDistrict.toJson(),
        "response_letter":
            responseLetter == null ? null : responseLetter.toJson(),
        "reference_parent":
            referenceParent == null ? null : referenceParent.toJson(),
        "reference": reference == null ? null : reference.toJson(),
      };
}

class Reference {
  Reference({
    required this.id,
    required this.name,
  });

  int id;
  ReferenceName name;

  Reference copyWith({
    int? id,
    ReferenceName? name,
  }) =>
      Reference(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Reference.fromJson(Map<String, dynamic> json) => Reference(
        id: json["id"],
        name:
            json["name"] = ReferenceName.fromJson(json["name"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name == null ? null : name.toJson(),
      };
}

class ReferenceName {
  ReferenceName({
    required this.oz,
    required this.uz,
    required this.ru,
    required this.en,
  });

  String oz;
  String uz;
  String ru;
  String en;

  ReferenceName copyWith({
    String? oz,
    String? uz,
    String? ru,
    String? en,
  }) =>
      ReferenceName(
        oz: oz ?? this.oz,
        uz: uz ?? this.uz,
        ru: ru ?? this.ru,
        en: en ?? this.en,
      );

  factory ReferenceName.fromJson(Map<String, dynamic> json) => ReferenceName(
        oz: json["oz"],
        uz: json["uz"],
        ru: json["ru"],
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "oz": oz,
        "uz": uz,
        "ru": ru,
        "en": en,
      };
}

class
ResponseLetter {
  ResponseLetter({
    required this.id,
    required this.name,
  });

  int id;
  ResponseLetterName name;

  ResponseLetter copyWith({
    int? id,
    ResponseLetterName? name,
  }) =>
      ResponseLetter(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory ResponseLetter.fromJson(Map<String, dynamic> json) => ResponseLetter(
        id: json["id"],
        name: json["name"] = ResponseLetterName.fromJson(json["name"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name == null ? null : name.toJson(),
      };
}

class ResponseLetterName {
  ResponseLetterName({
    required this.oz,
    required this.uz,
  });

  String oz;
  String uz;

  ResponseLetterName copyWith({
    String? oz,
    String? uz,
  }) =>
      ResponseLetterName(
        oz: oz ?? this.oz,
        uz: uz ?? this.uz,
      );

  factory ResponseLetterName.fromJson(Map<String, dynamic> json) =>
      ResponseLetterName(
        oz: json["oz"],
        uz: json["uz"],
      );

  Map<String, dynamic> toJson() => {
        "oz": oz,
        "uz": uz,
      };
}
