import 'dart:convert';

class MyStoreListModel {
  final int id;

  @override
  String toString() {
    return 'MyStoreListModel{id: $id, name: $name, category: $category, image: $image, created_at: $created_at}';
  }

  final String name;
  final String category;
  final String image;
  final DateTime? created_at;

  MyStoreListModel({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    this.created_at,
  });

  // json -> 객체 변환 (get 요청시 필요)
  factory MyStoreListModel.fromJson(Map<String, dynamic> json) => MyStoreListModel(
    id: json['id'],
    name: json['name'],
    category: json['category'],
    image: json['image'] ?? '',
    created_at: DateTime.parse(json['created_at'])
  );

}



// 예시 데이터 리스트
final List<MyStoreListModel> stores = [
  MyStoreListModel(id : 0, name: '오소유', category: '빵집', image: "https://cataas.com/cat"),
  MyStoreListModel(id : 1, name: '국가대표 짬뽕', category: '짬뽕', image: "https://cataas.com/cat"),
];
