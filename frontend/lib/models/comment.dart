class SogonComment {
  int id;
  String content;
  String member_name;
  String? member_img;
  bool is_picked;

  SogonComment(
      {required this.id,
      required this.content,
      required this.member_name,
      this.member_img,
      required this.is_picked});

  // JSON 데이터를 SogonComment 객체로 변환
  factory SogonComment.fromJson(Map<String, dynamic> json) => SogonComment(
        id: json['id'],
        content: json['content'],
        member_name: json['member_name'],
        member_img: json['member_img'],
        is_picked: json['is_picked'],
      );

  // User 객체를 JSON 데이터로 변환
  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'member_name': member_name,
        'member_img': member_img,
        'is_picked': is_picked,
      };

  @override
  String toString() {
    return 'SogonComment{id: $id, content: $content, member_name: $member_name, member_img: $member_img, is_picked: $is_picked}';
  }
}
