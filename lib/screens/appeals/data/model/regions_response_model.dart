class RegionsResponse {
  int? id;
  Name? name;
  bool? isActive;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  bool? isRepublic;
  String? uzTextLetter;
  String? enTextLetter;
  String? uzAddressLetter;
  String? enAddressLetter;

  RegionsResponse(
      {this.id,
      this.name,
      this.isActive,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.isRepublic,
      this.uzTextLetter,
      this.enTextLetter,
      this.uzAddressLetter,
      this.enAddressLetter});

  RegionsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    isActive = json['is_active'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isRepublic = json['is_republic'];
    uzTextLetter = json['uz_text_letter'];
    enTextLetter = json['en_text_letter'];
    uzAddressLetter = json['uz_address_letter'];
    enAddressLetter = json['en_address_letter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['is_active'] = isActive;
    data['parent_id'] = parentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_republic'] = isRepublic;
    data['uz_text_letter'] = uzTextLetter;
    data['en_text_letter'] = enTextLetter;
    data['uz_address_letter'] = uzAddressLetter;
    data['en_address_letter'] = enAddressLetter;
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
