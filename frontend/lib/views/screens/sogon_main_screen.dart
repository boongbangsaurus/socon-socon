import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:socon/models/location.dart';
import 'package:socon/models/sogon_place.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/icons.dart';
import 'package:socon/viewmodels/sogon_view_model.dart';
import 'package:socon/views/atoms/bottom_sheet.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/atoms/image_card.dart';

import '../../models/locations.dart';

class SogonMainScreen extends StatefulWidget {
  const SogonMainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SogonMainScreen();
  }
}

class _SogonMainScreen extends State<SogonMainScreen> {
  Location _location = Location(); // 내 위치
  List<dynamic> _sogons = []; // 소곤 리스트 바텀 시트
  // ###### google_maps_cluster_manager
  Set<Marker> sogonMarker = {}; // 소곤 위치 마커
  List<SogonPlace> sogonItems = []; // 소곤 마커 정보
  late ClusterManager _manager; // 클러스터링 매니저
  Completer<GoogleMapController> _controller = Completer(); // 구글 맵 컨트롤러

  // 지도 좌표 초기화
  final CameraPosition _initCameraPosition =
      CameraPosition(target: LatLng(35.2041112343, 126.807181835), zoom: 15);
  Future<void>? _initFuture;

  // 현재 위치 받기
  Future<LatLng> _getCurrentLocation() async {
    var currentLocation = await _location.getLocation();
    return LatLng(currentLocation.latitude!, currentLocation.longitude!);
  }

  // 소곤 정보 받기
  Future<void> _loadMarkers() async {
    var currentLocation = await _location.getLocation();
    SogonViewModel sogonViewModel = SogonViewModel();
    Locations now = Locations(
        lat: currentLocation.latitude!, lng: currentLocation.longitude!);
    print("############## load markers ##############");
    print("############## now sogons list ##############");
    final res = await sogonViewModel.sogonList(now);
    print(res);
    print("############## now sogons list ##############");

    setState(() {
      if (res == null) {
        _sogons = [];
        return;
      }
      _sogons = res!;
      sogonItems = _sogons.map((item) {
        return SogonPlace(
            id: item["id"],
            latLng: LatLng(
              (item["lat"] as num).toDouble(),
              (item["lng"] as num).toDouble(),
            ),
            soconImg: item['socon_img'].toString(),
            memberName: item['member_name'].toString(),
            lastTime: item['last_time'],
            isPicked: item['is_picked'],
            commentCount: item['comment_count'],
            title: item['title']);
      }).toList();
    });
    print(sogonItems);
    print("############## load markers ##############");
    return;
  }

  @override
  void initState() {
    _requestLocationPermission();
    _refreshData();
    super.initState();
  }

  void _refreshData() {
    setState(() {
      _initFuture = _initializeAsync();
    });
  }

  Future<void> _initializeAsync() async {
    ClusterManager<ClusterItem> manager = await _initClusterManager();
    setState(() {
      _manager = manager;
    });
  }

  Future<List?> getSogonList() async {
    var currentLocation = await _location.getLocation();
    Locations now = Locations(
        lat: currentLocation.latitude!, lng: currentLocation.longitude!);
    SogonViewModel sogonViewModel = SogonViewModel();
    final res = await sogonViewModel.sogonList(now);

    return res;
  }

