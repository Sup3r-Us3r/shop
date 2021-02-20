import 'package:shop/models/product_model.dart';

class ProductDetailsModel extends ProductModel {
  bool likeProduct;
  bool productInCart;
  int currentPage;
  int amountValue;
  String totalPrice;

  ProductDetailsModel({
    int id,
    bool star,
    String name,
    double price,
    int amount,
    String category,
    String description,
    List<ProductImage> images,
    String created_at,
    this.likeProduct,
    this.productInCart,
    this.currentPage,
    this.amountValue,
    this.totalPrice,
  }) : super(
          id: id,
          star: star,
          name: name,
          price: price,
          amount: amount,
          category: category,
          description: description,
          images: images,
          created_at: created_at,
        );

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    star = json['star'];
    name = json['name'];
    price = json['price'];
    amount = json['amount'];
    category = json['category'];
    description = json['description'];

    if (json['images'] != null) {
      images = List<ProductImage>();

      json['images'].forEach(
        (image) => images.add(ProductImage.fromJson(image)),
      );
    }

    created_at = json['created_at'];
    likeProduct = json['likeProduct'];
    productInCart = json['productInCart'];
    currentPage = json['currentPage'];
    amountValue = json['amountValue'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['star'] = this.star;
    data['name'] = this.name;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['category'] = this.category;
    data['description'] = this.description;

    if (this.images != null) {
      data['images'] = this.images.map((image) => image.toJson()).toList();
    }

    data['created_at'] = this.created_at;
    data['likeProduct'] = this.likeProduct;
    data['productInCart'] = this.productInCart;
    data['currentPage'] = this.currentPage;
    data['amountValue'] = this.amountValue;
    data['totalPrice'] = this.totalPrice;

    return data;
  }
}
