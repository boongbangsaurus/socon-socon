/// [BusinessOwner]
/// 사용자 정보 Class
class BusinessOwner {
  String owner; // 대표자 성함
  String registrationNumberId; // 아이디
  String registrationNumber; // 사업자 등록 번호
  String registrationAddress; // 등록 주소
  // String startDate;

  // 생성자
  BusinessOwner({
    required this.owner,
    required this.registrationNumberId,
    required this.registrationNumber,
    required this.registrationAddress,
    // required this.startDate,
  });

  // JSON에서 BusinessOwner 객체로 변환
  factory BusinessOwner.fromJson(Map<String, dynamic> json) {
    return BusinessOwner(
      owner: json['owner'] as String,
      registrationNumberId: json['registrationNumberId'] as String,
      registrationNumber: json['registrationNumber'] as String,
      registrationAddress: json['registrationAddress'] as String,
      // startDate: json['startDate'] as String,
    );
  }

  // BusinessOwner 객체에서 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'owner': owner,
      'registrationNumberId': registrationNumberId,
      'registrationNumber': registrationNumber,
      'registrationAddress': registrationAddress,
      // 'startDate': startDate,
    };
  }
}
