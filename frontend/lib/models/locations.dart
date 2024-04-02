/// [Location]
/// 위치 정보 Class
class Locations {
  double lat; // 위도
  double lng; // 경도

  Locations({
    required this.lat,
    required this.lng,
  });

  // JSON 데이터를 Location 객체로 변환
  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        lat: json['lat'],
        lng: json['lng'],
      );

  // Location 객체를 JSON 데이터로 변환
  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  @override
  String toString() {
    return 'Locations{lat: $lat, lng: $lng}';
  }
}
