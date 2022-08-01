class ReferenceResponseModel {
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

  ReferenceResponseModel.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> get toJson {
    return {
      'is_send': isSend,
      'first_name': firstName,
      'last_name': lastName,
      'address': address,
      'description': description,
      'phone': phone,
      'ticket_region_id': ticketRegionId,
      'ticket_district_id': ticketDistrictId,
      'reference_id': referenceId,
      'reference_parent_id': referenceParentId,
      'letter_id': letterId,
      'code': code,
      'user_type': userType,
      'source': source,
      'sent_at': sentAt,
      'user_id': userId,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}
