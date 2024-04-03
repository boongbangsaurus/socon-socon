import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socon/routes/tab_routes.dart';
import 'package:socon/viewmodels/login_state_view_model.dart';
import 'package:socon/views/atoms/bottom_bar.dart';

final bool isOwner = true; // 상태 관리로 처리할 예정

// Future<bool> getIsOwner() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getBool('isOwner') ?? false; // 기본값은 false로 설정
// }
// 라우트 상수 정의
const String signUpRoute = "/signup";
const String infoContactRoute = "/info/contact";
const String infoVerifyRoute = "/info/verify";
final RegExp successRegExp = RegExp(r'^/info/.*/success$');
final RegExp failRegExp = RegExp(r'^/info/.*/fail$');
const String soconBookDetailRoute = "/soconbook/detail";

final GoRouter router = GoRouter(
    initialLocation: "/",
    redirect: (BuildContext context, GoRouterState state) {
      final loginState = Provider.of<LoginState>(context, listen: false);
      // final loginState = Provider.of<LoginState>(context, listen: true);
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
              bottomNavigationBar: _bottomNavBar(navigationShell, context),
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
      TabRoutes.getSerachAddressRoute(),
    ]);

Widget _bottomNavBar(StatefulNavigationShell navigationShell, BuildContext context) {
  final currentRoute = navigationShell.shellRouteContext.routeMatchList;
  final bool showBottomNavBar =
      currentRoute.uri.toString() == infoContactRoute ||
          currentRoute.uri.toString() == infoVerifyRoute ||
          successRegExp.hasMatch(currentRoute.uri.toString()) ||
          failRegExp.hasMatch(currentRoute.uri.toString()) ||
          currentRoute.uri.toString() == soconBookDetailRoute ||
          currentRoute.uri.toString() == "/sogon";

  debugPrint(
      '################## 현재 uri/showBottomNavBar ##############################');
  // print(currentRoute.uri.toString().runtimeType); // 타입 확인
  print("현재 route ${currentRoute.uri.toString()}");
  print(showBottomNavBar);
  // /info/contact
  debugPrint(
      '################## 현재 uri/showBottomNavBar ##############################');

  // 하단 네비게이션 바 숨김 여부에 따라 렌더링 결정
  if (showBottomNavBar) {
    return SizedBox.shrink();
  } else {
    return BottomNavBar(
      currentIndex: navigationShell.currentIndex,
      onTap: (int index) {
        // print("haha ${navigationShell.shellRouteContext.routerState}");
        final initialRoute = TabRoutes.getInitialRouteForIndex(index);
        // navigationShell.goBranch(index);
        GoRouter.of(context).goNamed(initialRoute);
      },
      isOwner: isOwner,
    );
  }
}
