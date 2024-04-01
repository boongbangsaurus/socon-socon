import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SogonPlace with ClusterItem {
  int? id;
  final LatLng latLng;
  int? type;
  String? title;
  int? lastTime;
  String? memberName;
  int? commentCount;
  String? soconImg;
  bool? isPicked;

  SogonPlace(
      {required this.id,
      required this.latLng,
      this.type,
      this.title,
      this.lastTime,
      this.memberName,
      this.commentCount,
      this.soconImg,
      this.isPicked});

  @override
  // TODO: implement location
  LatLng get location => latLng;
}
