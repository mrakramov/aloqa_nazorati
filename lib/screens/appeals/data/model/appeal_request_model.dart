class AppealRequest {
  String? firstName;
  String? lastName;
  String? description;
  String? address;
  String? phone;
  String? ticketRegionId;
  String? ticketDistrictId;
  String? referenceParentId;
  String? referenceId;
  String? extraPhone;
  String? letterId;

  AppealRequest(
      {this.firstName,
      this.lastName,
      this.description,
      this.address,
      this.phone,
      this.ticketRegionId,
      this.ticketDistrictId,
      this.referenceParentId,
      this.referenceId,
      this.extraPhone,
      this.letterId});

  AppealRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    description = json['description'];
    address = json['address'];
    phone = json['phone'];
    ticketRegionId = json['ticket_region_id'];
    ticketDistrictId = json['ticket_district_id'];
    referenceParentId = json['reference_parent_id'];
    referenceId = json['reference_id'];
    extraPhone = json['extra_phone'];
    letterId = json['letter_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['description'] = description;
    data['address'] = address;
    data['phone'] = phone;
    data['ticket_region_id'] = ticketRegionId;
    data['ticket_district_id'] = ticketDistrictId;
    data['reference_parent_id'] = referenceParentId;
    data['reference_id'] = referenceId;
    data['extra_phone'] = extraPhone;
    data['letter_id'] = letterId;
    return data;
  }
}
