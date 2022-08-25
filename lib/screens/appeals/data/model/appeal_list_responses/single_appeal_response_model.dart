class SingleAppealResponseModel {
  String? status;
  String? code;
  Data? data;

  SingleAppealResponseModel({this.status, this.code, this.data});

  SingleAppealResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? code;
  String? firstName;
  String? lastName;
  dynamic middleName;
  String? address;
  String? phone;
  String? userType;
  String? source;
  String? description;
  int? ticketRegionId;
  int? ticketDistrictId;
  int? referenceParentId;
  int? referenceId;
  dynamic subjectParentId;
  dynamic subjectId;
  dynamic senderId;
  dynamic receiverId;
  bool? isSend;
  String? sentAt;
  String? createdAt;
  String? updatedAt;
  dynamic extraPhone;
  dynamic deletedAt;
  dynamic email;
  int? letterId;
  dynamic file;
  dynamic extraCode;
  int? userId;
  String? status;
  TicketRegion? ticketRegion;
  TicketRegion? ticketDistrict;
  TicketRegion? responseLetter;
  TicketRegion? referenceParent;
  TicketRegion? reference;
  List<UserFiles>? userFiles;

  Data(
      {this.id,
      this.code,
      this.firstName,
      this.lastName,
      this.middleName,
      this.address,
      this.phone,
      this.userType,
      this.source,
      this.description,
      this.ticketRegionId,
      this.ticketDistrictId,
      this.referenceParentId,
      this.referenceId,
      this.subjectParentId,
      this.subjectId,
      this.senderId,
      this.receiverId,
      this.isSend,
      this.sentAt,
      this.createdAt,
      this.updatedAt,
      this.extraPhone,
      this.deletedAt,
      this.email,
      this.letterId,
      this.file,
      this.extraCode,
      this.userId,
      this.status,
      this.ticketRegion,
      this.ticketDistrict,
      this.responseLetter,
      this.referenceParent,
      this.reference,
      this.userFiles});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    address = json['address'];
    phone = json['phone'];
    userType = json['user_type'];
    source = json['source'];
    description = json['description'];
    ticketRegionId = json['ticket_region_id'];
    ticketDistrictId = json['ticket_district_id'];
    referenceParentId = json['reference_parent_id'];
    referenceId = json['reference_id'];
    subjectParentId = json['subject_parent_id'];
    subjectId = json['subject_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    isSend = json['is_send'];
    sentAt = json['sent_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    extraPhone = json['extra_phone'];
    deletedAt = json['deleted_at'];
    email = json['email'];
    letterId = json['letter_id'];
    file = json['file'];
    extraCode = json['extra_code'];
    userId = json['user_id'];
    status = json['status'];
    ticketRegion = json['ticket_region'] != null
        ? TicketRegion.fromJson(json['ticket_region'])
        : null;
    ticketDistrict = json['ticket_district'] != null
        ? TicketRegion.fromJson(json['ticket_district'])
        : null;
    responseLetter = json['response_letter'] != null
        ? TicketRegion.fromJson(json['response_letter'])
        : null;
    referenceParent = json['reference_parent'] != null
        ? TicketRegion.fromJson(json['reference_parent'])
        : null;
    reference = json['reference'] != null
        ? TicketRegion.fromJson(json['reference'])
        : null;
    if (json['user_files'] != null) {
      userFiles = <UserFiles>[];
      json['user_files'].forEach((v) {
        userFiles!.add(UserFiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['middle_name'] = middleName;
    data['address'] = address;
    data['phone'] = phone;
    data['user_type'] = userType;
    data['source'] = source;
    data['description'] = description;
    data['ticket_region_id'] = ticketRegionId;
    data['ticket_district_id'] = ticketDistrictId;
    data['reference_parent_id'] = referenceParentId;
    data['reference_id'] = referenceId;
    data['subject_parent_id'] = subjectParentId;
    data['subject_id'] = subjectId;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['is_send'] = isSend;
    data['sent_at'] = sentAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['extra_phone'] = extraPhone;
    data['deleted_at'] = deletedAt;
    data['email'] = email;
    data['letter_id'] = letterId;
    data['file'] = file;
    data['extra_code'] = extraCode;
    data['user_id'] = userId;
    data['status'] = status;
    if (ticketRegion != null) {
      data['ticket_region'] = ticketRegion!.toJson();
    }
    if (ticketDistrict != null) {
      data['ticket_district'] = ticketDistrict!.toJson();
    }
    if (responseLetter != null) {
      data['response_letter'] = responseLetter!.toJson();
    }
    if (referenceParent != null) {
      data['reference_parent'] = referenceParent!.toJson();
    }
    if (reference != null) {
      data['reference'] = reference!.toJson();
    }
    if (userFiles != null) {
      data['user_files'] = userFiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketRegion {
  int? id;
  Name? name;

  TicketRegion({this.id, this.name});

  TicketRegion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    return data;
  }
}

class Name {
  String? oz;
  String? uz;
  String? ru;

  Name({this.oz, this.uz, this.ru});

  Name.fromJson(Map<String, dynamic> json) {
    oz = json['oz'];
    uz = json['uz'];
    ru = json['ru'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oz'] = oz;
    data['uz'] = uz;
    data['ru'] = ru;
    return data;
  }
}

class UserFiles {
  int? id;
  int? userId;
  int? extraTicketId;
  dynamic ticketId;
  String? file;
  String? fileName;
  String? fileExtension;
  String? filePath;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  UserFiles(
      {this.id,
      this.userId,
      this.extraTicketId,
      this.ticketId,
      this.file,
      this.fileName,
      this.fileExtension,
      this.filePath,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  UserFiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    extraTicketId = json['extra_ticket_id'];
    ticketId = json['ticket_id'];
    file = json['file'];
    fileName = json['file_name'];
    fileExtension = json['file_extension'];
    filePath = json['file_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['extra_ticket_id'] = extraTicketId;
    data['ticket_id'] = ticketId;
    data['file'] = file;
    data['file_name'] = fileName;
    data['file_extension'] = fileExtension;
    data['file_path'] = filePath;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
