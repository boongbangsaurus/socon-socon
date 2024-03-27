/// [User]
/// 사용자 정보 Class
class User {
  String email; // 아이디
  String password; // 비밀번호
  String name; // 이름
  String nickname; // 닉네임
  int phoneNumber; // 전화번호
  bool isAgreed; // 개인정보동의

  User({
    required this.email,
    required this.password,
    required this.name,
    required this.nickname,
    required this.phoneNumber,
    required this.isAgreed,
  });

  // JSON 데이터를 User 객체로 변환
  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        password: json['password'],
        name: json['name'],
        nickname: json['nickname'],
        phoneNumber: json['phoneNumber'],
        isAgreed: json['isAgreed'],
      );

  // User 객체를 JSON 데이터로 변환
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'nickname': nickname,
        'phoneNumber': phoneNumber,
        'isAgreed': isAgreed,
      };
}
