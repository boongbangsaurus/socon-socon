import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

// 운영시간
class BusinessHour {
  String day;
  bool isWorking;
  String? openAt;
  String? closeAt;
  bool? breakTime;
  String? breaktimeStart;
  String? breaktimeEnd;

  BusinessHour({
    required this.day,
    required this.isWorking,
    this.openAt,
    this.closeAt,
    this.breakTime,
    this.breaktimeStart,
    this.breaktimeEnd,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BusinessHour &&
              runtimeType == other.runtimeType &&
              day == other.day;

  @override
  int get hashCode => day.hashCode;
}

class RegisterModel {
  // String? representative;   // 대표자
  String? registrationNumber;    // 사업자 등록 번호
  String? address;    // 사업자 주소
  String? name;   // 상호명
  String? phoneNumber;   // 전화번호
  String? category;   // 업종
  double? lat;
  double? lng;
  String? introduction;   // 업체 소개
  String? imgUrl;   // 가게사진
  List<BusinessHour>? businessHours; // 운영시간


  RegisterModel({
    // this.representative,
    this.registrationNumber,
    this.address,
    this.name,
    this.phoneNumber,
    this.category,
    this.lat,
    this.lng,
    this.introduction,
    this.imgUrl,
    this.businessHours,
  });


}