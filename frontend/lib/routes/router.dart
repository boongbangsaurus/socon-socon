import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/routes/tab_routes.dart';
import 'package:socon/viewmodels/login_state_view_model.dart';
import 'package:socon/views/atoms/bottom_bar.dart';
import 'package:socon/views/screens/sign_in_screen.dart';
import 'package:socon/views/screens/sign_up_screen.dart';

final bool isOwner = false; // 상태 관리로 처리할 예정

final GoRouter router = GoRouter(
    initialLocation: "/",
    redirect: (BuildContext context, GoRouterState state) {
      LoginState loginState = LoginState();
      final bool loggedIn = loginState.isLoggedIn;
      final loggingIn = state.uri.toString() == '/signin';

      if (!loggedIn) return '/signin';
      if (loggedIn && loggingIn) return '/';

      return null;
    },
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return Scaffold(
              body: navigationShell,
              // bottomNavigationBar: BottomNavBar(
              //   currentIndex: navigationShell.currentIndex,
              //   onTap: (int index) {
              //     navigationShell.goBranch(index);
              //   },
              //   isOwner: isOwner,
              // ),
              bottomNavigationBar: _bottomNavBar(navigationShell),
            );
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(routes: [TabRoutes.getNearbyRoute()]),
            StatefulShellBranch(routes: [TabRoutes.getSogonMainRoute()]),
            if (isOwner)
              StatefulShellBranch(routes: [TabRoutes.getMyStoreListRoute()]),
            StatefulShellBranch(routes: [TabRoutes.getSoconBookRoute()]),
            StatefulShellBranch(routes: [
              TabRoutes.getMyInfoRoute(),
            ]),
          ]),
      GoRoute(
// path: "/",
          path: "/signin",
          builder: (BuildContext context, GoRouterState state) {
            return SignInScreen();
          }),
      GoRoute(
// path: "/",
          path: "/signup",
          builder: (BuildContext context, GoRouterState state) {
            return SignUpScreen();
          }),
      TabRoutes.getSignInRoute(),
      TabRoutes.getSignUpRoute(),
    ]);

Widget _bottomNavBar(StatefulNavigationShell navigationShell) {
  final currentRoute = navigationShell.shellRouteContext.routeMatchList;
  final bool showBottomNavBar =
      currentRoute.uri.toString() == "/info/contact" ||
          currentRoute.uri.toString() == "/info/verification" ||
          currentRoute.uri.toString() == "/info/success" ||
          currentRoute.uri.toString() == "/soconbook/detail";

  // print(currentRoute.uri.toString().runtimeType); // 타입 확인
  print(currentRoute.uri.toString());
  print(showBottomNavBar);
  // /info/contact

  if (showBottomNavBar) {
    return SizedBox.shrink();
  } else {
    return BottomNavBar(
      currentIndex: navigationShell.currentIndex,
      onTap: (int index) {
        navigationShell.goBranch(index);
      },
      isOwner: isOwner,
    );
  }
}
