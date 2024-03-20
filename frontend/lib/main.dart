import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/view/atoms/tab.dart';
import './utils/toast_utils.dart';

void main() {
  runApp(const MyApp());
}

// GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // builder: FToastBuilder(),
      // navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Socon',

      theme: ThemeData(
          // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber),
          // primaryColor: AppColors.mainYellow
          // useMaterial3: true, // 이 줄을 주석 처리하거나 삭제하여 사용하시는 버전에 맞게 설정하세요.
          ),
      home: Scaffold(
        // backgroundColor: AppColors.YELLOW,
        backgroundColor: AppColors.WHITE,
        body: Container(
          width: ResponsiveUtils.getWidthPercent(context, 100),
          height: ResponsiveUtils.getHeightPercent(context, 100),
          child: const TabBarScreen(
            contents: {
              "Tab 1": TabContent(title: "쉽지않다111"),
              "Tab 2": TabContent(title: "쉽지않다222"),
              // "Tab 3": TabContent(title: "쉽지않다333"),
            },
          ),

          // decoration: BoxDecoration(
          //   border: Border.all(
          //     width:1.0,
          //     color: AppColors.WHITE
          //   )
          // ),
          // child: Column(
          //   // 괄호 추가
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text(
          //       '소콘소콘',
          //       style: TextStyle(
          //         fontFamily: "BagelFatOne",
          //         fontSize: ResponsiveUtils.calculateResponsiveFontSize(
          //             context, FontSizes.LOGO),
          //         color: AppColors.WHITE,
          //       ),
          //     ),
          //     Text(
          //       '소소한 우리 동네 기프티콘',
          //       style: TextStyle(
          //         fontFamily: "Pretendard",
          //         fontWeight: FontWeight.w500,
          //         fontSize: ResponsiveUtils.calculateResponsiveFontSize(
          //             context, FontSizes.XSMALL),
          //         color: AppColors.WHITE,
          //       ),
          //     ),
          //     // Container(
          //     //     width: ResponsiveUtils.getHeightWithPixels(context, 200),
          //     //     height: ResponsiveUtils.getHeightWithPixels(context, 60),
          //     //     color: AppColors.INDIGO200),
          //   ],
          // ), // 괄호 추가
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreen();
  }
}

class _MainScreen extends State<MainScreen> {
  // final GlobalKey<_ToastState> _toastKey = GlobalKey<_ToastState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Toast"),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text("Show Toast"),
            onPressed: () {
              ToastUtil.showCustomToast(context, "availableSoco");
            },
          ),
        )
    );
  }
}



//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Socon',
//       theme: ThemeData(
//           // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber),
//           // primaryColor: AppColors.mainYellow
//           // useMaterial3: true, // 이 줄을 주석 처리하거나 삭제하여 사용하시는 버전에 맞게 설정하세요.
//           ),
//       home: Scaffold(
//         backgroundColor: AppColors.YELLOW,
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               showToast(context);
//             },
//             child: Text('Show Toast'),
//           ),
//         )
//         // body: Container(
//         //   width: ResponsiveUtils.getWidthPercent(context, 100),
//         //   height: ResponsiveUtils.getHeightPercent(context, 100),
//         //   // decoration: BoxDecoration(
//         //   //   border: Border.all(
//         //   //     width:1.0,
//         //   //     color: AppColors.WHITE
//         //   //   )
//         //   // ),
//         //   child: Column(
//         //     // 괄호 추가
//         //     mainAxisAlignment: MainAxisAlignment.center,
//         //     crossAxisAlignment: CrossAxisAlignment.center,
//         //     children: [
//         //       Text(
//         //         '소콘소콘',
//         //         style: TextStyle(
//         //           fontFamily: "BagelFatOne",
//         //           fontSize: ResponsiveUtils.calculateResponsiveFontSize(
//         //               context, FontSizes.LOGO),
//         //           color: AppColors.WHITE,
//         //         ),
//         //       ),
//         //       Text(
//         //         '소소한 우리 동네 기프티콘',
//         //         style: TextStyle(
//         //           fontFamily: "Pretendard",
//         //           fontWeight: FontWeight.w500,
//         //           fontSize: ResponsiveUtils.calculateResponsiveFontSize(
//         //               context, FontSizes.XSMALL),
//         //           color: AppColors.WHITE,
//         //         ),
//         //       ),
//         //       // Container(
//         //       //     width: ResponsiveUtils.getHeightWithPixels(context, 200),
//         //       //     height: ResponsiveUtils.getHeightWithPixels(context, 60),
//         //       //     color: AppColors.INDIGO200),
//         //     ],
//         //   ), // 괄호 추가
//         // ),
//       ),
//     );
//   }
// }
