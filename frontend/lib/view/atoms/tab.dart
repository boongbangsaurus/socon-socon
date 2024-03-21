import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';

class TabBarScreen extends StatefulWidget {
  final Map<String, Widget> contents;
  const TabBarScreen({super.key, required this.contents});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Widget> tabs;
  late Map<String, Widget> tabViews;

  @override
  void initState() {
    super.initState();
    tabs = widget.contents.entries.map((entry) => Tab(text: entry.key)).toList();
    tabViews = widget.contents;
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 100),
    );
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
          margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
          child: TabBar(
            overlayColor : MaterialStateProperty.all(Colors.transparent),
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

class TabContent extends StatelessWidget {
  final String title;
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
