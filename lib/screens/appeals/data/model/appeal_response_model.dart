class AppealResponseModel {
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
  DateTime? sentAt;
  int? userId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  AppealResponseModel.fromJson(Map<String, dynamic> json) {
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
    sentAt = DateTime.tryParse(json['sent_at']);
    userId = json['user_id'];
    updatedAt = DateTime.tryParse(json['updated_at']);
    createdAt = DateTime.tryParse(json['created_at']);
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
      'sent_at': sentAt!.toIso8601String(),
      'user_id': userId,
      'updated_at': updatedAt!.toIso8601String(),
      'created_at': createdAt!.toIso8601String(),
      'id': id,
    };
  }
}
