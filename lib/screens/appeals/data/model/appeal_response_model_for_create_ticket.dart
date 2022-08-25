class AppealResponseModelForCreateTicket {
  String? status;
  String? code;
  Data? data;
  bool? files;

  AppealResponseModelForCreateTicket(
      {this.status, this.code, this.data, this.files});

  AppealResponseModelForCreateTicket.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    files = json['files'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['files'] = files;
    return data;
  }
}

class Data {
  bool? isSend;
  String? firstName;
  String? lastName;
  String? address;
  String? description;
  String? phone;
  int? ticketRegionId;
  int? ticketDistrictId;
  int? referenceId;
  int? referenceParentId;
  int? letterId;
  String? code;
  String? userType;
  String? source;
  String? sentAt;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.isSend,
      this.firstName,
      this.lastName,
      this.address,
      this.description,
      this.phone,
      this.ticketRegionId,
      this.ticketDistrictId,
      this.referenceId,
      this.referenceParentId,
      this.letterId,
      this.code,
      this.userType,
      this.source,
      this.sentAt,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    isSend = json['is_send'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    description = json['description'];
    phone = json['phone'];
    ticketRegionId = json['ticket_region_id'];
    ticketDistrictId = json['ticket_district_id'];
    referenceId = json['reference_id'];
    referenceParentId = json['reference_parent_id'];
    letterId = json['letter_id'];
    code = json['code'];
    userType = json['user_type'];
    source = json['source'];
    sentAt = json['sent_at'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_send'] = isSend;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['address'] = address;
    data['description'] = description;
    data['phone'] = phone;
    data['ticket_region_id'] = ticketRegionId;
    data['ticket_district_id'] = ticketDistrictId;
    data['reference_id'] = referenceId;
    data['reference_parent_id'] = referenceParentId;
    data['letter_id'] = letterId;
    data['code'] = code;
    data['user_type'] = userType;
    data['source'] = source;
    data['sent_at'] = sentAt;
    data['user_id'] = userId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
