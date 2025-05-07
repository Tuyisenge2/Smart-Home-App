import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  List<dynamic> _searchData = [];
  bool isLoading = true;
  dynamic get searchData => _searchData;
  void setSearchData(dynamic deviceData) {
    _searchData = deviceData ?? [];
    isLoading = false;
    notifyListeners();
  }
}