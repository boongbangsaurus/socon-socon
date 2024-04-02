

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
    'business_hour': businessHours,
    // 'business_hour': businessHours.map((bh) => bh.toJson()).toList(),
  };

  @override
  String toString() {
    return 'StoreRegisterModel{name: $name, category: $category, image: $image, phoneNumber: $phoneNumber, address: $address, lat: $lat, lng: $lng, introduction: $introduction, registrationNumberId: $registrationNumberId, businessHours: $businessHours}';
  }
}

class BusinessHour {
  String day;
  bool is_working;
  String? open_at;
  String? close_at;
  bool is_breaktime;
  String? breaktime_start;
  String? breaktime_end;

  BusinessHour({
    required this.day,
    this.is_working = false,
    this.open_at,
    this.close_at,
    this.is_breaktime = false,
    this.breaktime_start,
    this.breaktime_end,
  });

  Map<String, dynamic> toJson() => {
    'day': day,
    'is_working': is_working,
    'open_at': open_at,
    'close_at': close_at,
    'is_breaktime': is_breaktime,
    'breaktime_start': breaktime_start,
    'breaktime_end': breaktime_end,
  };
}
