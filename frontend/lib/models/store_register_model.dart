

/// 가게 등록 모델
class StoreRegisterModel {
  String name;
  String category;
  String image;
  String phoneNumber;
  String address;
  double lat;
  double lng;
  String introduction;
  int registrationNumberId;
  List businessHours;

  StoreRegisterModel({
    this.name = '',
    this.category = '',
    this.image = '',
    this.phoneNumber = '',
    this.address = '',
    this.lat = 0.0,
    this.lng = 0.0,
    this.introduction = '',
    this.registrationNumberId = 0,
    this.businessHours = const [],
  });


  Map<String, dynamic> toJson() => {
    'name': name,
    'category': category,
    'image': image,
    'phone_number': phoneNumber,
    'address': address,
    'lat': lat,
    'lng': lng,
    'introduction': introduction,
    'registration_number_id': registrationNumberId,
    'business_hour': businessHours.map((bh) => bh.toJson()).toList(),
  };

  @override
  String toString() {
    return 'StoreRegisterModel{name: $name, category: $category, image: $image, phoneNumber: $phoneNumber, address: $address, lat: $lat, lng: $lng, introduction: $introduction, registrationNumberId: $registrationNumberId, businessHours: $businessHours}';
  }
}

class BusinessHour {
  String day;
  bool isWorking;
  String? openAt;
  String? closeAt;
  bool isBreaktime;
  String? breaktimeStart;
  String? breaktimeEnd;

  BusinessHour({
    required this.day,
    this.isWorking = false,
    this.openAt,
    this.closeAt,
    this.isBreaktime = false,
    this.breaktimeStart,
    this.breaktimeEnd,
  });

  Map<String, dynamic> toJson() => {
    'day': day,
    'is_working': isWorking,
    'open_at': openAt,
    'close_at': closeAt,
    'is_breaktime': isBreaktime,
    'breaktime_start': breaktimeStart,
    'breaktime_end': breaktimeEnd,
  };
}
