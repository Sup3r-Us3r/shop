class UserModel {
  int id;
  String name;
  String email;
  String password;
  UserPhoto photo;
  String created_at;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.photo,
    this.created_at,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    photo = UserPhoto.fromJson(json['photo']);
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['photo'] = this.photo.toJson();
    data['created_at'] = this.created_at;

    return data;
  }
}

class UserPhoto {
  String public_id;
  String url;

  UserPhoto({this.public_id, this.url});

  UserPhoto.fromJson(Map<String, dynamic> json) {
    public_id = json['public_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['public_id'] = this.public_id;
    data['url'] = this.url;

    return data;
  }
}
