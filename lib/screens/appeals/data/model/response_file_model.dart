class FileUploadResponseModel {
  String? status;
  String? code;
  Data? data;
  String? message;

  FileUploadResponseModel({this.status, this.code, this.data, this.message});

  FileUploadResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? userId;
  String? file;
  String? fileName;
  String? filePath;
  String? fileExtension;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.userId,
      this.file,
      this.fileName,
      this.filePath,
      this.fileExtension,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    file = json['file'];
    fileName = json['file_name'];
    filePath = json['file_path'];
    fileExtension = json['file_extension'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['file'] = file;
    data['file_name'] = fileName;
    data['file_path'] = filePath;
    data['file_extension'] = fileExtension;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
