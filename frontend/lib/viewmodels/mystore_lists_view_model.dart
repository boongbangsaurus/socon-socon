import 'package:socon/services/mystore_lists_service.dart';

class MystoreListsViewModel {
  final MystoreListsService _mystoreListsService = MystoreListsService();

  Future<Object> GetMystoreLists() async {
    List mystoreLists = await _mystoreListsService.getMystoreLists();
    // Map<String, dynamic>? mystoreLists = (await _mystoreListsService.getMystoreLists()) as Map<String, dynamic>?;
    if (mystoreLists != null) {
      return mystoreLists;
    } else {
      return [];
    }
  }
}