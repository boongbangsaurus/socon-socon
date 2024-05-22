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
      return Store(
        storeId: json['store_id'] as int,
        name: json['name'] as String,
        imageUrl: json['image_url'] as String,
        address: json['address'] as String?,
        category: json['category'] as String,
        createdAt: json['created_at'] as String?,
        isLike: json['is_like'] as bool,
        mainSocon: json['main_socon'] as String?,
        distance: json['distance'] as int? ?? 0,
      );
    } on FormatException catch (error) {
      print("형 변환 에러 $error");
      rethrow;
    }
  }

  @override
  String toString() {
    return 'Store{storeId: $storeId, name: $name, imageUrl: $imageUrl, address: $address, category: $category, createdAt: $createdAt, isLike: $isLike, mainSocon: $mainSocon, distance: $distance}';
  }
}
