class CategoryModel {
  int id;
  String name;
  CategoryImage image;

  CategoryModel({this.id, this.name, this.image});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = CategoryImage.fromJson(json['image']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image.toJson();

    return data;
  }
}

class CategoryImage {
  String public_id;
  String url;

  CategoryImage({this.public_id, this.url});

  CategoryImage.fromJson(Map<String, dynamic> json) {
    public_id = json['public_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['public_id'] = this.public_id;
    data['url'] = this.url;

    return data;
  }
}
