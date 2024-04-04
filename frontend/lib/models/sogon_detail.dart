import 'package:intl/intl.dart';

class SogonDetail {
  int id;
  String title;
  String member_name;
  String? member_img;
  String content;
  String? image1;
  String? image2;
  String? socon_img;
  DateTime create_at;
  DateTime expired_at;
  bool expired;

  SogonDetail(
      {required this.id,
      required this.title,
      required this.member_name,
      this.member_img,
      required this.content,
      this.image1,
      this.image2,
      required this.socon_img,
      required this.create_at,
      required this.expired_at,
      required this.expired});

  // JSON 데이터를 SogonComment 객체로 변환
  factory SogonDetail.fromJson(Map<String, dynamic> json) => SogonDetail(
        id: json['id'],
        title: json['title'],
        member_name: json['member_name'],
        member_img: json['member_img'],
        content: json['content'],
        image1: json['image1'],
        image2: json['image2'],
        socon_img: json['socon_img'],
        create_at: DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(json['create_at']),
        expired_at:
            DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(json['expired_at']),
        expired: json['expired'],
      );

  // User 객체를 JSON 데이터로 변환
  Map<String, dynamic> toJson() => {
        'id': id,
        'member_name': member_name,
        'member_img': member_img,
        'content': content,
        'image1': image1,
        'image2': image2,
        'socon_img': socon_img,
        'create_at': create_at,
        'expired_at': expired_at,
        'expired': expired,
      };

  @override
  String toString() {
    return 'SogonDetail{id: $id, title: $title, member_name: $member_name, member_img: $member_img, content: $content, image1: $image1, image2: $image2, socon_img: $socon_img, create_at: $create_at, expired_at: $expired_at, expired: $expired}';
  }
}
