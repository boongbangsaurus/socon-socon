import 'package:socon/services/mystore_detail_menu_list_service.dart';

/// [MystoreMenuListViewModel]
/// 내 점포 상세 조회 (발행 소콘 목록) get
class MystoreMenuListViewModel {

  final MystoreMenuService _mystoreMenuService = MystoreMenuService();
  bool isLoading = false;

  // 점포 조회 디테일 요청 - 메뉴관리
  Future<Object> mystoreMenuLists(int id) async {
    List<dynamic>? sogons = await _mystoreMenuService.getMystoreMenuLists(id);
    if (sogons != null) {
      return sogons;
    } else {
      return {};
    }
  }



  // 점포 조회 디테일 요청 - 발행소콘
  Future<Object> mystoreRegisterMenuLists(int id) async {
    List<dynamic>? sogons = await _mystoreMenuService.getMystoreRegisterMenuLists(id);
    if (sogons != null) {
      return sogons;
    } else {
      return {};
    }
  }



  // 가게 상세조회 detail
  // Future<Map<String, dynamic>> storeDetailInfos(int id) async {
  Future storeDetailInfos(int id) async {
    isLoading = true;
    // Map<String, dynamic> infos = (await _mystoreMenuService.getStoreDetailInfos(id));
    var  tmp = (await _mystoreMenuService.getStoreDetailInfos(id));
    Map<String, dynamic> infos = tmp!;
    // print('3.141519250');


    // print(infos?['store']?? '');

    // print('3.141519250');
    // print('3.141519250');

    // var k = infos?.map((key, value) => value);
    // print(k.toString());
    if (infos != null) {
      isLoading = false;
      return infos;
    } else {
      isLoading = false;
      return {};
    }
  }

}





// ChangeNotifierProvider(create: (context) => MystoreListsViewModel(),),




// // Notifier???
// class MystoreMenuListViewModel extends ChangeNotifier {
//   final MystoreMenuService _mystoreMenuService = MystoreMenuService();
//
//
//   // 점포 조회 디테일 요청 - 메뉴관리
//   Future<Map<String, dynamic>> mystoreMenuLists(int id) async {
//     Map<String, dynamic>? sogons = await _mystoreMenuService.getMystoreMenuLists(id);
//     notifyListeners();
//     if (sogons != null) {
//       return sogons;
//     } else {
//       return {};
//     }
//   }
//
//
//   // 점포 조회 디테일 요청 - 발행소콘
//   Future<Map<String, dynamic>> mystoreRegisterMenuLists(int id) async {
//     Map<String, dynamic>? sogons = await _mystoreMenuService.getMystoreRegisterMenuLists(id);
//     if (sogons != null) {
//       return sogons;
//     } else {
//       return {};
//     }
//   }
//
// }