class Socon {
  // 필수
  final String? soconName;
  final int? price;    // 가격 String? int??
  final String? imageUrl;
  // 선택
  final String? storeName;
  final String? dueDate;
  final bool? isMain;
  final int? maxQuantity;
  final int? issuedQuantity;
  final bool? isDiscounted;
  final int? discountedPrice;    // type??
  final DateTime? createdAt;

  Socon({
    required this.soconName,
    required this.imageUrl,
    required this.price,
    // 선택적인 필드들
    this.storeName,
    this.dueDate,
    this.isMain = false,
    this.maxQuantity = 0,
    this.issuedQuantity = 0,
    this.isDiscounted = false,
    this.discountedPrice,
    this.createdAt,
  });
}


final List<Socon> socons = [
  Socon(soconName : '소금빵', imageUrl:'https://cataas.com/cat', price: 3000, isMain: true, maxQuantity: 10, issuedQuantity: 2, isDiscounted: true, discountedPrice: 2400, createdAt: DateTime.parse('2024-05-23')),
  Socon(soconName : '마카롱', imageUrl:'https://cataas.com/cat', price: 5000, isMain: false, maxQuantity: 20, issuedQuantity: 5, isDiscounted: false, discountedPrice: 4400, createdAt: DateTime.parse('2024-05-23')),
  Socon(soconName : '콜라', imageUrl:'https://cataas.com/cat', price: 7000, isMain: false, maxQuantity: 10, issuedQuantity: 2, isDiscounted: true, discountedPrice: 1000, createdAt: DateTime.parse('2024-05-23')),
  Socon(soconName : '치킨', imageUrl:'https://cataas.com/cat', price: 30000, isMain: false, maxQuantity: 10, issuedQuantity: 9, isDiscounted: false, discountedPrice: 20000, createdAt: DateTime.parse('2024-05-23')),
  Socon(soconName : '치킨', imageUrl:'https://cataas.com/cat', price: 30000, isMain: false, maxQuantity: 10, issuedQuantity: 9, isDiscounted: false, discountedPrice: 20000, createdAt: DateTime.parse('2024-05-23')),
  Socon(soconName : '치킨', imageUrl:'https://cataas.com/cat', price: 30000, isMain: false, maxQuantity: 10, issuedQuantity: 9, isDiscounted: false, discountedPrice: 20000, createdAt: DateTime.parse('2024-05-23')),
  Socon(soconName : '치킨', imageUrl:'https://cataas.com/cat', price: 30000, isMain: false, maxQuantity: 10, issuedQuantity: 9, isDiscounted: false, discountedPrice: 20000, createdAt: DateTime.parse('2024-05-23')),
  Socon(soconName : '치킨', imageUrl:'https://cataas.com/cat', price: 30000, isMain: false, maxQuantity: 10, issuedQuantity: 9, isDiscounted: false, discountedPrice: 20000, createdAt: DateTime.parse('2024-05-23')),
  Socon(soconName : '치킨', imageUrl:'https://cataas.com/cat', price: 30000, isMain: false, maxQuantity: 10, issuedQuantity: 9, isDiscounted: false, discountedPrice: 20000, createdAt: DateTime.parse('2024-05-23')),
];