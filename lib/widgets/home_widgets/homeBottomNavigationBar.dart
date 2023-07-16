import 'package:flutter/material.dart';

class HomeBottomNavigationBar extends StatelessWidget {
final int selectedPageIndex;
final Function(int) selectePage;
 
  const HomeBottomNavigationBar({super.key, required this.selectedPageIndex, required this.selectePage});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
          currentIndex: selectedPageIndex,
          onTap: selectePage,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              label: "معاملاتي",
              icon: const Icon(Icons.wifi_protected_setup_sharp),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              label: "منتجاتي",
              icon: const Icon(Icons.category_sharp),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              label: "طلباتي",
              icon: const Icon(Icons.auto_awesome_motion),
            )
          ]);
  }
}