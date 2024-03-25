import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';

// 탭 바 화면 위젯
class TabBarScreen extends StatefulWidget {
  final Map<String, Widget> contents;

  const TabBarScreen({super.key, required this.contents});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

// 탭 바 화면 상태 클래스
class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController; // 탭 컨트롤러
  late List<Widget> tabs; // 탭 위젯 목록
  late Map<String, Widget> tabViews; // 탭 뷰 목록

  @override
  void initState() {
    super.initState();
    tabs =
        widget.contents.entries.map((entry) => Tab(text: entry.key)).toList();
    tabViews = widget.contents; // 탭 뷰 설정
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 100),
    ); // 탭 컨트롤러 초기화
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          // margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
          child: TabBar(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            indicatorColor: AppColors.YELLOW,
            indicatorSize: TabBarIndicatorSize.tab,
            controller: _tabController,
            tabs: tabs,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: tabViews.values.toList(),
          ),
        )
      ],
    );
  }
}

// 탭 내용 위젯
class TabContent extends StatelessWidget {
  final String title; // 탭 제목
  const TabContent({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 36),
      ),
    );
  }
}

// author: 김아현

