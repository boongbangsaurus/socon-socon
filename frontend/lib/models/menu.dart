class Menu {
  int id; // 상품 id
  String name; // 상품 이름
  String imageUrl; // 이미지 Url
  int price; // 상품 가격

  Menu(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.price});

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json['id'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        price: json['price'],
      );

  @override
  String toString() {
    return 'Menu{id: $id, name: $name, image: $imageUrl, price: $price}';
  }
}

// 더미데이터
// {
// "id": 0, // 상품 id
// "name": "상품 이름",
// "image": "https://cataas.com/cat",
// "price": 3000 // 상품 가격
// },
