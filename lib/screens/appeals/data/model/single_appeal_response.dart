import 'dart:convert';

import 'package:aloqa_nazorati/screens/appeals/data/model/AppealResponse.dart';

AppealCreateResponse appealResponseFromJson(String str) =>
    AppealCreateResponse.fromJson(json.decode(str));

String appealResponseToJson(AppealCreateResponse data) =>
    json.encode(data.toJson());

class AppealCreateResponse {
  AppealCreateResponse(
      {required this.status,
      required this.code,
      required this.data,
      required this.files});

  String status;
  String code;
  DatumCreate data;
  bool? files;

  AppealCreateResponse copyWith(
          {String? status, String? code, DatumCreate? data, bool? files}) =>
      AppealCreateResponse(
        status: status ?? this.status,
        code: code ?? this.code,
        data: data ?? this.data,
        files: files ?? this.files,
      );

  factory AppealCreateResponse.fromJson(Map<String, dynamic> json) =>
      AppealCreateResponse(
          status: json["status"],
          code: json["code"],
          data: DatumCreate.fromJson(json["data"]),
          files: json['files']);

  Map<String, dynamic> toJson() =>
      {"status": status, "code": code, "data": data.toJson(), 'files': files};
}

class DatumCreate {
  DatumCreate({
    required this.id,
    required this.code,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.phone,
    required this.userType,
    required this.source,
    required this.description,
    required this.ticketRegionId,
    required this.ticketDistrictId,
    required this.referenceParentId,
    required this.referenceId,
    required this.isSend,
    required this.sentAt,
    required this.createdAt,
    required this.updatedAt,
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

  int? id;
  String? code;
  String? firstName;
  String? lastName;
  String? address;
  String? phone;
  String? userType;
  String? source;
  String? description;
  int? ticketRegionId;
  int? ticketDistrictId;
  int? referenceParentId;
  int? referenceId;
  bool? isSend;
  DateTime? sentAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? letterId;
  dynamic file;
  dynamic extraCode;
  int? userId;
  String? status;
  Reference? ticketRegion;
  Reference? ticketDistrict;
  ResponseLetter? responseLetter;
  Reference? referenceParent;
  Reference? reference;

  DatumCreate copyWith({
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
      DatumCreate(
        id: id ?? this.id,
        code: code ?? this.code,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        userType: userType ?? this.userType,
        source: source ?? this.source,
        description: description ?? this.description,
        ticketRegionId: ticketRegionId ?? this.ticketRegionId,
        ticketDistrictId: ticketDistrictId ?? this.ticketDistrictId,
        referenceParentId: referenceParentId ?? this.referenceParentId,
        referenceId: referenceId ?? this.referenceId,
        isSend: isSend ?? this.isSend,
        sentAt: sentAt ?? this.sentAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
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

  factory DatumCreate.fromJson(Map<String, dynamic> json) => DatumCreate(
        id: json["id"],
        code: json["code"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        address: json["address"],
        phone: json["phone"],
        userType: json["user_type"],
        source: json["source"],
        description: json["description"],
        ticketRegionId: json["ticket_region_id"],
        ticketDistrictId: json["ticket_district_id"],
        referenceParentId: json["reference_parent_id"],
        referenceId: json["reference_id"],
        isSend: json["is_send"],
        sentAt: json["sent_at"] = DateTime.parse(json["sent_at"]),
        createdAt: json["created_at"] = DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] = DateTime.parse(json["updated_at"]),
        letterId: json["letter_id"],
        file: json["files"],
        extraCode: json["extra_code"],
        userId: json["user_id"],
        status: json["status"],
        ticketRegion: json["ticket_region"] =
            Reference.fromJson(json["ticket_region"]),
        ticketDistrict: json["ticket_district"] =
            Reference.fromJson(json["ticket_district"]),
        responseLetter: json["response_letter"] =
            ResponseLetter.fromJson(json["response_letter"]),
        referenceParent: json["reference_parent"] =
            Reference.fromJson(json["reference_parent"]),
        reference: json["reference"] = Reference.fromJson(json["reference"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "first_name": firstName,
        "last_name": lastName,
        "address": address,
        "phone": phone,
        "user_type": userType,
        "source": source,
        "description": description,
        "ticket_region_id": ticketRegionId,
        "ticket_district_id": ticketDistrictId,
        "reference_parent_id": referenceParentId,
        "reference_id": referenceId,
        "is_send": isSend,
        "sent_at": sentAt == null ? null : sentAt!.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "letter_id": letterId,
        "files": file,
        "extra_code": extraCode,
        "user_id": userId,
        "status": status,
        "ticket_region": ticketRegion == null ? null : ticketRegion!.toJson(),
        "ticket_district":
            ticketDistrict == null ? null : ticketDistrict!.toJson(),
        "response_letter":
            responseLetter == null ? null : responseLetter!.toJson(),
        "reference_parent":
            referenceParent == null ? null : referenceParent!.toJson(),
        "reference": reference == null ? null : reference!.toJson(),
      };
}
