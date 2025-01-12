import 'package:flutter/material.dart';

import '../../../config/colors.dart';

class ChocolateChoiceSection extends StatelessWidget {
  final TabController tabController;
  final void Function(int) onPress;
   ChocolateChoiceSection({super.key, required this.tabController, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return     TabBar(
      controller: tabController,
      isScrollable: true,
      dividerColor: Colors.transparent,
      indicator: BoxDecoration(
        color: AppColors.addMark,
        borderRadius: BorderRadius.circular(21),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 0,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.symmetric(horizontal: 11),
      labelStyle: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle: TextStyle(
        color: AppColors.black,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      onTap: onPress,
      tabs: List.generate(
        3,
            (index) {
          final titles = ["White Chocolate", "Milk Chocolate", "Dark Chocolate"];
          return Tab(
            child: AnimatedBuilder(
              animation: tabController,
              builder: (context, child) {
                final isSelected = tabController.index == index;
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 11.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: isSelected ?Colors.transparent:AppColors.addMark),

                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: Text(
                    titles[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? AppColors.white : AppColors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
