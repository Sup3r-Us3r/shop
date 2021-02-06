import 'package:shop/models/product_model.dart';

class ProductDetailsModel extends ProductModel {
  bool likeProduct;
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
}
