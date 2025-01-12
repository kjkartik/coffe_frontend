import 'dart:developer';
import 'dart:ui';

import 'package:coffee_app_bloc/config/colors.dart';
import 'package:coffee_app_bloc/config/routes/routes_name.dart';
import 'package:coffee_app_bloc/config/utils/showMessage/snack_bar.dart';
import 'package:coffee_app_bloc/config/utils/sqflite/sqlite.dart';
import 'package:coffee_app_bloc/view/itemDetail/widget/coffee_view.dart';
import 'package:coffee_app_bloc/view/itemDetail/widget/helper_widget.dart';
import 'package:coffee_app_bloc/view/itemDetail/widget/size_Quantity_section.dart';
import 'package:coffee_app_bloc/view/itemDetail/widget/tab_bar.dart';
import 'package:flutter/material.dart';

class ItemDetailView extends StatefulWidget {
  final dynamic data;

  const ItemDetailView({
    super.key,
    required this.data,
  });

  @override
  State<ItemDetailView> createState() => _ItemDetailViewState();
}

class _ItemDetailViewState extends State<ItemDetailView> with TickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 1;
  int totalQuantity = 1;
  int basePrice = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _updateBasePrice(); // Initialize the base price
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _updateBasePrice() {
    final priceKey = selectedIndex == 0
        ? "small"
        : selectedIndex == 1
        ? "medium"
        : "large";
    basePrice = double.tryParse(widget.data["price"]?[priceKey]?.toString() ?? "0")!.round();
  }

  int get totalPrice => basePrice * totalQuantity;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height / 31),
              CoffeeCardView(
                data: widget.data,
                tabIndex: _tabController.index,
              ),
              const SizedBox(height: 19),
              Text(
                "Description",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 31),
              Text(
                widget.data["details"] ?? "No details available.",
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 31),
              Text(
                "Choice of Chocolate",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 11),
              ChocolateChoiceSection(
                tabController: _tabController,
                onPress: (_) => setState(() {}),
              ),
              const SizedBox(height: 31),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  sizeSelector(
                    context: context,
                    selectedIndex: selectedIndex,
                    onSizeSelected: (index) {
                      setState(() {
                        selectedIndex = index;
                        _updateBasePrice();
                      });
                    },
                  ),
                  const SizedBox(width: 16),
                  quantitySelector(
                    context: context,
                    totalQuantity: totalQuantity,
                    onIncrease: () {
                      setState(() {
                        totalQuantity++;
                      });
                    },
                    onDecrease: () {
                      if (totalQuantity > 1) {
                        setState(() {
                          totalQuantity--;
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: height / 21),
              BottomSection(
                width: width,
                height: height,
                price: totalPrice.toDouble(),
                onBuyNow: () async {
                dbHelper.addToCart(widget.data["coffeeName"], {"image": widget.data["imageId"],
                  "coffeeType":widget.data["coffeeType"],"coffeeName":widget.data["coffeeName"]});
                MessageUtils.success(context: context, message: "Coffee Added Successfully");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

