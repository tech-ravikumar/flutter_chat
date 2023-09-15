class User {
  int? id;
  String? name;
  String? image;
  String? email;
  String? number;
  Null? emailVerifiedAt;
  String? password;
  Null? rememberToken;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.image,
        this.email,
        this.number,
        this.emailVerifiedAt,
        this.password,
        this.rememberToken,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    number = json['number'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['email'] = this.email;
    data['number'] = this.number;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}