import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:socon/models/store_register_model.dart';
import 'package:socon/services/store_register_service.dart';


class StoreRegisterViewModel extends ChangeNotifier {
  final StoreRegisterModel storeModel = StoreRegisterModel();
  final StoreRegisterService storeService = StoreRegisterService();

  // 스토어 등록 api post 요청
  Future<bool> registerStore() async {
    try {
      debugPrint('ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ');
      final result = await storeService.registerStore(storeModel);
      debugPrint(result as String?);
      debugPrint('ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ');
      return result;
    } catch (e) {
      // 에러 처리 하기
      return false;
    }
  }

    // Getters
  // String? get representative => storeModel.representative;
  String? get name => storeModel.name;
  String? get category => storeModel.category;
  String? get image => storeModel.image;
  String? get phoneNumber => storeModel.phoneNumber;
  String? get address => storeModel.address;
  double? get lat => storeModel.lat;
  double? get lng => storeModel.lng;
  String? get introduction => storeModel.introduction;
  int? get registrationNumberId => storeModel.registrationNumberId;
  List? get businessHours => storeModel.businessHours;
  // List<BusinessHour>? get businessHours => storeModel.businessHours;






  void setName(String name) {
    storeModel.name = name;
    notifyListeners();
  }

  void setCategory(String category) {
    storeModel.category = category;
    notifyListeners();
  }

  void setImage(String image) {
    storeModel.image = image;
    debugPrint('DDDDDDDDDDDDDDDDDDDDDDD');
    debugPrint(image);
    debugPrint('DDDDDDDDDDDDDDDDDDDDDDDDDD');
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    storeModel.phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setAddress(String address) {
    storeModel.address = address;
    notifyListeners();
  }

  void setLatitude(double lat) {
    storeModel.lat = lat;
    notifyListeners();
  }

  void setLongitude(double lng) {
    storeModel.lng = lng;
    notifyListeners();
  }

  void setIntroduction(String introduction) {
    storeModel.introduction = introduction;
    notifyListeners();
  }

  void setRegistrationNumberId(int registrationNumberId) {
    storeModel.registrationNumberId = registrationNumberId;
    notifyListeners();
  }

  // void setBusinessHours(List<BusinessHour> businessHours) {
  //   storeModel.businessHours = businessHours;
  //   notifyListeners();
  // }
 void setBusinessHours(List businessHours) {
    storeModel.businessHours = businessHours;
    // debugPrint('EEEEEEEEEEEEEEEEEEEEEEEEEEE');
    // debugPrint(businessHours as String?);
    // debugPrint('EEEEEEEEEEEEEEEEEEEEEEEEEEE');
    notifyListeners();
  }


}



// class RegisterViewModel extends ChangeNotifier {
//   final RegisterModel _registerModel = RegisterModel();
//
//
//   // Getters
//   // String? get representative => _registerModel.representative;
//   String? get registrationNumber => _registerModel.registrationNumber;
//   String? get address => _registerModel.address;
//   String? get name => _registerModel.name;
//   String? get phoneNumber => _registerModel.phoneNumber;
//   String? get category => _registerModel.category;
//   double? get lat => _registerModel.lat;
//   double? get lng => _registerModel.lng;
//   String? get introduction => _registerModel.introduction;
//   String? get imgUrl => _registerModel.imgUrl;
//   List<BusinessHour>? get businessHours => _registerModel.businessHours;
//
//
//   // Setters
//   // void setRepresentative(String value) {
//   //   _registerModel.representative = value;
//   //   notifyListeners();
//   // }
//
//   void setRegistrationNumber(String value) {
//     _registerModel.registrationNumber = value;
//     notifyListeners();
//   }
//
//   void setAddress(String value) {
//     _registerModel.address = value;
//     notifyListeners();
//   }
//
//   void setName(String value) {
//     _registerModel.name = value;
//     notifyListeners();
//   }
//
//   void setPhoneNumber(String value) {
//     _registerModel.phoneNumber = value;
//     notifyListeners();
//   }
//
//   void setCategory(String value) {
//     _registerModel.category = value;
//     notifyListeners();
//   }
//
//   void setLat(double value) {
//     _registerModel.lat = value;
//     notifyListeners();
//   }
//
//   void setLng(double value) {
//     _registerModel.lng = value;
//     notifyListeners();
//   }
//
//   void setIntroduction(String value) {
//     _registerModel.introduction = value;
//     notifyListeners();
//   }
//
//   void setImgUrl(String? value) {
//     _registerModel.imgUrl = value;
//     notifyListeners();
//   }
//
//   void updateBusinessHour(String day, {String? openAt, String? closeAt, bool? isWorking, bool? breakTime, String? breaktimeStart, String? breaktimeEnd}) {
//     if (_registerModel.businessHours == null) {
//       _registerModel.businessHours = [];
//     }
//
//     // 해당 요일의 BusinessHour 찾기 또는 새로 생성
//     var index = _registerModel.businessHours!.indexWhere((bh) => bh.day == day);
//     BusinessHour businessHour;
//
//     if (index != -1) {
//       // 해당 요일의 BusinessHour 찾기
//       businessHour = _registerModel.businessHours![index];
//     } else {
//       // 새로운 BusinessHour 생성
//       businessHour = BusinessHour(day: day, isWorking: false);
//       _registerModel.businessHours!.add(businessHour);
//     }
//
//     // 찾은 BusinessHour 업데이트
//     if (openAt != null) businessHour.openAt = openAt;
//     if (closeAt != null) businessHour.closeAt = closeAt;
//     if (isWorking != null) businessHour.isWorking = isWorking;
//     if (breakTime != null) businessHour.breakTime = breakTime;
//     if (breaktimeStart != null) businessHour.breaktimeStart = breaktimeStart;
//     if (breaktimeEnd != null) businessHour.breaktimeEnd = breaktimeEnd;
//
//     notifyListeners();
//   }
//
//
//
//
//   void register() {
//     // 디버그 프린트
//     debugPrint('Registering with the following details:');
//     debugPrint('Name: ${_registerModel.name}');
//     debugPrint('Address: ${_registerModel.address}');
//     debugPrint('Phone Number: ${_registerModel.phoneNumber}');
//
//   }
// }