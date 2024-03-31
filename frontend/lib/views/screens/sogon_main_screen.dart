import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:socon/models/location.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/viewmodels/sogon_list_view_model.dart';
import 'package:socon/views/atoms/bottom_sheet.dart';
import 'package:socon/views/atoms/buttons.dart';

class SogonMainScreen extends StatefulWidget {
  const SogonMainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SogonMainScreen();
  }
}

class _SogonMainScreen extends State<SogonMainScreen> {
  GoogleMapController? _controller; // 지도 컨트롤러
  Location _location = Location(); // 내 위치
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _requestLocationPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _updateMapForCurrentLocation();
    _getCurrentLocation();
    _loadMarkers();
  }

  Future<void> _updateMapForCurrentLocation() async {
    var currentLocation = await _location.getLocation();

    _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
      zoom: 18.0,
    )));
  }

  Future<LatLng> _getCurrentLocation() async {
    var currentLocation = await _location.getLocation();
    return LatLng(currentLocation.latitude!, currentLocation.longitude!);
  }

  Future<void> _loadMarkers() async {
    var currentLocation = await _location.getLocation();
    SogonListViewModel sogonListViewModel = SogonListViewModel();
    Locations now = Locations(
        lat: currentLocation.latitude!, lng: currentLocation.longitude!);
    // List? sogons = await
    print("############## now Locations ##############");
    print(now);
    print("############## now Locations ##############");

    print("############## markers ##############");
    final res = await sogonListViewModel.sogonList(now);
    print(res);
    // _markers에 res값 넣기
    var dataBody = [
      {
        "id": 1,
        "lat": 35.20519604171862,
        "lng": 126.81215629814739,
        "title": "제목1",
        "lastTime": 24,
        "memberName": "휘리릭",
        "commentCount": 0,
        "soconImg": "https://cataas.com/cat",
        "isPicked": false
      },
      {
        "id": 2,
        "lat": 35.20489776089751,
        "lng": 126.81161887941315,
        "title": "제목2",
        "lastTime": 24,
        "memberName": "휘리릭",
        "commentCount": 2,
        "soconImg": "https://cataas.com/cat",
        "isPicked": false
      },
      {
        "id": 3,
        "lat": 35.205149094313924,
        "lng": 126.8109484103492,
        "title": "제목3",
        "lastTime": 24,
        "memberName": "onyu",
        "commentCount": 0,
        "soconImg": "https://cataas.com/cat",
        "isPicked": false
      },
    ];
    setState(() {
      _markers = dataBody.map((item) {
        return Marker(
          markerId: MarkerId(item["id"].toString()),
          position: LatLng(
            (item["lat"] as num).toDouble(), // num 타입으로 캐스팅 후, toDouble() 호출
            (item["lng"] as num).toDouble(), // num 타입으로 캐스팅 후, toDouble() 호출
          ),
          infoWindow: InfoWindow(
            title: item["title"].toString(),
            snippet: item["memberName"].toString(),
          ),
          // 마커 아이콘 설정 등 추가적인 설정 가능
        );
      }).toList();
    });
    print("############## markers ##############");

    return;
  }

  // BottomSheet Header
  final Widget _header = Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6.0, bottom: 8.0),
            width: 50.0,
            height: 6.5,
            decoration: BoxDecoration(
                color: Colors.black45, borderRadius: BorderRadius.circular(50)),
          ),
          // bottom header Title Text - nullable
          Text("내 주변 소곤을 확인해보세요!"),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
        height: height,
        width: width,
        child: SafeArea(
            child: Scaffold(
                body: FutureBuilder<LatLng>(
                    future: _getCurrentLocation(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("위치 정보를 가져오는 데 실패했습니다."));
                      } else {
                        return Stack(
                          children: <Widget>[
                            GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                target: snapshot.data!,
                                zoom: 18.0,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _controller = controller;
                              },
                              markers: Set.from(_markers),
                              myLocationEnabled: true,
                              myLocationButtonEnabled: false,
                            ),
                            Container(
                                padding:
                                    const EdgeInsets.only(top: 12, left: 12),
                                alignment: Alignment.topLeft,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.BLACK,
                                    foregroundColor: AppColors.WHITE,
                                    textStyle: const TextStyle(
                                        fontSize: FontSizes.XXXSMALL,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () => GoRouter.of(context).go('/'),
                                  child: const Text(
                                    '나가기',
                                  ),
                                )),
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 12, right: 12),
                              alignment: Alignment.topRight,
                              child: FloatingActionButton(
                                backgroundColor: AppColors.WHITE,
                                onPressed: () => _updateMapForCurrentLocation(),
                                child: const Icon(Icons.gps_fixed),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                            Positioned(
                              left: 0.0,
                              right: 0.0,
                              bottom: 0.0,
                              child: CustomBottomSheet(
                                // maxHeight: _size.height * 0.745,
                                maxHeight: height * 0.15,
                                headerHeight: 50.0,
                                header: _header,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0)),
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10.0,
                                      spreadRadius: -1.0,
                                      offset: Offset(0.0, 3.0)),
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4.0,
                                      spreadRadius: -1.0,
                                      offset: Offset(0.0, 0.0)),
                                ],
                                children: [
                                  Row(
                                    children: [
                                      BasicButton(
                                        onPressed: () {},
                                        text: 'hi',
                                      ),
                                      BasicButton(
                                        onPressed: () {},
                                        text: 'hi',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    }))));
  }
}
