class Store {
  final int storeId;
  final String name;
  final String tag;
  final String imageUrl;

  Store({required this.storeId, required this.name, required this.tag, required this.imageUrl});
}


// 예시 데이터 리스트
final List<Store> stores = [
  Store(storeId : 0, name: '오소유', tag: '빵집', imageUrl: "https://cataas.com/cat"),
  Store(storeId : 1, name: '국가대표 짬뽕', tag: '짬뽕', imageUrl: "https://cataas.com/cat"),
];
