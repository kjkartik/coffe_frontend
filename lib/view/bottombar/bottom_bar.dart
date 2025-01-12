import 'package:coffee_app_bloc/config/colors.dart';
import 'package:coffee_app_bloc/view/home/home_view.dart';
import 'package:coffee_app_bloc/view/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../cart/cart_view.dart';
import '../fav/favourite.dart';
import '../notification/notification_view.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeView(),
    FavoritesScreen(),
    CartView(),
    NotificationScreen(),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("hint ");
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: WaterDropNavBar(
        waterDropColor: AppColors.submitColor,
        barItems: [
          BarItem(
            filledIcon: Icons.home,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
            filledIcon: Icons.favorite,
            outlinedIcon: Icons.favorite_border,
          ),
          BarItem(
            filledIcon: Icons.shopping_bag,
            outlinedIcon: Icons.shopping_bag_outlined,
          ),
          BarItem(
            filledIcon: Icons.notifications_sharp,
            outlinedIcon: Icons.notifications_none_sharp,
          ),
        ],
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemSelected,
      ),
    );
  }
}
