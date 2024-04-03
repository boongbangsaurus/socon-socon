import 'package:flutter/material.dart';
import 'package:socon/services/payment_service.dart';

import '../models/product_detail_model.dart';


/// [PaymentVerificationViewModel]
/// view의 실제 로직 구현 (폼 검증, 서비스 호출)
class PaymentVerificationViewModel extends ChangeNotifier {
  final PaymentService _paymentService = PaymentService();
  late ProductDetailModel _productDetailModel;
  late String _orderUid;

  ProductDetailModel get productDetailModel => _productDetailModel;
  String get orderUid => _orderUid;


  // 상품 주문 요청 api 호출 (post)
  Future<void> sendPaymentRequest(Map<String, dynamic> orderData) async {
    _orderUid = await _paymentService.sendPaymentRequest(orderData);
    notifyListeners();
  }


  // 상품 상세 데이터 호출 (get)
  Future<void> getMenuDetail(int storeId, int menuId) async {
    print('테스트중');
    _productDetailModel = (await _paymentService.getMenuDetail(storeId, menuId)) as ProductDetailModel;

    notifyListeners();
  }

  // Future<void> getVerification(String impUid, String orderUid) async {
  //   _productDetailModel = await _paymentService.getMenuDetail(impUid, orderUid);
  //   notifyListeners();
  // }

}