

// 소콘 상세보기 model
class ProductDetailModel {
  final int id;
  final String name;
  final String image;
  final int price;
  final String summary;
  final String description;

  ProductDetailModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.summary,
    required this.description,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      summary: json['summary'],
      description: json['description'],
    );
  }
}
