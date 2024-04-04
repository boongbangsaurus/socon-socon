// class Store {
//   final int storeId;
//   final String name;
//   final String imageUrl;
//   final String? address;
//   final String category;
//   final String? createdAt;
//   final bool isLike;
//   final String? mainSocon;
//   final int? distance;
//
//   Store({
//     required this.storeId,
//     required this.name,
//     required this.imageUrl,
//     this.address = "",
//     required this.category,
//     this.createdAt = "",
//     required this.isLike,
//     this.mainSocon = "",
//     this.distance = 0,
//   });
//
//   factory Store.fromJson(Map<String, dynamic> json) {
//     print("스스스토토토 $json");
//     print(
//         """========== ${json['store_id'].runtimeType} ==========
//           store_id : ${json['store_id']}, ${json['store_id'].runtimeType}
//           name : ${json['name']}, ${json['name'].runtimeType}
//           image_url : ${json['image_url']}, ${json['image_url'].runtimeType}
//           address : ${json['address']}, ${json['address'].runtimeType}
//           category : ${json['category']}, ${json['category'].runtimeType}
//           created_at : ${json['created_at']}, ${json['created_at'].runtimeType}
//           is_like : ${json['is_like']}, ${json['is_like'].runtimeType}
//           main_socon : ${json['main_socon']}, ${json['main_socon'].runtimeType}
//           distance : ${json['distance']}, ${json['distance'].runtimeType}
//         """);
//     return Store(
//       storeId: json['store_id'] as int,
//       name: json['name'] as String,
//       imageUrl: json['image_url'] as String,
//       address: json['address'] as String?,
//       category: json['category'] as String,
//       createdAt: json['created_at'] as String?,
//       isLike: json['is_like'] as bool,
//       mainSocon: json['main_socon'] as String?,
//       distance: json['distance'] as int ?? 0,
//     );
//   }
//
//   @override
//   String toString() {
//     return 'Store{storeId: $storeId, name: $name, imageUrl: $imageUrl, address: $address, category: $category, createdAt: $createdAt, isLike: $isLike, mainSocon: $mainSocon, distance: $distance}';
//   }
// }



class Store {
  final int storeId;
  final String name;
  final String imageUrl;
  final String? address;
  final String category;
  final String? createdAt;
  final bool isLike;
  final String? mainSocon;
  final int? distance;

  Store({
    required this.storeId,
    required this.name,
    required this.imageUrl,
    this.address = "",
    required this.category,
    this.createdAt = "",
    required this.isLike,
    this.mainSocon = "",
    this.distance = 0,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    print("JSON 입력: $json");
    try {
      final storeId = json['store_id'] as int;
      print("store_id 변환 성공: $storeId");

      final name = json['name'] as String;
      print("name 변환 성공: $name");

      final imageUrl = json['image_url'] as String;
      print("image_url 변환 성공: $imageUrl");

      final address = json['address'] as String?;
      print("address 변환 성공: $address");

      final category = json['category'] as String;
      print("category 변환 성공: $category");

      final createdAt = json['created_at'] as String?;
      print("created_at 변환 성공: $createdAt");

      final isLike = json['is_like'] as bool;
      print("is_like 변환 성공: $isLike");

      final mainSocon = json['main_socon'] as String?;
      print("main_socon 변환 성공: $mainSocon");

      final distance = json['distance'] as int?;
      print("distance 변환 성공: $distance");

      return Store(
        storeId: storeId,
        name: name,
        imageUrl: imageUrl,
        address: address,
        category: category,
        createdAt: createdAt,
        isLike: isLike,
        mainSocon: mainSocon,
        distance: distance ?? 0,
      );
    } catch (e) {
      print("형변환 중 에러 발생: $e");
      rethrow; // 에러를 다시 발생시켜 호출자에게 전달
    }
  }

  @override
  String toString() {
    return 'Store{storeId: $storeId, name: $name, imageUrl: $imageUrl, address: $address, category: $category, createdAt: $createdAt, isLike: $isLike, mainSocon: $mainSocon, distance: $distance}';
  }
}
