import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import '../../../config/icons.dart';
import 'helper_widget.dart';

class BottomSection extends StatelessWidget {
  final double width;
  final double height;
  final double price;
  final VoidCallback onBuyNow;

  const BottomSection({
    Key? key,
    required this.width,
    required this.height,
    required this.price,
    required this.onBuyNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            Text(
              "Price",
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.grey,
                  fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                Text(
                  "\$",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.addMark),
                ),
                const SizedBox(width: 5),
                Text(
                  price.toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: onBuyNow,
          child: Container(
            width: width / 2.5,
            height: height / 17,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.addMark,
                borderRadius: BorderRadius.circular(21)),
            child: Text(
              "Add To Cart",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  color: AppColors.white),
            ),
          ),
        ),
      ],
    );
  }
}




Widget sizeSelector({
  required BuildContext context,
  required int selectedIndex,
  required ValueChanged<int> onSizeSelected,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(left: 11),
        child: Text(
          "Size",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      const SizedBox(height: 11),
      Row(
        children: [
          for (var i = 0; i < 3; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: widgetCircleBackground(
                context: context,
                child: Text(
                  i == 0
                      ? "S"
                      : i == 1
                      ? "M"
                      : "L",
                  style: TextStyle(
                    color: i == selectedIndex
                        ? AppColors.white
                        : AppColors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPress: () => onSizeSelected(i),
                color: i == selectedIndex
                    ? AppColors.addMark
                    : AppColors.grey.withOpacity(0.4),
              ),
            ),
        ],
      ),
    ],
  );
}

// Extracted Function for Quantity Selector
Widget quantitySelector({
  required BuildContext context,
  required int totalQuantity,
  required VoidCallback onIncrease,
  required VoidCallback onDecrease,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Text(
        "Quantity",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 11),
      Row(
        children: [
          widgetCircleBackground(
            context: context,
            child: Icon(
              AppIcons.negative,
              color: AppColors.white,size: 16,
            ),
            color: AppColors.addMark,
            onPress: onDecrease,
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 21),
          Text(
            totalQuantity.toString(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 21),
          widgetCircleBackground(
            context: context,
            child: Icon(
              AppIcons.add,
              color: AppColors.white,size: 16,
            ),
            color: AppColors.addMark,
            onPress: onIncrease,
          ),
        ],
      ),
    ],
  );
}

