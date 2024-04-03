class SogonRegister {
  String title;
  String content;
  String? image1;
  String? image2;
  double? lat;
  double? lng;
  int? socon_id;

  SogonRegister(
      {required this.title,
      required this.content,
      this.image1,
      this.image2,
      required this.lat,
      required this.lng,
      required this.socon_id});

  // JSON 데이터를 User 객체로 변환
  factory SogonRegister.fromJson(Map<String, dynamic> json) => SogonRegister(
        title: json['title'],
        content: json['content'],
        image1: json['image1'],
        image2: json['image2'],
        lat: json['lat'],
        lng: json['lng'],
        socon_id: json['socon_id'],
      );

  // User 객체를 JSON 데이터로 변환
  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'image1': image1,
        'image2': image2,
        'lat': lat,
        'lng': lng,
        'socon_id': socon_id,
      };

  @override
  String toString() {
    return 'SogonRegister{title: $title, content: $content, image1: $image1, image2: $image2, lat: $lat, lng: $lng, socon_id: $socon_id}';
  }
}
