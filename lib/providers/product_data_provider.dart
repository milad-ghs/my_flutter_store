import 'package:flutter/cupertino.dart';
import 'package:store/network/api_provider.dart';
import 'package:store/network/response_model.dart';
import '../models/product_model.dart';

class ProductDataProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();
  var response;
  late ProductsModel dataFuture;
  late ResponseModel state;

  getProducts() async {
    state = ResponseModel.loading('is Loading ...');

    try {
      response = await apiProvider.getProducts();
      // print(response.data);
      if (response.statusCode == 200) {
        dataFuture = ProductsModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error('please try later .');
      }
      notifyListeners();
    } catch (ex) {
      print('catch error: $ex');
      state = ResponseModel.error('please check your connection ');
      notifyListeners();
    }
  }
}
