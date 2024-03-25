import 'package:flutter/material.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';

/// [AppIcons]
/// 아이콘 종류를 정의하는 클래스
/// author: 탁하윤
class AppIcons {
  // move Icon
  static const IconData LEADING = Icons.chevron_left; // 백버튼
  static const IconData RIGHT = Icons.chevron_right; // 오른쪽 버튼

  // NavigationBar
  static const IconData PLACE = Icons.place_outlined; // 주변 정보
  static const IconData SOGON = Icons.sms_outlined; // 소곤
  static const IconData STORE = Icons.storefront; // 가게 정보
  static const IconData COUPON = Icons.confirmation_num_outlined; // 쿠폰북
  static const IconData PROFILE = Icons.person_outline_rounded; // 내 정보

  // socon download icon
  static const IconData DOWNLOAD = FeatherIcons.download; // 다운로드

  // mypage
  static const IconData EDIT = FeatherIcons.edit3; // 수정 버튼

  // 이미지 아이콘
  static const FluentData PARTY = Fluents.flPartyPopper; // 팡파레
  static const FluentData FAIL = Fluents.flAnxiousFaceWithSweat; // 실패 이모지
  static const FluentData SAD = Fluents.flCryingFace; // 눈물 (점포 데이터 X)

  // socon
  static const IconData HEARTON = Icons.favorite; // 찜(색상)
  static const IconData PHONE = FeatherIcons.phone; // 전화
  static const IconData HEARTOFF = Icons.favorite_border_outlined; // 하트

  static const IconData PLUS = Icons.add; // +
  static const IconData MINUS = FeatherIcons.minus; // -
  static const IconData CLOSE = Icons.close; // delete, close

  static const IconData CAMERA = FeatherIcons.camera; // camera
  static const IconData INFO = FeatherIcons.info; // 정보 알림
}
