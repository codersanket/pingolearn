import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pingolearn/helper/remote_config_helper.dart';
import 'package:pingolearn/models/product_model.dart';
import 'package:pingolearn/respository/home_repo.dart';
import 'package:pingolearn/screens/home/home.dart';

enum HomePageState { initial, loading, loaded }

class HomeProvider extends ChangeNotifier {
  HomeRepo _repo;
  RemoteConfigHelper _remoteConfig;
  HomeProvider(this._repo, this._remoteConfig);

  late ProductModel products;

  HomePageState homePageState = HomePageState.initial;

  Future<void> init() async {
    homePageState = HomePageState.loading;
    notifyListeners();

    products = await _repo.getProducts();

    homePageState = HomePageState.loaded;
    notifyListeners();
  }

  bool get showDiscount => _remoteConfig.getValue<bool>('showDiscount');

  String getDiscountedPrice(double discount, int price) =>
      (price - (price * (discount / 100))).round().toString();
}
