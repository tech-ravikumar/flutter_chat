class Chat {
  int? id;
  int? fromUser;
  int? toUser;
  String? message;
  String? type;
  String? fileUploaded;
  String? status;
  String? createAt;
  String? updateAt;
  String? read;
  String? deleteFrom;
  String? deleteTo;
  Null? latitude;
  Null? longitude;
  Null? startTime;
  Null? endTime;

  Chat(
      {this.id,
        this.fromUser,
        this.toUser,
        this.message,
        this.type,
        this.fileUploaded,
        this.status,
        this.createAt,
        this.updateAt,
        this.read,
        this.deleteFrom,
        this.deleteTo,
        this.latitude,
        this.longitude,
        this.startTime,
        this.endTime});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromUser = json['from_user'];
    toUser = json['to_user'];
    message = json['message'];
    type = json['type'];
    fileUploaded = json['file_uploaded'];
    status = json['status'];
    createAt = json['create_at'];
    updateAt = json['update_at'];
    read = json['read'];
    deleteFrom = json['delete_from'];
    deleteTo = json['delete_to'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_user'] = this.fromUser;
    data['to_user'] = this.toUser;
    data['message'] = this.message;
    data['type'] = this.type;
    data['file_uploaded'] = this.fileUploaded;
    data['status'] = this.status;
    data['create_at'] = this.createAt;
    data['update_at'] = this.updateAt;
    data['read'] = this.read;
    data['delete_from'] = this.deleteFrom;
    data['delete_to'] = this.deleteTo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}