class ProductModel {
  int id;
  bool star;
  String name;
  double price;
  int amount;
  String category;
  String description;
  List<ProductImage> images;
  String created_at;

  ProductModel({
    this.id,
    this.star,
    this.name,
    this.price,
    this.amount,
    this.category,
    this.description,
    this.images,
    this.created_at,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    star = json['star'];
    name = json['name'];
    price = json['price'];
    amount = json['amount'];
    category = json['category'];
    description = json['description'];

    if (json['images'] != null) {
      images = List<ProductImage>();

      json['images'].forEach((image) {
        images.add(ProductImage.fromJson(image));
      });
    }

    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['star'] = this.star;
    data['name'] = this.name;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['category'] = this.category;
    data['description'] = this.description;

    if (data['images'] != null) {
      data['images'] = this.images.map((image) => image.toJson()).toList();
    }

    data['created_at'] = this.created_at;

    return data;
  }
}

class ProductImage {
  int id;
  int product_id;
  String public_id;
  String url;

  ProductImage({this.id, this.product_id, this.public_id, this.url});

  ProductImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product_id = json['product_id'];
    public_id = json['public_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['product_id'] = this.product_id;
    data['public_id'] = this.public_id;
    data['url'] = this.url;

    return data;
  }
}
