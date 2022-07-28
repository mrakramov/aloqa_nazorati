import 'dart:convert';

class ReferenceListResponse {
  ReferenceListResponse({
    required this.id,
    required this.name,
    required this.parentId,
    required this.isActive,
    required this.sort,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  Name name;
  int parentId;
  bool isActive;
  int sort;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  ReferenceListResponse copyWith({
    int? id,
    Name? name,
    int? parentId,
    bool? isActive,
    int? sort,
    dynamic deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ReferenceListResponse(
        id: id ?? this.id,
        name: name ?? this.name,
        parentId: parentId ?? this.parentId,
        isActive: isActive ?? this.isActive,
        sort: sort ?? this.sort,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ReferenceListResponse.fromJson(Map<String, dynamic> json) => ReferenceListResponse(
    id: json["id"],
    name: Name.fromJson(json["name"]),
    parentId: json["parent_id"],
    isActive: json["is_active"],
    sort: json["sort"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name.toJson(),
    "parent_id": parentId,
    "is_active": isActive,
    "sort": sort,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Name {
  Name({
    required this.oz,
    required this.uz,
    required this.ru,
  });

  String oz;
  String uz;
  String ru;

  Name copyWith({
    String? oz,
    String? uz,
    String? ru,
  }) =>
      Name(
        oz: oz ?? this.oz,
        uz: uz ?? this.uz,
        ru: ru ?? this.ru,
      );

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    oz: json["oz"],
    uz: json["uz"],
    ru: json["ru"],
  );

  Map<String, dynamic> toJson() => {
    "oz": oz,
    "uz": uz,
    "ru": ru,
  };
}
