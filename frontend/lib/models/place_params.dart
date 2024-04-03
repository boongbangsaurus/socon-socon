import 'dart:convert';

class PlaceParmas {
  String content;
  double lat;
  double lng;
  String searchType;
  String sort;
  bool isFavoriteSearch;
  int page;
  int size;

  PlaceParmas({
    required this.content,
    required this.lat,
    required this.lng,
    required this.searchType,
    required this.sort,
    required this.isFavoriteSearch,
    required this.page,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    return {
      "content": content,
      "lat": lat,
      "lng": lng,
      "searchType": searchType,
      "sort": sort,
      "isFavoriteSearch": isFavoriteSearch,
      "page": page,
      "size": size,
    };
  }
}


