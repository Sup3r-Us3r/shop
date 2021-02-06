import 'package:flutter/material.dart';
import 'package:shop/models/product_details_model.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/util/formatPrice.dart';

class DetailsBloc extends ChangeNotifier {
  ProductModel _currentProduct;
  List<ProductDetailsModel> _productsData = [];
  List<ProductDetailsModel> _cart = [];
  List<ProductDetailsModel> get cart => _cart;
  int get amountItemsOnCart => _cart.length;
  bool get productAddedOnCart => _checkProductExistsOnCart();
  String get calcTotalPriceOfCart => _calcTotalPriceOfCart();
  List<ProductDetailsModel> _favoriteProducts = [];
  List<ProductDetailsModel> get favoriteProducts => _favoriteProducts;
  int get quantityOfFavoriteProducts => _favoriteProducts.length;
  bool get favoriteProductAdded => _checkFavoriteProductExists();

  void currentProductData(ProductModel data) {
    _currentProduct = data;
    _addCurrentProductToProductsData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setPosition0OnPageView();
    });
  }

  bool _checkProductExistsOnProductsData() {
    try {
      _productsData.firstWhere(
        (element) => element.id == _currentProduct.id,
      );

      return true;
    } on StateError catch (_) {
      return false;
    }
  }

  bool _checkProductExistsOnCart() {
    try {
      _cart.firstWhere(
        (element) => element.id == _currentProduct.id,
      );

      return true;
    } on StateError catch (_) {
      return false;
    }
  }

  bool _checkFavoriteProductExists() {
    try {
      _favoriteProducts.firstWhere(
        (element) => element.id == _currentProduct.id,
      );

      return true;
    } on StateError catch (_) {
      return false;
    }
  }

  void _addCurrentProductToProductsData() {
    if (_checkProductExistsOnProductsData()) return;

    _productsData.add(
      ProductDetailsModel(
        id: _currentProduct.id,
        star: _currentProduct.star,
        name: _currentProduct.name,
        price: _currentProduct.price,
        amount: _currentProduct.amount,
        category: _currentProduct.category,
        description: _currentProduct.description,
        images: _currentProduct.images,
        created_at: _currentProduct.created_at,
        likeProduct: false,
        currentPage: 0,
        amountValue: 1,
        totalPrice: formatPrice(_currentProduct.price),
      ),
    );
  }

  dynamic showCurrentProductInfo(String whichField) {
    var specificData = _productsData.firstWhere(
      (element) => element.id == _currentProduct.id,
    );

    switch (whichField) {
      case 'likeProduct':
        return specificData.likeProduct;
      case 'currentPage':
        return specificData.currentPage;
      case 'amountValue':
        return specificData.amountValue;
      case 'totalPrice':
        return specificData.totalPrice;
      default:
    }
  }

  void _changeSomeCurrentProductValue(String whichField, dynamic newValue) {
    var updateProduct = _productsData.firstWhere(
      (element) => element.id == _currentProduct.id,
    );

    switch (whichField) {
      case 'likeProduct':
        return updateProduct.likeProduct = newValue;
      case 'currentPage':
        return updateProduct.currentPage = newValue;
      case 'amountValue':
        return updateProduct.amountValue = newValue;
      case 'totalPrice':
        return updateProduct.totalPrice = newValue;
      default:
    }
  }

  void _setPosition0OnPageView() {
    _changeSomeCurrentProductValue('currentPage', 0);
  }

  void calcTotalPrice() {
    int currentAmountProductValue = showCurrentProductInfo('amountValue');

    var total = _currentProduct.price * currentAmountProductValue;

    _changeSomeCurrentProductValue('totalPrice', formatPrice(total));

    notifyListeners();
  }

  void toggleLikeProduct() {
    bool currentLikeProductValue = showCurrentProductInfo('likeProduct');

    _changeSomeCurrentProductValue('likeProduct', !currentLikeProductValue);

    if (_checkFavoriteProductExists()) {
      _favoriteProducts.removeWhere(
        (element) => element.id == _currentProduct.id,
      );
    } else {
      var productForAdd = _productsData.firstWhere(
        (element) => element.id == _currentProduct.id,
      );

      _favoriteProducts.add(productForAdd);
    }

    notifyListeners();
  }

  void whenPageChanged(int indexOfChangedPage) {
    _changeSomeCurrentProductValue('currentPage', indexOfChangedPage);

    notifyListeners();
  }

  void incrementProduct() {
    int currentAmountProductValue = showCurrentProductInfo('amountValue');

    _changeSomeCurrentProductValue(
      'amountValue',
      currentAmountProductValue + 1,
    );

    calcTotalPrice();
  }

  void decrementProduct() {
    int currentAmountProductValue = showCurrentProductInfo('amountValue');

    if (currentAmountProductValue == 1) return;

    _changeSomeCurrentProductValue(
      'amountValue',
      currentAmountProductValue - 1,
    );

    calcTotalPrice();
  }

  void toggleProductOnCart() {
    if (_checkProductExistsOnCart()) {
      _cart.removeWhere(
        (element) => element.id == _currentProduct.id,
      );

      notifyListeners();
    } else {
      var productForAdd = _productsData.firstWhere(
        (element) => element.id == _currentProduct.id,
      );

      _cart.add(productForAdd);

      notifyListeners();
    }
  }

  void removeProductOnCart(int productId) {
    _cart.removeWhere((element) => element.id == productId);

    notifyListeners();
  }

  void removeFavoriteProduct(int productId) {
    _favoriteProducts.removeWhere((element) => element.id == productId);

    notifyListeners();
  }

  String _calcTotalPriceOfCart() {
    var totalPrice = _cart
        .map((product) => product.price * product.amountValue)
        .reduce((value, element) => value + element);

    return formatPrice(totalPrice);
  }
}
