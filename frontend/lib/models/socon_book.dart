import 'package:intl/intl.dart';

class SoconBook {
  int socon_id;
  String item_name;
  String store_name;
  DateTime expired_at;
  String status;
  String item_image;

  SoconBook(
      {required this.socon_id,
      required this.item_name,
      required this.store_name,
      required this.expired_at,
      required this.status,
      required this.item_image});

  factory SoconBook.fromJson(Map<String, dynamic> json) {
    return SoconBook(
      socon_id: json['socon_id'],
      item_name: json['item_name'],
      store_name: json['store_name'],
      expired_at: DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(json['expired_at']),
      status: json['status'],
      item_image: json['item_image'],
    );
  }

  // User 객체를 JSON 데이터로 변환
  Map<String, dynamic> toJson() => {
        'socon_id': socon_id,
        'item_name': item_name,
        'store_name': store_name,
        'expired_at': expired_at,
        'status': status,
        'item_image': item_image,
      };

  @override
  String toString() {
    return 'SoconBook{socon_id: $socon_id, item_name: $item_name, store_name: $store_name, expired_at: $expired_at, status: $status, item_image: $item_image}';
  }
}
