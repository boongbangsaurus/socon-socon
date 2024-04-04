import 'package:flutter/foundation.dart';
import 'package:socon/services/mystore_lists_service.dart';
import 'package:socon/services/stores_service.dart';

import '../models/store.dart';

class StoresViewModel extends ChangeNotifier {
  final StoresService _storesService = StoresService();

  // Store tempStore = Store(
  //     storeId: 0,
  //     name: "오소유",
  //     imageUrl: "https://cataas.com/cat",
  //     address: "광주 광산구 장덕로40번길 13-1 1층",
  //     category: "음식점",
  //     createdAt: "2024-03-22",
  //     isLike: true,
  //     mainSocon: "소금빵",
  //     distance: 15);

  List<Store> stores = List.generate(10, (index) {
    return Store(
      storeId: index, // Using index directly for storeId
      name: "오소유 ${index + 1}", // Using index to make each name unique
      imageUrl: "https://cataas.com/cat", // You can modify this as needed
      address: "광주 광산구 장덕로40번길 13-1 1층", // You can modify this as needed
      category: "음식점", // You can modify this as needed
      createdAt: "2024-03-22", // You can modify this as needed
      isLike: true, // You can modify this as needed
      mainSocon: "소금빵", // You can modify this as needed
      distance: 10 + index, // Calculating distance based on index
    );
  });


  Future<List<Store>?> searchStores() async {
    print("검색을 시작해볼게");

    try {
     List<Store>? stores = await _storesService.searchStores();

      print("[viewModel] $stores");
      return stores;
    } catch (error) {
      print("검색 중 오류가 발생했습니다: $error");
      return null;
    }
  }

}
