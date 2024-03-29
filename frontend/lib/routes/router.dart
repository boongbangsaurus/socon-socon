import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:socon/routes/tab_routes.dart';
import 'package:socon/viewmodels/login_state_view_model.dart';
import 'package:socon/views/atoms/bottom_bar.dart';

final bool isOwner = false; // 상태 관리로 처리할 예정

final GoRouter router = GoRouter(
    initialLocation: "/",
    redirect: (BuildContext context, GoRouterState state) {
      final loginState = Provider.of<LoginState>(context, listen: false);
      final bool loggedIn = loginState.isLoggedIn;
      debugPrint('####################### router #########################');
      print('isSignIned ######### $loggedIn');
      print(state.uri.toString());
      debugPrint('####################### router #########################');

      final loggingIn = state.uri.toString() == '/signin';
      final signupIng = state.uri.toString() == '/signup';

      if (!loggedIn) {
        if (signupIng) {
          return '/signup';
        } else
          return '/signin';
      }

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
      TabRoutes.getSignInRoute(),
      TabRoutes.getSignUpRoute(),
    ]);

Widget _bottomNavBar(StatefulNavigationShell navigationShell) {
  final currentRoute = navigationShell.shellRouteContext.routeMatchList;

  final regExp = RegExp(r'^/info/.*/success$');
  final regExp2 = RegExp(r'^/info/.*/fail$');
  final bool showBottomNavBar =
      currentRoute.uri.toString() == "/info/contact" ||
          currentRoute.uri.toString() == "/info/verify" ||
          regExp.hasMatch(currentRoute.uri.toString()) ||
          regExp2.hasMatch(currentRoute.uri.toString()) ||
          currentRoute.uri.toString() == "/soconbook/detail";

  debugPrint(
      '################## 현재 uri/showBottomNavBar ##############################');
  // print(currentRoute.uri.toString().runtimeType); // 타입 확인
  print(currentRoute.uri.toString());
  print(showBottomNavBar);
  // /info/contact
  debugPrint(
      '################## 현재 uri/showBottomNavBar ##############################');

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
