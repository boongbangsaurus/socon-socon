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
}


// 더미데이터
// {
//   "store_id": 0,
//   "name": "늘솜꼬마김밥",
//   "imageUrl": "https://cataas.com/cat", // 매장 대표 이미지 없을 경우 null
//   "address" : "광주 광산구 장덕로40번길 13-1 1층"
//   "category": "음식점",
//   "created_at": "YYYY-MM-DD" // 등록일,
//   "isLike" : true,
//   "mainSocon" : "소금빵",
//   "distance" : 15
// }