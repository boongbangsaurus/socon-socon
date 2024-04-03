import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/views/atoms/qr_code.dart';
import 'package:socon/views/screens/bossVerification/boss_verification.dart';
import 'package:socon/views/screens/bossVerification/boss_verification_fail_screen.dart';
import 'package:socon/views/screens/contact/contact_fail_screen.dart';
import 'package:socon/views/screens/contact/contact_sucess_screen.dart';
import 'package:socon/views/screens/kpostal_screen.dart';
import 'package:socon/views/screens/myStore/publish_socon_screen.dart';
import 'package:socon/views/screens/myStore/store_detail_screen.dart';
import 'package:socon/views/screens/myStore/store_product_register.dart';
import 'package:socon/views/screens/my_info_screen.dart';
import 'package:socon/views/screens/my_store_list_screen.dart';
import 'package:socon/views/screens/sign_in_screen.dart';
import 'package:socon/views/screens/sign_up_screen.dart';
import 'package:socon/views/screens/soconBook/socon_book_detail_screen.dart';
import 'package:socon/views/screens/soconBook/socon_book_screen.dart';
import 'package:socon/views/screens/sogon/sogon_register_screen.dart';
import 'package:socon/views/screens/sogon_main_screen.dart';
import 'package:socon/views/screens/stores/buy_menu_screen.dart';
import 'package:socon/views/screens/stores/store_detail.dart';
import '../views/screens/bossVerification/boss_verification_success_screen.dart';
import '../views/screens/contact/contact_screen.dart';
import '../views/screens/nearby_info_screen.dart';

class TabRoutes {
  static RouteBase getNearbyRoute() {
    return GoRoute(
        path: "/",
        builder: (BuildContext context, GoRouterState state) {
          return NearbyInfoScreen();
        },
        routes: [
          getStoreDetailRoute(),
        ]);
  }

  static RouteBase getStoreDetailRoute() {
    return GoRoute(
        // path: "/",
        path: "detail/:storeId",
        builder: (BuildContext context, GoRouterState state) {
          return StoreDetailScreen(state.pathParameters['storeId']);
        },
        routes: [
          getBuyMenuDetailRoute(),
        ]);
  }

  static RouteBase getBuyMenuDetailRoute() {
    return GoRoute(
        path: "menu/:menuId",
        builder: (BuildContext context, GoRouterState state) {
          return BuyMenuDetailScreen(state.pathParameters['menuId']!,
              state.pathParameters['storeId']!);
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
        },
        routes: [
          getSogonRegisterRoute(),
        ]);
  }

  static RouteBase getSogonRegisterRoute() {
    return GoRoute(
        name: "sogonRegister",
        path: "register",
        builder: (BuildContext context, GoRouterState state) {
          return SogonRegisterScreen();
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
        path: "detail/:soconId",
        builder: (BuildContext context, GoRouterState state) {
          return SoconBookDetailScreen(state.pathParameters['soconId']);
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

  // 내점포 Listssss
  static RouteBase getMyStoreListRoute() {
    return GoRoute(
        path: "/myStores",
        builder: (BuildContext context, GoRouterState state) {
          return const MyStoreListScreen();
        },
        routes: [getMyStoreDetailRoute()]);
  }


  // 내점포 Lists -> 내점포
  static RouteBase getMyStoreDetailRoute() {
    return GoRoute(
        path: ":storeId",
        builder: (BuildContext context, GoRouterState state) {
          return MyStoreDetailScreen(state.pathParameters['storeId']!);
        },
        routes: [
          getMenuDetailRoute(),
          getProductRegisterRoute(),
        ]);
  }


  static RouteBase getMenuDetailRoute() {
    return GoRoute(
        path: "menu/:menuId",
        builder: (BuildContext context, GoRouterState state) {
          return PublishSoconScreen(state.pathParameters['menuId']!,
              state.pathParameters['storeId']!);
        });
  }


  static RouteBase getProductRegisterRoute() {
    return GoRoute(
        path: "register",
        builder: (BuildContext context, GoRouterState state) {
          return ProductRegister(state.pathParameters['storeId']!,);
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

  static RouteBase getSignInRoute() {
    return GoRoute(
        // path: "/",
        path: "/signin",
        builder: (BuildContext context, GoRouterState state) {
          return SignInScreen();
        });
  }

  static RouteBase getSignUpRoute() {
    return GoRoute(
        // path: "/",
        path: "/signup",
        builder: (BuildContext context, GoRouterState state) {
          return SignUpScreen();
        });
  }

  static RouteBase getSerachAddressRoute() {
    return GoRoute(
        path: "/kopo",
        builder: (BuildContext context, GoRouterState state) {
          return KpostalScreen();
        });
  }
}
