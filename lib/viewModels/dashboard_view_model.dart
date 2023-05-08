import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_place/resources/models/product.dart';

class DashboardViewModel extends ChangeNotifier {
  List<Product> products = [];
  init() async {
    String jsonString =
        await rootBundle.loadString('assets/json/products.json');
    var data = json.decode(jsonString) as List;

    // debugPrint(data);
    products = data.map<Product>((json) => Product.fromJson(json)).toList();
    notifyListeners();
  }
}
