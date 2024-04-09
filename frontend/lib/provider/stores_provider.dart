import 'package:flutter/foundation.dart';
import 'package:socon/models/search_params.dart';
import 'package:socon/models/store.dart';
import 'package:socon/services/stores_service.dart';
import '../utils/api/api_utils.dart';

class StoresProvider extends ChangeNotifier {
  final SearchParams _searchParams = SearchParams(
    content: "",
    lat: 35.205742,
    lng: 126.811538,
    searchType: "name",
    sort: "distance",
    isFavoriteSearch: false,
    page: 0,
    size: 10,
  );

  List<Store> storeList = [];
  String? errorMessage;

  List<Store> getStoreList() {
    return storeList;
  }

  Future<void> fetchStores() async {
    try {
      await _searchStores();
    } catch (error) {
      errorMessage = error.toString();
      notifyListeners();
    }
  }

  void updateStoreList(List<Store> newStores) {
    if (_listsAreDifferent(storeList, newStores)) {
      storeList = newStores;
      notifyListeners();
    }
  }

  bool _listsAreDifferent(List<Store> list1, List<Store> list2) {
    if (list1.length != list2.length) {
      return true;
    }

    for (int i = 0; i < list1.length; i++) {
      if (list1[i].storeId != list2[i].storeId) {
        return true;
      }
    }

    return false;
  }

  Future<void> _searchStores() async {
    final response = await ApiUtils.postDataWithToken(
      '/api/v1/search/detail',
      _searchParams.toJson(),
    );

    List<Store> fetchedStores = (response as List)
        .map((item) => Store.fromJson(item as Map<String, dynamic>))
        .toList();

    updateStoreList(fetchedStores);
  }
}
