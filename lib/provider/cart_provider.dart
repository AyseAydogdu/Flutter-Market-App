import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:marketapp/api/category_api.dart';
import 'package:marketapp/api/product_api.dart';
import 'package:marketapp/models/categories.dart';
import 'package:marketapp/models/products.dart';

class CartProvider extends ChangeNotifier {
  List<Products> _products;
  List<Products> productsByCategory;
  List<Categories> _categories;

  List<Products> saved = List<Products>();
  double totalPrice = 0;

  Future getCategoriesFromApi() async {
    List<Categories> category;
    await CategoryApi.getCategories().then((value) {
      Iterable list = json.decode(value.body);
      category = list.map((c) => Categories.fromJson(c)).toList();
    });
    setCategories(category);
  }

  Future getProductsFromApi() async {
    List<Products> product;
    await ProductApi.getProducts().then((value) {
      Iterable list = json.decode(value.body);
      product = list.map((p) => Products.fromJson(p)).toList();
    });
    setProducts(product);
  }

  Future getProductsByCategoryId(Categories category) async {
    List<Products> products;
    List<Products> prod = List<Products>();
    await ProductApi.getProducts().then((value) {
      Iterable list = json.decode(value.body);
      products = list.map((product) => Products.fromJson(product)).toList();
    });
    for (int i = 0; i < products.length; i++) {
      if (products[i].categoryId == category.id) {
        prod.add(products[i]);
      }
    }
    setProductsByCategory(prod);
  }

  setProductsByCategory(List<Products> value) {
    productsByCategory = value;
    notifyListeners();
  }

  setProducts(List<Products> value) {
    _products = value;
    notifyListeners();
  }

  setCategories(List<Categories> value) {
    _categories = value;
    notifyListeners();
  }

  getCategories() {
    return _categories;
  }

  getProducts() {
    return _products;
  }

  getProductsByCategory() {
    return productsByCategory;
  }

  addProduct(Products product) {
    saved.add(product);
    totalPrice += product.unitPrice;
    notifyListeners();
  }

  removeProduct(Products product) {
    saved.remove(product);
    totalPrice -= product.unitPrice;
    notifyListeners();
  }
}