  Future<ClusterManager<ClusterItem>> _initClusterManager() async {
    // var currentLocation = await _location.getLocation();
    // SogonViewModel sogonViewModel = SogonViewModel();
    // Locations now = Locations(
    //     lat: currentLocation.latitude!, lng: currentLocation.longitude!);
    print("############## load markers ##############");
    print("############## now sogons list ##############");
    final res = await getSogonList();
    print(res);
    print("############## now sogons list ##############");
    // BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
    //     const ImageConfiguration(), "assets/images/sogonMarker.png");

    setState(() {
      if (res == null) {
        _sogons = [];
        return;
      }
      _sogons = res!;
      sogonItems = _sogons.map((item) {
        return SogonPlace(
            id: item["id"],
            latLng: LatLng(
              (item["lat"] as num).toDouble(),
              (item["lng"] as num).toDouble(),
            ),
            soconImg: item['socon_img'].toString(),
            memberName: item['member_name'].toString(),
            lastTime: item['last_time'],
            isPicked: item['is_picked'],
            commentCount: item['comment_count'],
            title: item['title']);
      }).toList();
    });
    return ClusterManager<SogonPlace>(
      sogonItems,
      _updateMarkers,
      markerBuilder: _markerBuilder,
      levels: [8, 10, 12, 14, 14.5, 15, 16.75, 18.25, 19.5, 20],
      extraPercent: 0.15,
    );
  }

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    setState(() {
      this.sogonMarker = markers;
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

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
    // _updateMapForCurrentLocation();
    // _getCurrentLocation();
    // _loadMarkers();
    // _manager = _initClusterManager();
  }

  Future<Marker> Function(dynamic) get _markerBuilder => (cluster) async {
        String iconPath;
        print('#######################count ');
        print(cluster.count);
        print('#######################count ');
        if (cluster.isMultiple && cluster.count >= 10) {
          iconPath = "assets/images/bukjeokMarker.png";
        } else if (cluster.isMultiple && cluster.count >= 3) {
          iconPath = "assets/images/sugeunMarker.png";
        } else {
          iconPath = "assets/images/sogonMarker.png";
        }
        BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), iconPath);
        return Marker(
          markerId: MarkerId(cluster.isMultiple
              ? cluster.getId()
              : cluster.items.single.id.toString()),
          position: cluster.location,
          onTap: () {
            print('---- $cluster');
            cluster.items.forEach((p) => print(p));
          },
          icon: markerIcon,
          infoWindow: cluster.isMultiple
              ? InfoWindow()
              : InfoWindow(title: cluster.items.single.title),
        );
      };

  // 현재 위치 업데이트
  // Future<void> _updateMapForCurrentLocation() async {
  //   var currentLocation = await _location.getLocation();
  //
  //   _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //     target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
  //     zoom: 18.0,
  //   )));
  // }

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
                body: FutureBuilder<void>(
                    future: _initFuture, // FutureBuilder를 사용하여 비동기 초기화
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('오류가 발생했습니다.'),
                            SizedBox(
                              height: 40,
                            ),
                            BasicButton(
                              text: '돌아가기',
                              onPressed: () {
                                _refreshData();
                                GoRouter.of(context).go('/');
                              },
                            )
                          ],
                        ));
                      } else {
                        return Stack(
                          children: <Widget>[
                            GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: _initCameraPosition,
                              // CameraPosition(
                              //   target: snapshot.data!,
                              //   zoom: 18.0,
                              // ),
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                                // _manager = _initClusterManager();
                                _manager.setMapId(controller.mapId);
                              },
                              onCameraMove: _manager.onCameraMove,
                              onCameraIdle: _manager.updateMap,
                              // markers: Set.from(_markers),
                              markers: sogonMarker,
                              myLocationEnabled: true,
                              myLocationButtonEnabled: false,
                              zoomControlsEnabled: false,
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
                                  onPressed: () {
                                    GoRouter.of(context).go('/');
                                  },
                                  child: const Text(
                                    '나가기',
                                  ),
                                )),
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 12, right: 12),
                              alignment: Alignment.topRight,
                              child: FloatingActionButton(
                                heroTag: "nowLocation",
                                backgroundColor: AppColors.WHITE,
                                onPressed: () {
                                  // _updateMapForCurrentLocation();
                                  _loadMarkers();
                                },
                                child: const Icon(Icons.gps_fixed),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                            Positioned(
                              left: 0.0,
                              right: 0.0,
                              bottom: 0.0,
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    alignment: Alignment.centerRight,
                                    child: FloatingActionButton(
                                      heroTag: "register",
                                      child: Icon(AppIcons.PLUS),
                                      backgroundColor: AppColors.WHITE,
                                      onPressed: () {
                                        print('go 새글작성');
                                        GoRouter.of(context)
                                            .push('/sogon/register');
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                  ),
                                  CustomBottomSheet(
                                    // maxHeight: _size.height * 0.745,
                                    maxHeight: _sogons.isNotEmpty
                                        ? height * 0.22
                                        : height * 0.13,
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
                                      _sogons.isNotEmpty
                                          ? Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 168,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: _sogons.length,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      final GoogleMapController
                                                          controller =
                                                          await _controller
                                                              .future; // GoogleMapController 인스턴스를 얻음
                                                      controller.moveCamera(
                                                        CameraUpdate
                                                            .newLatLngZoom(
                                                          LatLng(
                                                            (_sogons[index]
                                                                        ['lat']
                                                                    as num)
                                                                .toDouble(),
                                                            (_sogons[index]
                                                                        ['lng']
                                                                    as num)
                                                                .toDouble(),
                                                          ),
                                                          18.0,
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 100,
                                                      height: 100,
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          ImageCard(
                                                            imgUrl: _sogons[
                                                                        index][
                                                                    'socon_img']
                                                                .toString(),
                                                            borderRadius: 50,
                                                          ),
                                                          Text(
                                                            _sogons[index]
                                                                ["title"],
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          TextButton(
                                                              onPressed: () {
                                                                print(_sogons[
                                                                        index]
                                                                    ["id"]);
                                                                GoRouter.of(
                                                                        context)
                                                                    .push(
                                                                        '/sogon/${_sogons[index]["id"]}');
                                                              },
                                                              style: TextButton
                                                                  .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .BLACK,
                                                                foregroundColor:
                                                                    AppColors
                                                                        .WHITE,
                                                                textStyle: const TextStyle(
                                                                    fontSize:
                                                                        FontSizes
                                                                            .XXXSMALL,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              child: const Text(
                                                                  '글 보기')),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ))
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                  Text('주변에 소곤이 없어요..'),
                                                  BasicButton(
                                                    text: '새 소곤 작성하러 가기',
                                                    onPressed: () {
                                                      GoRouter.of(context).push(
                                                          '/sogon/register');
                                                    },
                                                  )
                                                ])
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
