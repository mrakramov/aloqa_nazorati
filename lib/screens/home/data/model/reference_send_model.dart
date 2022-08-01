class ReferenceSendModel {
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
  List<int?>? files;

  ReferenceSendModel(
      {required this.letterId,
      required this.description,
      required this.firstName,
      required this.lastName,
      required this.address,
      required this.ticketRegionId,
      required this.ticketDistrictId,
      required this.phone,
      required this.referenceParentId,
      required this.referenceId,
      required this.files});

  ReferenceSendModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    letterId = json['letter_id'];
    description = json['description'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    ticketRegionId = json['ticket_region_id'];
    ticketDistrictId = json['ticket_district_id'];
    phone = json['phone'];
    referenceParentId = json['reference_parent_id'];
    referenceId = json['reference_id'];
    files = List<int>.from(json['files[]']);
  }

  Map<String, dynamic> get toJson {
    return {
      'address': address,
      'letter_id': letterId,
      'description': description,
      'first_name': firstName,
      'last_name': lastName,
      'ticket_region_id': ticketRegionId,
      'ticket_district_id': ticketDistrictId,
      'phone': phone,
      'reference_parent_id': referenceParentId,
      'reference_id': referenceId,
      'files[]': files!.map((e) => e!.toInt()).toList()
    };
  }
}
