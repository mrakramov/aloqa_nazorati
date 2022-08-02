import 'package:equatable/equatable.dart';

class DistrictsResponse extends Equatable {
  int? id;
  Name? name;
  bool? isActive;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  bool? isRepublic;
  dynamic uzTextLetter;
  dynamic enTextLetter;
  dynamic uzAddressLetter;
  dynamic enAddressLetter;

  DistrictsResponse(
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

  DistrictsResponse.fromJson(Map<String, dynamic> json) {
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

  @override
  List<Object?> get props => [id, name];
}

class Name extends Equatable {
  String? ru;
  String? en;
  String? uz;
  String? oz;

  Name({this.ru, this.en, this.uz, this.oz});

  Name.fromJson(Map<String, dynamic> json) {
    ru = json['ru'];
    en = json['en'];
    uz = json['uz'];
    oz = json['oz'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ru'] = ru;
    data['en'] = en;
    data['uz'] = uz;
    data['oz'] = oz;
    return data;
  }

  @override
  List<Object?> get props => [ru, oz, uz];
}
