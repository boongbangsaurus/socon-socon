import 'package:socon/services/mystore_lists_service.dart';
import 'package:socon/services/stores_service.dart';

class StoresViewModel {
  final StoresService _storesService = StoresService();

  Future<void> searchStores() async {
    print("검색을 시작해볼게");
    await _storesService.searchStores();
  }
}
