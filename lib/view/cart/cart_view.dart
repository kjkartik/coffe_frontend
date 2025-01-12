import 'dart:developer';

import 'package:coffee_app_bloc/config/utils/showMessage/snack_bar.dart';
import 'package:coffee_app_bloc/config/utils/sqflite/sqlite.dart';
import 'package:coffee_app_bloc/view/cart/widget/helper_widget.dart';
import 'package:coffee_app_bloc/view/cart/widget/list_view.dart';
import 'package:flutter/material.dart';
import 'package:coffee_app_bloc/config/colors.dart';
import 'package:coffee_app_bloc/config/icons.dart';
import '../../config/app_url.dart';
import '../../config/images.dart';
import '../../config/routes/routes_name.dart';
import '../../repostory/getItem/item_http_api_repository.dart';
import '../../repostory/getItem/item_repo.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final List<String> _selectedItems = [];
  List<Map<String, dynamic>> cartCoffees = [];
  Map<String, dynamic>? data;

  // Toggle item selection for favorites
  void _toggleSelection(String itemName) {
    setState(() {
      if (_selectedItems.contains(itemName)) {
        _selectedItems.remove(itemName);
      } else {
        _selectedItems.add(itemName);
      }
    });
    log("Selected Items: $_selectedItems");
  }

  // Update quantity for a specific item
  void _updateQuantity(int index, int delta) {
    setState(() {
      cartCoffees[index]['quantity'] += delta;
      if (cartCoffees[index]['quantity'] < 0) {
        cartCoffees[index]['quantity'] = 0; // Prevent negative quantity
      }
    });
  }

  Future<void> getDataFromApi() async {
    ItemRepo itemRepo = GetItemHttpApiRepository();
    data = await itemRepo.getItems(AppUrl.getItem);
    setState(() {});
  }

  Future<void> loadCartData() async {
    var dbData = await dbHelper.getAllDataAsMapCart();
    cartCoffees = dbData.entries
        .map((entry) => {
              "key": entry.key,
              "value": entry.value,
              "quantity": 1, // Initialize quantity to 1 for each cart item
            })
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await getDataFromApi();
      await loadCartData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height / 31),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Icon(
                    AppIcons.back,
                    size: 21,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  "Cart",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
            SizedBox(height: height / 31),
            Text(
              "Items (${cartCoffees.length})",
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            SizedBox(height: height / 21),
            cartCoffees.isEmpty || data == null
                ? Center(child: Image.asset(AppImages.emptyGif))
                : Expanded(
                    child: ListView.builder(
                    itemCount: cartCoffees.length,
                    itemBuilder: (_, index) {
                      var coffeeKey = cartCoffees[index]["key"];
                      var coffeeData = data!["data"].firstWhere(
                          (item) => item["coffeeName"] == coffeeKey,
                          orElse: () => null);

                      if (coffeeData != null) {
                        return CoffeeCard(
                          coffeeData: coffeeData,
                          quantity: cartCoffees[index]['quantity'],
                          onAdd: () => _updateQuantity(index, 1),
                          onSubtract: () => _updateQuantity(index, -1),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutesName.itemDetailView,
                              arguments: data!["data"][index],
                            );
                          },
                          isSelected:
                              _selectedItems.contains(coffeeData["coffeeName"]),
                          onSelectToggle: () =>
                              _toggleSelection(coffeeData["coffeeName"]),
                          onDelete: () {
                             MessageUtils.error(context: context, message:coffeeData["coffeeName"]+ " Remove Successfully" );
                            dbHelper.deleteDataCart(coffeeData["coffeeName"]);
                            getDataFromApi();
                            loadCartData();
                            setState(() {});
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  )),
          ],
        ),
      ),
    );
  }
}
