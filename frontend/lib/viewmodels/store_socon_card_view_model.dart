// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// import 'package:socon/models/socon_card.dart';
//
// class UnifiedViewModel extends ChangeNotifier {
//   final RegisterModel _registerModel = RegisterModel();
//   List<SoconModel> _soconModels = [];
//
//   // RegisterModel 관련 Getters
//   String? get registrationNumber => _registerModel.registrationNumber;
//   String? get address => _registerModel.address;
//   String? get name => _registerModel.name;
//   String? get phoneNumber => _registerModel.phoneNumber;
//   String? get category => _registerModel.category;
//   double? get lat => _registerModel.lat;
//   double? get lng => _registerModel.lng;
//   String? get introduction => _registerModel.introduction;
//   String? get imgUrl => _registerModel.imgUrl;
//
//
//   // SoconModel 관련 Getters
//   List<SoconModel> get soconModels => _soconModels;
//
//   // RegisterModel 관련 Setters
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
//   // SoconModel 관련 메서드
//   void addSoconModel(SoconModel soconModel) {
//     _soconModels.add(soconModel);
//     // 데이터 갯수가 변할 때만 notifyListeners 호출
//     notifyListeners();
//   }
//
//   void removeSoconModel(SoconModel soconModel) {
//     _soconModels.remove(soconModel);
//     // 데이터 갯수가 변할 때만 notifyListeners 호출
//     notifyListeners();
//   }
//
// // 데이터 갯수 변화 감지는 구체적인 상황에 맞게 구현해야 합니다.
// // 예를 들어, _soconModels 리스트에 항목을 추가하거나 제거할 때만 notifyListeners()를 호출합니다.
// }
