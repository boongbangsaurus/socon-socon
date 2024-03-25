import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isOwner;

  const BottomNavBar(
      {super.key,
      required this.currentIndex,
      required this.onTap,
      this.isOwner = false});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      // selectedItemColor: Colors.red,
      // unselectedItemColor: Colors.grey,
      onTap: widget.onTap,
      currentIndex: widget.currentIndex,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
            icon: Icon(Icons.place_outlined, color: Colors.black87, size: 30),
            label: '주변정보'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.sms_outlined, color: Colors.black87, size: 30),
            label: '소곤'),
        if (widget.isOwner)
          const BottomNavigationBarItem(
              icon: Icon(Icons.storefront, color: Colors.black87, size: 30),
              label: '점포목록'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num_outlined,
                color: Colors.black87, size: 30),
            label: '쿠폰북'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded,
                color: Colors.black87, size: 30),
            label: '내정보'),
      ],
    );
  }
}
