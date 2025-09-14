import 'package:dio/dio.dart';

class ApiProvider{

  getProducts() async {
    var response = await Dio().get('https://fakestoreapi.com/products');
    return response;
  }
}