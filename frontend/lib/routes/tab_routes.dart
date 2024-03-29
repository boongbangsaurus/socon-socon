import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/views/atoms/qr_code.dart';
import 'package:socon/views/screens/bossVerification/boss_verification.dart';
import 'package:socon/views/screens/bossVerification/boss_verification_fail_screen.dart';
import 'package:socon/views/screens/contact/contact_fail_screen.dart';
import 'package:socon/views/screens/contact/contact_sucess_screen.dart';
import 'package:socon/views/screens/myStore/store_detail_screen.dart';
import 'package:socon/views/screens/my_info_screen.dart';
import 'package:socon/views/screens/my_store_list_screen.dart';
import 'package:socon/views/screens/soconBook/socon_book_detail_screen.dart';
import 'package:socon/views/screens/soconBook/socon_book_screen.dart';
import 'package:socon/views/screens/sogon_main_screen.dart';
import 'package:socon/views/screens/stores/store_detail.dart';
import '../views/screens/bossVerification/boss_verification_success_screen.dart';
import '../views/screens/contact/contact_screen.dart';
import '../views/screens/nearby_info_screen.dart';

class TabRoutes {
  static RouteBase getNearbyRoute() {
    return GoRoute(
      // path: "/",
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return NearbyInfoScreen();
      },
      routes: [
        getStoreDetailRoute(),
      ]
    );
  }

  static RouteBase getStoreDetailRoute() {
    return GoRoute(
        // path: "/",
        path: "detail/:storeId",

        builder: (BuildContext context, GoRouterState state) {
          return StoreDetailScreen(state.pathParameters['storeId']);
        });
  }

  // static RouteBase getNearbyRoute() {
  //   return GoRoute(
  //       // path: "/",
  //       path: "store",
  //       builder: (BuildContext context, GoRouterState state) {
  //         return NearbyInfoScreen();
  //       });
  // }

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
        },
        routes: [
          getMySoconDetailRoute(),
        ]);
  }

  static RouteBase getMySoconDetailRoute() {
    return GoRoute(
        name: "soconbookDetail",
        path: "detail",
        builder: (BuildContext context, GoRouterState state) {
          return SoconBookDetailScreen();
        });
  }

  static RouteBase getMyInfoRoute() {
    return GoRoute(
        name: "myInfo",
        path: "/info",
        builder: (BuildContext context, GoRouterState state) {
          return MyInfoScreen();
        },
        routes: [
          getContactRoute(),
          getBossVerification(),
        ]);
  }

  static RouteBase getContactRoute() {
    return GoRoute(
        name: "contact",
        path: "contact",
        builder: (BuildContext context, GoRouterState state) {
          return ContactScreen();
        },
        routes: [
          getContactSuccessRoute(),
          getContactFailRoute(),
        ]);
  }

  static RouteBase getContactSuccessRoute() {
    return GoRoute(
      name: "contactSuccess",
      path: "success",
      builder: (BuildContext context, GoRouterState state) {
        return ContactSuccessScreen();
      },
    );
  }

  static RouteBase getContactFailRoute() {
    return GoRoute(
      name: "contactFail",
      path: "fail",
      builder: (BuildContext context, GoRouterState state) {
        return ContactFailScreen();
      },
    );
  }

  static RouteBase getMyStoreListRoute() {
    return GoRoute(
        path: "/myStores",
        builder: (BuildContext context, GoRouterState state) {
          return const MyStoreListScreen();
        },
        routes: [getMyStoreDetailRoute()]);
  }

  static RouteBase getMyStoreDetailRoute() {
    return GoRoute(
        // path: "/",
        path: "detail/:storeId",
        builder: (BuildContext context, GoRouterState state) {
          return MyStoreDetailScreen(state.pathParameters['storeId']);
        });
  }

  static RouteBase getBossVerification() {
    return GoRoute(
        name: "verify",
        path: "verify",
        builder: (BuildContext context, GoRouterState state) {
          return BossVerification();
        },
        routes: [
          getVerifySuccessRoute(),
        ]);
  }

  static RouteBase getVerifySuccessRoute() {
    return GoRoute(
      name: "verifySuccess",
      path: "success",
      builder: (BuildContext context, GoRouterState state) {
        return BossVerificationSuccessScreen();
      },
    );
  }

  static RouteBase getVerifyFailRoute() {
    return GoRoute(
        name: "verifyFail",
        path: "fail",
        builder: (BuildContext context, GoRouterState state) {
          return BossVerificationFailScreen();
        });
  }
}
