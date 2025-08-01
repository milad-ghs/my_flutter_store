import 'package:dio/dio.dart';
import 'package:store/network/api_provider.dart';
import 'package:store/network/response_model.dart';
import '../models/product_model.dart';
import 'package:flutter/foundation.dart';


class ProductDataProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();
  late Response response;
  late ProductsModel dataFuture;
  ResponseModel state = ResponseModel.loading('initial');

  getProducts() async {
    state = ResponseModel.loading('is Loading ...');
    notifyListeners();

    try {
      response = await apiProvider.getProducts();
      // print(response.data);
      if (response.statusCode == 200) {
        dataFuture = ProductsModel.fromJson(response.data);
        final uniqueCategories = dataFuture.products
            .map((e) => e.category)
            .toSet()
            .toList();

        categories = ['All', ...uniqueCategories];
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error('please try later .');
      }
      notifyListeners();
    } catch (ex) {
      if (kDebugMode) {
        print('catch error: $ex');
      }
      state = ResponseModel.error('Please check your connection ');
      notifyListeners();
    }
  }

  /// for categories

  List<String> categories = ['All'];

  String selectedCategory = 'All';

  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    if (selectedCategory == 'All') return dataFuture.products;

    return dataFuture.products
        .where((product) => product.category == selectedCategory)
        .toList();
  }

}
