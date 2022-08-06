class AppealRequestData {
  int? letterId;
  String? description;
  String? firstName;
  String? lastName;
  String? address;
  int? ticketRegionId;
  int? ticketDistrictId;
  String? phone;
  int? referenceParentId;
  int? referenceId;
  List<int>? files;

  AppealRequestData(
      {this.letterId,
      this.description,
      this.firstName,
      this.lastName,
      this.address,
      this.ticketRegionId,
      this.ticketDistrictId,
      this.phone,
      this.referenceParentId,
      this.referenceId,
      this.files});

  AppealRequestData.fromJson(Map<String, dynamic> json) {
    letterId = json['letter_id'];
    description = json['description'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    ticketRegionId = json['ticket_region_id'];
    ticketDistrictId = json['ticket_district_id'];
    phone = json['phone'];
    referenceParentId = json['reference_parent_id'];
    referenceId = json['reference_id'];
    files = json['files[]'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['letter_id'] = letterId;
    data['description'] = description;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['address'] = address;
    data['ticket_region_id'] = ticketRegionId;
    data['ticket_district_id'] = ticketDistrictId;
    data['phone'] = phone;
    data['reference_parent_id'] = referenceParentId;
    data['reference_id'] = referenceId;
    // data['files[]'] = files;
    return data;
  }
}
