import 'package:flutter/material.dart';


class BottomNavBar extends StatefulWidget {
  final Function(int) onTabSelected;
  BottomNavBar({super.key, required this.onTabSelected});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var tab_idx = 0;
  var is_owner = true;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      // selectedItemColor: Colors.red,
      // unselectedItemColor: Colors.grey,
      onTap: (i){
        setState(() {
          tab_idx = i;
        });
        widget.onTabSelected(i);
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.place_outlined, color: Colors.black87, size: 30), label: '주변정보'),
        BottomNavigationBarItem(icon: Icon(Icons.sms_outlined, color: Colors.black87, size: 30), label: '소곤'),
        if(is_owner) BottomNavigationBarItem(icon: Icon(Icons.storefront, color: Colors.black87, size: 30), label: ' '),
        BottomNavigationBarItem(icon: Icon(Icons.confirmation_num_outlined, color: Colors.black87, size: 30), label: '쿠폰북'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded, color: Colors.black87, size: 30), label: '내정보'),
      ],
    );
  }
}
