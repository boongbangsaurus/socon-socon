class Menu {
  int id; // 상품 id
  String name; // 상품 이름
  String imageUrl; // 이미지 Url
  int price; // 상품 가격
  String summary; // 한줄설명
  String description; // 상세 설명
  String itemUrl;

  Menu(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.itemUrl,
      required this.price,
      this.summary = "",
      this.description = ""});

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json['id'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        itemUrl: json['itemUrl'] ?? "",
        price: json['price'],
        summary: json["summary"] ?? "",
        description: json["description"] ?? "",
      );

  @override
  String toString() {
    return 'Menu{id: $id, name: $name, imageUrl: $imageUrl, price: $price, summary: $summary, description: $description, itemUrl: $itemUrl}';
  }
}

// 더미데이터
// {
// "id": 0, // 상품 id
// "name": "상품 이름",
// "image": "https://cataas.com/cat",
// "price": 3000 // 상품 가격
// },
