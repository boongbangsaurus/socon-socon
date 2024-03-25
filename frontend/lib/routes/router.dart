import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/routes/tab_routes.dart';
import 'package:socon/views/atoms/bottom_bar.dart';

final bool isOwner = true; // 상태 관리로 처리할 예정

final GoRouter router =
    GoRouter(initialLocation: "/nearby", routes: <RouteBase>[
  StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: BottomNavBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (int index) {
              navigationShell.goBranch(index);
            },
            isOwner: isOwner,
          ),
        );
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(routes: [TabRoutes.getNearbyRoute()]),
        StatefulShellBranch(routes: [TabRoutes.getSogonMainRoute()]),
        if (isOwner)
          StatefulShellBranch(routes: [TabRoutes.getMyStoreListRoute()]),
        StatefulShellBranch(routes: [TabRoutes.getSoconBookRoute()]),
        StatefulShellBranch(routes: [TabRoutes.getMyInfoRoute()]),
      ])
]);
