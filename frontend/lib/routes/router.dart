import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/routes/tab_routes.dart';
import 'package:socon/views/atoms/bottom_bar.dart';
import 'package:socon/views/screens/sign_up_screen.dart';

// 라우트 상수 정의
const String signUpRoute = "/signup";
const String infoContactRoute = "/info/contact";
const String infoVerifyRoute = "/info/verify";
final RegExp successRegExp = RegExp(r'^/info/.*/success$');
final RegExp failRegExp = RegExp(r'^/info/.*/fail$');
const String soconBookDetailRoute = "/soconbook/detail";

// 상태 관리 예정 변수
final bool isOwner = true;
final bool isLogged = true;

final GoRouter router = GoRouter(
  initialLocation: isLogged ? "/" : signUpRoute,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: _bottomNavBar(navigationShell),
        );
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(routes: [TabRoutes.getNearbyRoute()]),
        StatefulShellBranch(routes: [TabRoutes.getSogonMainRoute()]),
        if (isOwner) StatefulShellBranch(routes: [TabRoutes.getMyStoreListRoute()]),
        StatefulShellBranch(routes: [TabRoutes.getSoconBookRoute()]),
        StatefulShellBranch(routes: [TabRoutes.getMyInfoRoute()]),
      ],
    ),
    GoRoute(
      path: signUpRoute,
      builder: (BuildContext context, GoRouterState state) {
        return SignUpScreen();
      },
    ),
  ],
);

Widget _bottomNavBar(StatefulNavigationShell navigationShell) {
  final currentRoute = navigationShell.shellRouteContext.routeMatchList;
  final bool showBottomNavBar =
      currentRoute.uri.toString() == infoContactRoute ||
          currentRoute.uri.toString() == infoVerifyRoute ||
          successRegExp.hasMatch(currentRoute.uri.toString()) ||
          failRegExp.hasMatch(currentRoute.uri.toString()) ||
          currentRoute.uri.toString() == soconBookDetailRoute;

  // 하단 네비게이션 바 숨김 여부에 따라 렌더링 결정
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
