import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SogonMainScreen extends StatefulWidget {
  const SogonMainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SogonMainScreen();
  }
}

class _SogonMainScreen extends State<SogonMainScreen> {
  // @override
  // void dispose() {
  //   // Google Maps 관련 리소스 해제 코드
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              key: UniqueKey(), // 이렇게 UniqueKey를 할당합니다.
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(37.50508097213444, 126.95493073306663),
                zoom: 15.0,
              ),
              // myLocationEnabled: true,
              // myLocationButtonEnabled: true,
            ),
            FloatingActionButton(
                onPressed: () => context.go('/'), child: const Text('나가기'))
          ],
        ),
      ),
    );
    //   return SafeArea(
    //       child: Stack(children: <Widget>[
    //     const Column(mainAxisSize: MainAxisSize.max, children: [
    //       Expanded(
    //         child: GoogleMap(
    //           mapType: MapType.normal,
    //           initialCameraPosition: CameraPosition(
    //             target: LatLng(37.50508097213444, 126.95493073306663),
    //             zoom: 15.0,
    //           ),
    //           // myLocationEnabled: true,
    //           // myLocationButtonEnabled: true,
    //         ),
    //       )
    //     ]),
    //     FloatingActionButton(
    //         onPressed: () => context.go('/'), child: const Text('나가기'))
    //   ]));
  }
}
