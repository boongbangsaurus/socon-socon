class Store {
  final int storeId;
  final String name;
  final String imageUrl;
  final String address;
  final String category;
  final String createdAt;
  final bool isLike;
  final String mainSocon;
  final int distance;

  Store({
    required this.storeId,
    required this.name,
    this.imageUrl = "https://cataas.com/cat",
    required this.address,
    required this.category,
    required this.createdAt,
    required this.isLike,
    required this.mainSocon,
    required this.distance,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      storeId: json['store_id'],
      name: json['name'],
      imageUrl: json['imageUrl'] ?? "https://cataas.com/cat",
      address: json['address'],
      category: json['category'],
      createdAt: json['created_at'],
      isLike: json['isLike'],
      mainSocon: json['mainSocon'],
      distance: json['distance'],
    );
  }

  @override
  String toString() {
    return 'Store{storeId: $storeId, name: $name, imageUrl: $imageUrl, address: $address, category: $category, createdAt: $createdAt, isLike: $isLike, mainSocon: $mainSocon, distance: $distance}';
  }
}
