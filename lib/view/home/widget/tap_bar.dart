import 'package:flutter/material.dart';
import '../../../config/colors.dart';

class TapBarView extends StatelessWidget {
  final TabController tabController;
  final dynamic data;
  final Function(int)? onPress;
  final String selectedCoffeeType;

  const TapBarView({
    super.key,
    required this.tabController,
    this.data,
    this.onPress,
    required this.selectedCoffeeType,
  });

  @override
  Widget build(BuildContext context) {
    print("data $data");

    // Create a list of unique coffee types
    final uniqueCoffeeTypes = <String>{};
    final filteredData = data.where((item) {
      final coffeeType = item["coffeeType"] ?? "Cappuccino";
      if (uniqueCoffeeTypes.contains(coffeeType)) {
        return false;
      } else {
        uniqueCoffeeTypes.add(coffeeType);
        return true;
      }
    }).toList();

    return TabBar(
      controller: tabController,
      isScrollable: true,
      dividerColor: Colors.transparent,
      indicator: BoxDecoration(
        color: AppColors.submitColor,
        borderRadius: BorderRadius.circular(11),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 0,
      indicatorPadding: const EdgeInsets.symmetric(vertical: 3),
      padding: EdgeInsets.zero,
      onTap: (index) {
        if (onPress != null) {
          onPress!(index);
        }
      },
      labelStyle: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle: TextStyle(
        color: AppColors.black,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      tabs: [
        const Tab(text: "All"), // Always keep "All" as the first tab
        for (var item in filteredData)
          Tab(
            text: item["coffeeType"] ?? "Cappuccino",
          ),
      ],
    );
  }
}
