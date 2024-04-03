class SogonDetail {
  int id;
  String title;
  String member_name;
  String? member_img;
  String content;
  String? image1;
  String? image2;
  String? socon_img;
  DateTime create_at;
  DateTime expried_at;
  bool expired;

  SogonDetail(
      {required this.id,
      required this.title,
      required this.member_name,
      this.member_img,
      required this.content,
      this.image1,
      this.image2,
      required this.socon_img,
      required this.create_at,
      required this.expried_at,
      required this.expired});
}
