import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/view/screens/nearby_info_screen.dart';


final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return NearbyInfoScreen();
    },
    // routes: <RouteBase>[
    //   GoRoute(
    //     path: 'details',
    //     builder: (BuildContext context, GoRouterState state) {
    //       return const HomeScreen();
    //     },
    //   ),
    // ],
  ),
],);