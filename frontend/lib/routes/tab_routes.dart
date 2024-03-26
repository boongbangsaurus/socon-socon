import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/views/screens/contact/contact_sucess_screen.dart';
import 'package:socon/views/screens/my_info_screen.dart';
import 'package:socon/views/screens/my_store_list_screen.dart';
import 'package:socon/views/screens/socon_book_screen.dart';
import 'package:socon/views/screens/sogon_main_screen.dart';
import '../views/screens/nearby_info_screen.dart';

class TabRoutes {
  static RouteBase getNearbyRoute() {
    return GoRoute(
        // path: "/",
        path: "/",
        builder: (BuildContext context, GoRouterState state) {
          return NearbyInfoScreen();
        });
  }

  static RouteBase getSogonMainRoute() {
    return GoRoute(
        path: "/sogon",
        builder: (BuildContext context, GoRouterState state) {
          return SogonMainScreen();
        });
  }

  static RouteBase getSoconBookRoute() {
    return GoRoute(
        path: "/soconbook",
        builder: (BuildContext context, GoRouterState state) {
          return SoconBookScreen();
        });
  }

  static RouteBase getMyInfoRoute() {
    return GoRoute(
        name: "myInfo",
        path: "/info",
        builder: (BuildContext context, GoRouterState state) {
          return MyInfoScreen();
        },
        routes: [getContactRoute()]);
  }

  static RouteBase getContactRoute() {
    return GoRoute(
      name: "contact",
      path: "contact",
      builder: (BuildContext context, GoRouterState state) {
        return ContactSuccessScreen();
      },
    );
  }

  static RouteBase getMyStoreListRoute() {
    return GoRoute(
        path: "/stores",
        builder: (BuildContext context, GoRouterState state) {
          return MyStoreListScreen();
        });
  }
}
