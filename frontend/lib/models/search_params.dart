class SearchParams {
  final String content;
  late final double lat;
  late final double lng;
  final String searchType;
  final String sort;
  final bool isFavoriteSearch;
  final int page;
  final int size;

  SearchParams({
    required this.content,
    required this.lat,
    required this.lng,
    required this.searchType,
    required this.sort,
    required this.isFavoriteSearch,
    required this.page,
    required this.size,
  });

  factory SearchParams.fromJson(Map<String, dynamic> json) {
    return SearchParams(
      content: json['content'],
      lat: json['lat'],
      lng: json['lng'],
      searchType: json['searchType'],
      sort: json['sort'],
      isFavoriteSearch: json['isFavoriteSearch'],
      page: json['page'],
      size: json['size'],
    );
  }

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

  @override
  String toString() {
    return 'SearchParams{content: $content, lat: $lat, lng: $lng, searchType: $searchType, sort: $sort, isFavoriteSearch: $isFavoriteSearch, page: $page, size: $size}';
  }
}
