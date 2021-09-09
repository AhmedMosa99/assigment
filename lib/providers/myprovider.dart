import 'dart:convert';

import 'package:api/data/api_helper.dart';
import 'package:api/models/product_response.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  List<String> allCategories;
  List<ProductResponse> allProducts;
  List<ProductResponse> categoryProducts;
  ProductResponse selectedProduct;
  String selectedCategory = '';
  bool isfavarite = false;
  var cart = [];
  var favarite = [];
  getAllCategories() async {
    List<dynamic> categories = await ApiHelper.apiHelper.getAllCategories();
    allCategories = categories.map((e) => e.toString()).toList();
    notifyListeners();
    getCategoryProducts(allCategories.first);
  }

  getCategoryProducts(String category) async {
    categoryProducts = null;
    this.selectedCategory = category;
    notifyListeners();
    List<dynamic> products =
        await ApiHelper.apiHelper.getCategoryProducts(category);
    categoryProducts =
        products.map((e) => ProductResponse.fromJson(e)).toList();
    notifyListeners();
  }

  getAllProducts() async {
    List<dynamic> products = await ApiHelper.apiHelper.getAllProducts();
    allProducts = products.map((e) => ProductResponse.fromJson(e)).toList();
    notifyListeners();
  }

  getSpecificProduct(int id) async {
    selectedProduct = null;
    notifyListeners();
    dynamic response = await ApiHelper.apiHelper.getSpecificProduct(id);
    selectedProduct = ProductResponse.fromJson(response);
    notifyListeners();
  }

  addtoCart(ProductResponse productResponse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (cart.contains(productResponse)) {
      print("product alerdy found");
      notifyListeners();
    } else {
      cart.add(productResponse);
      String rawJson = jsonEncode(cart);
      notifyListeners();
      prefs.setString('product', rawJson);
      print(cart);
      notifyListeners();
    }
  }

  addfavarite(ProductResponse productResponse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (isfavarite == true) {
      favarite.add(productResponse);
      isfavarite = true;
      notifyListeners();
      String rawJson = jsonEncode(favarite);
      notifyListeners();
      prefs.setString('favarite', rawJson);
      print(favarite);
      notifyListeners();
    } else if (isfavarite == false) {
      favarite.removeWhere((element) => element);
      print(favarite);
      prefs.remove('favarite');
      notifyListeners();
    }
  }
}
